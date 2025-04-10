import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_mac_intergrator/core/constants/constantsCatalog.dart';
import 'package:process_run/shell.dart';

import 'package:google_maps_mac_intergrator/core/blocs/generic_cubit/generic_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_mac_intergrator/core/error/exception_handler.dart';
import 'package:google_maps_mac_intergrator/core/extentions/string_extention.dart';

import '../../core/constants/data.dart';

class HomeScreenViewModel {
  GenericCubit<String?> directoryPickCubit = GenericCubit(null);
  GenericCubit<String?> platformConfigs = GenericCubit(null);
  GenericCubit<String?> pubspecConfigs = GenericCubit(null);
  GenericCubit<String?> googleMapsScreenCubit = GenericCubit(null);
  GenericCubit<String?> buttonCubit = GenericCubit(null);
  TextEditingController apiKeyConroller = TextEditingController();

  Shell? shell;
  Future<void> pickDirectory() async {
    directoryPickCubit.onLoadingState();
    ExceptionHandler.handleCubitException(
      directoryPickCubit,
      () async {
        var result = await FilePicker.platform.getDirectoryPath();
        if (result.nullOrEmpty) {
          directoryPickCubit.onErrorState(Constantscatalog.noDir);
          return;
        }
        directoryPickCubit.onUpdateData(result);
        // addAndroidConfigs(
        //     result ?? "", Constantscatalog.androidGoogleMapsKeySnippet("key"));
      },
    );
  }

  Future<bool> addGoogleMaps() async {
    var dir = directoryPickCubit.state.data;
    var pubspec = File('$dir/pubspec.yaml');
    if (!await pubspec.exists()) {
      pubspecConfigs.onErrorState(Constantscatalog.noPubspec);
      return false;
    }
    shell = Shell(workingDirectory: dir);
    var result = await shell!.run(Constantscatalog.googleMapsAddLine);
    if (result.first.exitCode != 0) {
      pubspecConfigs.onErrorState("${result.first.stderr}");
      return false;
    }
    pubspecConfigs.onUpdateData(Constantscatalog.done);
    return true;
  }

  Future<bool> addIosAndroidConfigs(
      String fileDir, RegExp pattern, String content,
      {String imports = ""}) async {
    var settingsFile = File(fileDir);
    if (!await settingsFile.exists()) {
      platformConfigs.onErrorState("The file $fileDir isn't found");
      return false;
    }
    String fileContent = await settingsFile.readAsString();
    var match = pattern.firstMatch(fileContent);
    if (match == null) {
      platformConfigs.onErrorState("something wrong in $fileDir");
      return false;
    }
    final insertionPoint = match.end;
    fileContent =
        '$imports${fileContent.substring(0, insertionPoint)}\n$content${fileContent.substring(insertionPoint)}';
    await settingsFile.writeAsString(fileContent);
    return true;
  }

  Future<bool> addMapsScreen() async {
    googleMapsScreenCubit.onLoadingState();
    // RegExp regExp = RegExp(Constantscatalog.homeScreenRegex);
    var mainFile = File("${directoryPickCubit.state.data}/lib/main.dart");
    if (!await mainFile.exists()) {
      googleMapsScreenCubit.onErrorState(
          "No main file found in ${directoryPickCubit.state.data}");
      return false;
    }
    String content = await mainFile.readAsString();
    var newContent = "$googleMapsImports$content\n$mapsScreenCode";
    await mainFile.writeAsString(newContent);
    googleMapsScreenCubit.onUpdateData(Constantscatalog.done);
    return true;
  }

  apply() async {
    var googleMapRes = await addGoogleMaps();
    if (!googleMapRes) return;
    if (apiKeyConroller.text.nullOrEmpty) {
      platformConfigs.onUpdateData(Constantscatalog.done);
      await addGoogleMaps();
      return;
    }
    var iosConfigsResult = await addIosAndroidConfigs(
        "${directoryPickCubit.state.data}/ios/Runner/AppDelegate.swift",
        RegExp(Constantscatalog.iosSnippetPattern, multiLine: true),
        Constantscatalog.iosGoogleMapsKey(apiKeyConroller.text),
        imports: "import GoogleMaps\n");
    if (!iosConfigsResult) return;
    var androidConfigsRes = await addIosAndroidConfigs(
        "${directoryPickCubit.state.data}/android/app/src/main/AndroidManifest.xml",
        RegExp(Constantscatalog.androidSnippetPattern),
        Constantscatalog.androidGoogleMapsKeySnippet(apiKeyConroller.text));
    if (!androidConfigsRes) return;
    platformConfigs.onUpdateData("Done");
    await addMapsScreen();
  }
}
