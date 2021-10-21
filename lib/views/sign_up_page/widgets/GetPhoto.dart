import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class GetPhoto extends StatelessWidget {
  final File? image;
  const GetPhoto({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: UIConstants.getPaddingVertical(context) * 2),
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: UIConstants.getHeight(context, height: 150, multiplier: .4),
          height: UIConstants.getHeight(context, height: 150, multiplier: .4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: image == null
              ? Image.asset(
                  "assets/empty_photo.png",
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.clear,
                )
              : Image.file(image!),
        ),
        SizedBox(height: UIConstants.getPaddingVertical(context) * 2),
        GestureDetector(
          child: Container(
            width: UIConstants.getHeight(context, height: 150, multiplier: .4),
            height: UIConstants.getHeight(context, multiplier: .04, height: 22),
            decoration: BoxDecoration(
                color: Theme.of(context).own().signUpGetPhotoButtonColor,
                borderRadius: BorderRadius.circular(6)),
            child: Center(
                child: Text(
              image == null ? "Add Photo" : "Change Photo",
              style: TextStyle(
                  fontSize: UIConstants.getHeight(context, multiplier: .035),
                  color: Theme.of(context).own().signUpGetPhotoButtonText),
            )),
          ),
        )
      ],
    );
  }
}
