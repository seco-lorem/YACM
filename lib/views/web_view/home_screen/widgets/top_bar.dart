import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/theme_controller/theme_changer.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/web_view/home_screen/widgets/app_bar_menu_item.dart';

class TopBar extends StatefulWidget {
  final bool isSmall;
  final onLogoTap;
  final List<Map<String, String>> notifications;
  final List<Map<String, String>> recommendedClubs;
  final Function(int) onPageChange;
  final int currentPage;
  const TopBar(
      {Key? key,
      required this.isSmall,
      required this.onLogoTap,
      required this.notifications,
      required this.recommendedClubs,
      required this.onPageChange,
      required this.currentPage})
      : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TextEditingController _searchControlller = TextEditingController();
  bool _notificationsVisible = false;
  bool _searchVisible = false;

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
    reverseDuration: const Duration(milliseconds: 500),
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(-1, 0.0),
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    super.dispose();
    _searchControlller.dispose();
  }

  Widget _search() {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {},
        child: Container(
          width: UIConstants.getWidth(context, width: 400, multiplier: .6),
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
                  controller: _searchControlller,
                  style: TextStyle(color: Colors.grey[700]),
                  cursorColor: Theme.of(context).own().yacmLogoColor,
                  decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(bottom: 15, left: 8, right: 8)),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        _searchVisible = true;
                      } else {
                        _searchVisible = false;
                      }
                    });
                  },
                ),
              ),
              Visibility(
                visible: _searchVisible,
                child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _searchVisible = false;
                          _searchControlller.clear();
                        });
                      },
                      child: widget.isSmall
                          ? Icon(Icons.close, color: Colors.grey[700])
                          : Text(
                              "cancel",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _endActions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      _notificationsVisible = !_notificationsVisible;
                    });
                  },
                  child: widget.isSmall
                      ? Icon(
                          Icons.notifications,
                          color: Theme.of(context).own().yacmLogoColor,
                        )
                      : Text(
                          "Notifications",
                          style: TextStyle(
                              color: Theme.of(context).own().yacmLogoColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
            ],
          ),
        ),
        InkWell(
          child: widget.isSmall
              ? Icon(
                  Icons.exit_to_app,
                  color: Colors.grey[700],
                )
              : Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
        )
      ],
    );
  }

  Widget _drawer() {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        elevation: 10,
        child: Container(
          width: 250,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              right: 8,
              bottom: MediaQuery.of(context).padding.bottom + 8,
              top: MediaQuery.of(context).padding.top + 8),
          decoration: BoxDecoration(
            color: Theme.of(context).own().background,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _animationController.reverse();
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
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
                    selected: widget.currentPage == 0,
                    ontap: () {
                      widget.onPageChange(0);
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
                    selected: widget.currentPage == 1,
                    ontap: () {
                      widget.onPageChange(1);
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
                    selected: widget.currentPage == 2,
                    ontap: () {
                      widget.onPageChange(2);
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
                    selected: widget.currentPage == 3,
                    ontap: () {
                      widget.onPageChange(3);
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
                    selected: widget.currentPage == 4,
                    ontap: () {
                      widget.onPageChange(4);
                    }),
                SizedBox(height: 10),
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
                for (Map<String, String> club in widget.recommendedClubs)
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeChanger>(context);
    super.build(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: widget.isSmall
                          ? () async {
                              setState(() {
                                _animationController.forward();
                              });
                            }
                          : widget.onLogoTap,
                      child: widget.isSmall
                          ? Icon(
                              Icons.menu,
                              color: Theme.of(context).own().yacmLogoColor,
                            )
                          : Text(
                              "YACM",
                              style: GoogleFonts.pacifico(
                                  color: Theme.of(context).own().yacmLogoColor,
                                  fontSize: widget.isSmall ? 18 : 24,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                    Spacer(),
                    _search(),
                    Spacer(),
                    _endActions()
                  ],
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: _notificationsVisible,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 250 < MediaQuery.of(context).size.width
                              ? 250
                              : MediaQuery.of(context).size.width,
                          height: widget.notifications.length * 40 < 100
                              ? widget.notifications.length * 40
                              : 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).own().yacmLogoColor),
                              borderRadius: BorderRadius.circular(
                                  UIConstants.borderRadius / 2),
                              color: Theme.of(context).own().background),
                          child: ListView.builder(
                            itemCount: widget.notifications.length,
                            itemBuilder: (context, int index) {
                              return ListTile(
                                title: Text(
                                  widget.notifications[index]["title"]!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .own()
                                          .yacmLogoColor),
                                ),
                                subtitle: Text(
                                  widget.notifications[index]["subtitle"]!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[700]),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red[700],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Visibility(
            visible: widget.isSmall,
            child: _drawer(),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
