import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

/// This is a screen for user profile page
/// which works both on mobile (iOS and Android) and web
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordController2 = TextEditingController();

  @override
  dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordController2.dispose();
  }

  Widget _inputBox(TextEditingController controller) => Container(
        width: UIConstants.getPostWidth(context),
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).own().yacmLogoColor),
            borderRadius:
                BorderRadius.circular(UIConstants.borderRadius * 2 / 3),
            color: Colors.transparent.withOpacity(.05)),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: TextField(
                obscureText: true,
                controller: controller,
                style: TextStyle(color: Colors.grey[700]),
                cursorColor: Theme.of(context).own().yacmLogoColor,
                decoration: InputDecoration(
                    hintText: "Type Here",
                    hintStyle: TextStyle(
                        color: Colors.grey[700]!.withOpacity(.8),
                        fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 15, left: 8, right: 8)),
              ),
            ),
          ],
        ),
      );

  Widget _changePassword() => InkWell(
        onTap: () {},
        child: Container(
          width: UIConstants.getPostWidth(context),
          height: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).own().yacmLogoColor,
              borderRadius:
                  BorderRadius.circular(UIConstants.borderRadius / 2)),
          child: Center(
            child: Text(
              "Change Password",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).own().background,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  Widget _changePhoto() {
    return SizedBox(
      width: UIConstants.getPostWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg"),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Change Language",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, right: 8, left: 8),
        color: Theme.of(context).own().background,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                _changePhoto(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: UIConstants.getPostWidth(context),
                  child: Text(
                    "Current Password",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Theme.of(context).own().yacmLogoColor,
                        fontSize: 16),
                  ),
                ),
                _inputBox(_currentPasswordController),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: UIConstants.getPostWidth(context),
                  child: Text(
                    "New Password",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Theme.of(context).own().yacmLogoColor,
                        fontSize: 16),
                  ),
                ),
                _inputBox(_newPasswordController),
                SizedBox(
                  height: 5,
                ),
                _inputBox(_newPasswordController2),
                SizedBox(
                  height: 10,
                ),
                _changePassword()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}