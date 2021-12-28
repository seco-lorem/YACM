import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/club_manager/club_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class KickMembers extends StatefulWidget {
  final Map<String, dynamic> members;
  final String clubID;
  const KickMembers({Key? key, required this.members, required this.clubID})
      : super(key: key);

  @override
  _KickMembersState createState() => _KickMembersState();
}

class _KickMembersState extends State<KickMembers> {
  ClubManager? _clubManager;
  List<bool> kicked = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.members.length; i++) {
      kicked.add(false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _clubManager = Provider.of<ClubManager>(context);
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
                  onTap: () {
                    List<String> _kickedUsers = [];
                    for (int i = 0; i < kicked.length; i++) {
                      if (kicked[i]) {
                        _kickedUsers.add(widget.members.keys.toList()[i]);
                        print(widget.members.values.toList()[i]);
                      }
                    }
                    _clubManager!.kickUsers(widget.clubID, _kickedUsers);
                  },
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
