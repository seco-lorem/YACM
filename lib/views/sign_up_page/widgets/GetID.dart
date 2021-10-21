import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class GetID extends StatelessWidget {
  final TextEditingController? textEditingController;
  final bool visible;
  const GetID({Key? key, this.textEditingController, this.visible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 0),
                  width: UIConstants.getWidth(context),
                  child: Text(
                    "Your student ID",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: UIConstants.getHeight(context),
                      color: Theme.of(context).own().signUpGetIDHeaderText,
                    ),
                  ),
                ),
                SizedBox(height: UIConstants.getColumnSpacing(context)),
                Container(
                  padding: EdgeInsets.only(
                    left: UIConstants.getPaddingHorizontal(context) * .5,
                    right: UIConstants.getPaddingHorizontal(context) * .5,
                  ),
                  height: UIConstants.getHeight(context,
                      height: 30, multiplier: .07),
                  width: UIConstants.getWidth(context),
                  decoration: BoxDecoration(
                      color: Theme.of(context).own().signUpGetIDBackground,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Theme.of(context).own().signUpGetIDBorder ??
                              Colors.white.withOpacity(0))),
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: Theme.of(context).own().signUpGetIDText,
                    controller: textEditingController,
                    style: TextStyle(
                      color: Theme.of(context).own().signUpGetIDText,
                      fontWeight: FontWeight.w400,
                      fontSize: UIConstants.getHeight(context, height: 15),
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, counterText: ""),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    maxLength: 8,
                    autocorrect: false,
                  ),
                )
              ],
            ),
          )
        : SizedBox();
  }
}
