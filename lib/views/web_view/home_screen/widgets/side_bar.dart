import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/theme_controller/theme_changer.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/views/web_view/home_screen/widgets/app_bar_menu_item.dart';

class SideBar extends StatelessWidget {
  final Language language;
  final List<Map<String, String>> suggestedClubs;
  final Function(int) onPageChange;
  final int currentPage;
  const SideBar(
      {Key? key,
      required this.language,
      required this.suggestedClubs,
      required this.onPageChange,
      required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeChanger>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: MediaQuery.of(context).size.width > 800,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: 160,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MenuItem(
                              title: "Home",
                              icon: Icon(
                                Icons.home_outlined,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              boldIcon: Icon(
                                Icons.home_filled,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              selected: currentPage == 0,
                              ontap: () {
                                onPageChange(0);
                              }),
                          MenuItem(
                              title: "Pinned",
                              icon: Icon(
                                Icons.pin_drop_outlined,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              boldIcon: Icon(
                                Icons.pin_drop,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              selected: currentPage == 1,
                              ontap: () {
                                onPageChange(1);
                              }),
                          MenuItem(
                              title: "Explore",
                              icon: Icon(
                                Icons.explore_outlined,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              boldIcon: Icon(
                                Icons.explore,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              selected: currentPage == 2,
                              ontap: () {
                                onPageChange(2);
                              }),
                          MenuItem(
                              title: "Subscription",
                              icon: Icon(
                                CupertinoIcons.heart,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              boldIcon: Icon(
                                CupertinoIcons.heart_fill,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              selected: currentPage == 3,
                              ontap: () {
                                onPageChange(3);
                              }),
                          MenuItem(
                              title: "Profile",
                              icon: Icon(
                                CupertinoIcons.person,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              boldIcon: Icon(
                                CupertinoIcons.person_fill,
                                color: Theme.of(context).own().yacmLogoColor,
                              ),
                              selected: currentPage == 4,
                              ontap: () {
                                onPageChange(4);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: MediaQuery.of(context).size.width > 800,
                  child: SizedBox(
                    width: 140,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Suggested",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).own().yacmLogoColor),
                          ),
                        ),
                        for (Map<String, String> club in suggestedClubs)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 4),
                            child: InkWell(
                              onTap: () {},
                              child: Text(club["name"]!,
                                  textAlign: TextAlign.start,
                                  maxLines: null,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[700])),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
