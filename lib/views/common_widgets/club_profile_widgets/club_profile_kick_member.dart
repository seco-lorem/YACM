import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class KickMembers extends StatefulWidget {
  final Map<String, String> members;
  const KickMembers({Key? key, required this.members}) : super(key: key);

  @override
  _KickMembersState createState() => _KickMembersState();
}

class _KickMembersState extends State<KickMembers> {
  List<bool> kicked = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.members.length; i++) {
      kicked.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Language? _language = Language.of(context);
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
                    itemCount: widget.members.length,
                    itemBuilder: (context, index) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor:
                                Theme.of(context).own().optionColor),
                        child: CheckboxListTile(
                            activeColor: Theme.of(context).own().optionColor,
                            value: kicked[index],
                            onChanged: (value) {
                              setState(() {
                                kicked[index] = !kicked[index];
                              });
                            },
                            secondary: Text(
                              widget.members.values.toList()[index],
                              style: TextStyle(
                                  color: Theme.of(context).own().optionColor,
                                  fontSize: 16),
                            )),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: FittedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConstants.borderRadius),
                        color: Theme.of(context).own().optionColor,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Center(
                        child: Text(
                          _language!.kickMembers,
                          style: TextStyle(
                              color: Theme.of(context).own().background,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
