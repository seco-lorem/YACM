import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class GetInterests extends StatelessWidget {
  final List<String>? interests;
  final List<bool>? choices;
  final Function(int)? onTap;
  const GetInterests({Key? key, this.interests, this.choices, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: UIConstants.getPaddingHorizontal(context),
            vertical: UIConstants.getPaddingVertical(context)),
        child: Column(
          children: [
            SizedBox(
              height: UIConstants.getPaddingVertical(context),
            ),
            Container(
              width: UIConstants.getWidth(context),
              child: Text(
                "Please choose minimum 5 to maximum 10 interests",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).own().signUpGetInterestsText,
                    fontSize: UIConstants.getHeight(context)),
              ),
            ),
            SizedBox(
              height: UIConstants.getPaddingVertical(context),
            ),
            CupertinoScrollbar(
              isAlwaysShown: true,
              child: Container(
                height:
                    UIConstants.getHeight(context, height: 150, multiplier: .7),
                width: UIConstants.getWidth(context),
                child: ListView.builder(
                  itemCount: interests!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          onTap!(index);
                        },
                        child: Container(
                          width: UIConstants.getWidth(context),
                          padding: EdgeInsets.only(
                              right: UIConstants.getPaddingHorizontal(context),
                              bottom: UIConstants.getPaddingVertical(context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: UIConstants.getWidth(context,
                                    multiplier: .7, width: 350),
                                child: Text(
                                  interests![index],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: UIConstants.getHeight(context,
                                          height: 15),
                                      color: Theme.of(context)
                                          .own()
                                          .signUpGetInterestsChoiceText,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Icon(
                                choices![index]
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                                color: Theme.of(context)
                                    .own()
                                    .signUpGetInterestsText,
                                size: UIConstants.getHeight(context),
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
