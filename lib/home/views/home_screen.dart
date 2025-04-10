import 'package:flutter/material.dart';
import 'package:google_maps_mac_intergrator/core/blocs/generic_cubit/generic_cubit.dart';

import 'package:google_maps_mac_intergrator/core/extentions/text_styles.dart';
import 'package:google_maps_mac_intergrator/home/views/home_screen_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/constantsCatalog.dart';
import '../../core/theme/text_styles/text_styles.dart';
import 'widgets/DirecotryPickerStep.dart';

class MyHomePage extends StatefulWidget {
  final HomeScreenViewModel viewModel;
  final String title;
  const MyHomePage({super.key, required this.title, required this.viewModel});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Text(
          "Fouad Abdelhady",
          style: TextStyles.bodySm.copyWith(color: Colors.grey),
        ),
        Text(
          "fouad.abd-elhady@outlook.com",
          style: TextStyles.bodySm.copyWith(color: Colors.grey),
        )
      ],
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(widget.title, style: TextStyles.title),
            expandedHeight: 100,
            floating: false,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              height: 200,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.amber, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(4, 4),
                ),
              ]),
              child: Text(
                Constantscatalog.wellcome,
                style: TextStyles.anouncementStyle.colorWeight(
                    color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:
                BlocBuilder<GenericCubit<String?>, GenericCubitState<String?>>(
              bloc: widget.viewModel.directoryPickCubit,
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.05),
                  margin: const EdgeInsets.only(top: 50),
                  child: DirecotryPickerStep(
                      viewModel: widget.viewModel,
                      dir: state is GenericUpdatedState ? state.data : null),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child:
                BlocConsumer<GenericCubit<String?>, GenericCubitState<String?>>(
              bloc: widget.viewModel.directoryPickCubit,
              listener: (context, state) {
                if (state is GenericErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error ?? ""),
                      backgroundColor: Colors.red));
                }
              },
              builder: (context, state) {
                return Visibility(
                  visible: state is GenericUpdatedState,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.05),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            Constantscatalog.step2,
                            style: TextStyles.title,
                          ),
                        ),
                        Text(
                          Constantscatalog.googleMapApiKey,
                          style: TextStyles.body,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.grey)),
                          child: TextField(
                            controller: widget.viewModel.apiKeyConroller,
                            textAlign: TextAlign.center,
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<GenericCubit, GenericCubitState>(
              bloc: widget.viewModel.directoryPickCubit,
              builder: (context, state) {
                return MultiBlocListener(
                    listeners: [
                      BlocListener<GenericCubit, GenericCubitState>(
                        bloc: widget.viewModel.pubspecConfigs,
                        listener: (context, state) {
                          if (state is GenericLoadingState) {
                            widget.viewModel.buttonCubit.onLoadingState();
                            return;
                          }
                          widget.viewModel.buttonCubit.onUpdateData("");
                          if (state is GenericUpdatedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Added To Pubspec")));
                            return;
                          }
                          if (state is GenericErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.error ?? ""),
                                backgroundColor: Colors.red));
                          }
                        },
                      ),
                      BlocListener<GenericCubit<String?>,
                          GenericCubitState<String?>>(
                        bloc: widget.viewModel.platformConfigs,
                        listener: (context, state) {
                          if (state is GenericLoadingState) {
                            widget.viewModel.buttonCubit.onLoadingState();
                            return;
                          }
                          widget.viewModel.buttonCubit.onUpdateData("");
                          if (state is GenericUpdatedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Configs added to IOS and Android")));
                            return;
                          }
                          if (state is GenericErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.error ?? ""),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                      ),
                      BlocListener<GenericCubit<String?>,
                          GenericCubitState<String?>>(
                        bloc: widget.viewModel.googleMapsScreenCubit,
                        listener: (context, state) {
                          if (state is GenericLoadingState) {
                            widget.viewModel.buttonCubit.onLoadingState();
                            return;
                          }
                          widget.viewModel.buttonCubit.onUpdateData("");
                          if (state is GenericUpdatedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Google maps screen added to your main file")));
                            return;
                          }
                          if (state is GenericErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.error ?? ""),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                      )
                    ],
                    child: BlocBuilder<GenericCubit, GenericCubitState>(
                      bloc: widget.viewModel.buttonCubit,
                      builder: (context, processState) {
                        return Visibility(
                          visible: state is GenericUpdatedState &&
                              processState is! GenericDimissLoadingState,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: widget.viewModel.apply,
                                    style: ElevatedButton.styleFrom(
                                        //  shape: const StadiumBorder(),
                                        backgroundColor: Colors.amber),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Text("Apply",
                                            style: TextStyles.title)))
                              ],
                            ),
                          ),
                        );
                      },
                    ));
              },
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
