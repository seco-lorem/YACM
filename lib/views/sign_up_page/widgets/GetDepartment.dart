import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class GetDepartment extends StatelessWidget {
  final List<String>? departments;
  final int? currentChoice;
  final Function(int)? onTap;
  final bool visible;
  const GetDepartment(
      {Key? key,
      this.departments,
      this.currentChoice,
      this.onTap,
      this.visible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: UIConstants.getPaddingHorizontal(context),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      right: UIConstants.getPaddingHorizontal(context) * 2,
                      left: UIConstants.getPaddingHorizontal(context) * 2,
                      bottom: UIConstants.getPaddingVertical(context)),
                  child: SizedBox(
                    width: UIConstants.getWidth(context),
                    child: Text(
                      "And your department",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: UIConstants.getHeight(context),
                        color: Theme.of(context)
                            .own()
                            .signUpGetDepartmentHeaderText,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: UIConstants.getPaddingHorizontal(context) * 2,
                      right: UIConstants.getPaddingHorizontal(context) * 2,
                      bottom: UIConstants.getPaddingVertical(context) * 2),
                  child: CupertinoScrollbar(
                    isAlwaysShown: true,
                    child: Container(
                        height: UIConstants.getHeight(context,
                            height: 60, multiplier: .2),
                        width: UIConstants.getWidth(context),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .own()
                                .signUpGetDepartmentBackground,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: Theme.of(context)
                                        .own()
                                        .signUpGetDepartmentBorder ??
                                    Colors.white.withOpacity(0))),
                        child: ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  onTap!(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          UIConstants.getPaddingHorizontal(
                                              context),
                                      vertical: UIConstants.getPaddingVertical(
                                          context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: UIConstants.getWidth(context,
                                            width: 350, multiplier: .7),
                                        child: Text(
                                          departments![index],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: UIConstants.getHeight(
                                                  context,
                                                  height: 15),
                                              color: Theme.of(context)
                                                  .own()
                                                  .signUpGetDepartmentChoiceText,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Icon(
                                          index == currentChoice
                                              ? Icons.circle
                                              : Icons.circle_outlined,
                                          color: Theme.of(context)
                                              .own()
                                              .signUpGetDepartmentBorder,
                                          size: UIConstants.getHeight(context))
                                    ],
                                  ),
                                ));
                          },
                          itemCount: departments!.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              indent: UIConstants.getPaddingHorizontal(context),
                              endIndent:
                                  UIConstants.getPaddingHorizontal(context),
                              thickness: 1,
                              color: Theme.of(context)
                                  .own()
                                  .signUpGetDepartmentDivider,
                            );
                          },
                        )),
                  ),
                )
              ],
            ),
          )
        : SizedBox(
            height: UIConstants.getSafeHeight(context) * .2 +
                UIConstants.getHeight(context),
          );
  }
}
