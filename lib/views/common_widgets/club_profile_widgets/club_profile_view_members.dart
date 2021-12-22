import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class ViewMembers extends StatelessWidget {
  final List<String> members;
  const ViewMembers({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(.7),
      child: Center(
        child: Container(
          width: UIConstants.getPostWidth(context),
          height: UIConstants.getPostWidth(context) * .8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).own().background,
              border: Border.all(color: Colors.transparent.withOpacity(.5)),
              borderRadius: BorderRadius.circular(UIConstants.borderRadius)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: UIConstants.getPostWidth(context),
                  height: UIConstants.getPostWidth(context) * .64,
                  child: ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Text(
                          members[index],
                          style: TextStyle(
                              color: Theme.of(context).own().optionColor,
                              fontSize: 16),
                        )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
