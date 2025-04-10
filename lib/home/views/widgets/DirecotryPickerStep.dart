import 'package:flutter/material.dart';
import 'package:google_maps_mac_intergrator/core/extentions/widgets_extentions.dart';

import '../../../core/constants/constantsCatalog.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../home_screen_view_model.dart';

class DirecotryPickerStep extends StatelessWidget {
  final HomeScreenViewModel viewModel;
  final String? dir;
  const DirecotryPickerStep(
      {super.key, required this.viewModel, required this.dir});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            Constantscatalog.step1,
            style: TextStyles.title,
          ),
        ),
        Text(
          Constantscatalog.chooseDir,
          style: TextStyles.body,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.sizeOf(context).width * 0.6,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.grey)),
          child: Text(
            dir ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ).onTap(viewModel.pickDirectory)
      ],
    );
  }
}
