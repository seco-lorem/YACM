import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/club_manager/club_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

class ClubProfileMessages extends StatelessWidget {
  final String clubID;
  final bool isAdmin;
  const ClubProfileMessages(
      {Key? key, required this.isAdmin, required this.clubID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? _language = Language.of(context);
    ClubManager _clubManager = Provider.of<ClubManager>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 340 > 200
          ? MediaQuery.of(context).size.height - 340
          : 200,
      child: StreamBuilder(
          stream: _clubManager.getClubMessages(clubID),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data!.docs[index]["senderName"],
                      style: TextStyle(
                          color: Theme.of(context).own().yacmLogoColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      snapshot.data!.docs[index]["message"],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Visibility(
                      visible: isAdmin,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          _language!.mute,
                          style: TextStyle(
                              color: Theme.of(context).own().yacmLogoColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
