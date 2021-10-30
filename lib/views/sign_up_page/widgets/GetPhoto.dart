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
      mainAxisAlignment: UIConstants.getSafeHeight(context) > 700
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              vertical: UIConstants.getPaddingVertical(context) * 2),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: UIConstants.getHeight(context, height: 150, multiplier: .4),
          height: UIConstants.getHeight(context,
              height: 175, multiplier: (7 / 6) * .4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: image == null
              ? Image.asset(
                  "assets/empty_photo.png",
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.clear,
                )
              : Image.file(image!),
        ),
        //SizedBox(height: UIConstants.getPaddingVertical(context) * 2),
        Padding(
          padding: EdgeInsets.only(
              bottom: UIConstants.getPaddingVertical(context) * 2),
          child: GestureDetector(
            child: Container(
              width:
                  UIConstants.getHeight(context, height: 150, multiplier: .4),
              height:
                  UIConstants.getHeight(context, multiplier: .04, height: 30),
              decoration: BoxDecoration(
                  color: Theme.of(context).own().signUpGetPhotoButtonColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                  child: Text(
                image == null ? "Add Photo" : "Change Photo",
                style: TextStyle(
                    fontSize: UIConstants.getHeight(context),
                    color: Theme.of(context).own().signUpGetPhotoButtonText),
              )),
            ),
          ),
        )
      ],
    );
  }
}
