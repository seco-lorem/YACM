import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class GetPassword extends StatelessWidget {
  final TextEditingController? controllerOne;
  final TextEditingController? controllerTwo;
  final TextEditingController? controllerThree;
  final int? choseMail;
  final VoidCallback? onTap;
  final Function(int?)? onMailChoose;
  const GetPassword(
      {Key? key,
      this.controllerOne,
      this.controllerTwo,
      this.controllerThree,
      this.choseMail,
      this.onMailChoose,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getPasswordInput(TextEditingController? textEditingController,
        {bool textVisible = false}) {
      return Container(
        padding: EdgeInsets.only(
          left: UIConstants.getPaddingHorizontal(context) * .5,
          right: UIConstants.getPaddingHorizontal(context) * .5,
        ),
        height: UIConstants.getHeight(context, height: 30, multiplier: .07),
        width: UIConstants.getWidth(context),
        decoration: BoxDecoration(
            color: Theme.of(context).own().signUpGetPasswordBackground,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: Theme.of(context).own().signUpGetPasswordBorder ??
                    Colors.white.withOpacity(0))),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          cursorColor: Theme.of(context).own().signUpGetPasswordText,
          controller: textEditingController,
          style: TextStyle(
            color: Theme.of(context).own().signUpGetPasswordText,
            fontWeight: FontWeight.w400,
            fontSize: UIConstants.getHeight(context, height: 15),
            decoration: TextDecoration.none,
          ),
          decoration:
              InputDecoration(border: InputBorder.none, counterText: ""),
          keyboardType: TextInputType.text,
          maxLines: 1,
          obscureText: !textVisible,
          autocorrect: false,
        ),
      );
    }

    return Container(
      height: UIConstants.getSafeHeight(context),
      width: UIConstants.getWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: UIConstants.getPaddingVertical(context),
              ),
              SizedBox(
                width: UIConstants.getWidth(context),
                child: Text(
                  "Set your Bilkent mail and password, then you are ready to go",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).own().signUpGetPasswordHeader,
                      fontSize: UIConstants.getHeight(context,
                          height: 20, multiplier: .03)),
                ),
              ),
              SizedBox(
                height: UIConstants.getPaddingVertical(context),
              ),
              getPasswordInput(controllerOne, textVisible: true),
              SizedBox(
                width: UIConstants.getWidth(context),
                child: Row(
                  children: [
                    Theme(
                        data: ThemeData().copyWith(
                            unselectedWidgetColor: Theme.of(context)
                                .own()
                                .signUpGetPasswordBorder),
                        child: SizedBox(
                          child: Radio(
                            value: 0,
                            groupValue: choseMail,
                            onChanged: (int? value) => onMailChoose!(value),
                            activeColor:
                                Theme.of(context).own().signUpGetPasswordBorder,
                          ),
                        )),
                    Text(
                      "@ug.bilkent.edu.tr",
                      style: TextStyle(
                          color:
                              Theme.of(context).own().signUpGetPasswordHeader,
                          fontSize: UIConstants.getHeight(context,
                              height: 20, multiplier: .03)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: UIConstants.getWidth(context),
                child: Row(
                  children: [
                    Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Theme.of(context)
                                .own()
                                .signUpGetPasswordBorder),
                        child: Radio(
                          value: 1,
                          groupValue: choseMail,
                          onChanged: (int? value) => onMailChoose!(value),
                          activeColor:
                              Theme.of(context).own().signUpGetPasswordBorder,
                        )),
                    Text(
                      "@bilkent.edu.tr",
                      style: TextStyle(
                          color:
                              Theme.of(context).own().signUpGetPasswordHeader,
                          fontSize: UIConstants.getHeight(context,
                              height: 20, multiplier: .03)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: UIConstants.getPaddingVertical(context),
              ),
              getPasswordInput(controllerTwo),
              SizedBox(
                height: UIConstants.getPaddingVertical(context),
              ),
              getPasswordInput(controllerThree),
              SizedBox(
                height: UIConstants.getPaddingVertical(context),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).own().signUpGetPasswordBorder,
                    borderRadius: BorderRadius.circular(6)),
                height:
                    UIConstants.getHeight(context, height: 30, multiplier: .04),
                width: UIConstants.getWidth(context),
                child: Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: UIConstants.getHeight(context),
                      color:
                          Theme.of(context).own().signUpGetPasswordBackground,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
