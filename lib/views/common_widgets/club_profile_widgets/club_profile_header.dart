import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/club_manager/club_manager.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class ClubProfileHeader extends StatefulWidget {
  final String url;
  final String description;
  final bool isAdmin;
  final bool postsActive;
  final VoidCallback onPageChange;
  final VoidCallback onCreatePost;
  final VoidCallback onKickMembers;
  final VoidCallback onViewMembers;
  final String clubID;
  const ClubProfileHeader(
      {Key? key,
      required this.url,
      required this.isAdmin,
      required this.description,
      required this.postsActive,
      required this.onPageChange,
      required this.onCreatePost,
      required this.onKickMembers,
      required this.onViewMembers,
      required this.clubID})
      : super(key: key);

  @override
  _ClubProfileHeaderState createState() => _ClubProfileHeaderState();
}

class _ClubProfileHeaderState extends State<ClubProfileHeader> {
  bool _settingsVisible = false;

  Widget _child(
      {required bool visible,
      required String setting,
      required VoidCallback onTap}) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          setting,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).own().postSettingsText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Language? _language = Language.of(context);
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: widget.onViewMembers,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover, // fitWidth, // Emin değilim ama iyi gibi
                  //                                 (Mobil için)
                ),
              ),
            ),
            Visibility(
              visible: Provider.of<UserManager>(context).user != null,
              child: Positioned(
                  top: 5,
                  right: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _settingsVisible = !_settingsVisible;
                          });
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                      Visibility(
                        visible: _settingsVisible,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Theme.of(context).own().postSettingsText),
                              borderRadius: BorderRadius.circular(
                                  UIConstants.borderRadius),
                              color: Theme.of(context).own().postSettings),
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 8, right: 10),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _child(
                                  visible: true,
                                  setting: _language!.sub,
                                  onTap: () async {
                                    await Provider.of<ClubManager>(context,
                                            listen: false)
                                        .subToClub(widget.clubID);
                                  }),
                              _child(
                                  visible: widget.isAdmin,
                                  setting: _language.createPost,
                                  onTap: widget.onCreatePost),
                              _child(
                                  visible: widget.isAdmin,
                                  setting: _language.kickMembers,
                                  onTap: widget.onKickMembers)
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
        Center(
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Divider(
          color: Colors.transparent.withOpacity(.4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: widget.onPageChange,
              child: Text(_language.posts,
                  style: TextStyle(
                      color: Theme.of(context).own().yacmLogoColor,
                      fontWeight: widget.postsActive
                          ? FontWeight.bold
                          : FontWeight.normal)),
            ),
            InkWell(
              onTap: widget.onPageChange,
              child: Text(_language.chat,
                  style: TextStyle(
                      color: Theme.of(context).own().yacmLogoColor,
                      fontWeight: !widget.postsActive
                          ? FontWeight.bold
                          : FontWeight.normal)),
            )
          ],
        ),
        Divider(
          color: Colors.transparent.withOpacity(.4),
        ),
      ],
    );
  }
}
