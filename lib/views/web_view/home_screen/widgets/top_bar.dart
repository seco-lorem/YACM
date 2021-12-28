import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/club_manager/club_manager.dart';
import 'package:yacm/controllers/theme_controller/theme_changer.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/club/club.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/router/route_names.dart';
import 'package:yacm/util/helper.dart';
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
  bool _cancelVisible = false;

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

  List<Club> _allClubs = [];
  List<Club> _searchResults = [];

  Future<void> getClubs() async {
    QuerySnapshot _clubs =
        await Provider.of<ClubManager>(context, listen: false).getClubs();

    List<Club> _tempAllClubs = [];

    for (DocumentSnapshot club in _clubs.docs) {
      _tempAllClubs.add(Club.fromDocumentSnapshot(club));
    }

    setState(() {
      _allClubs = _tempAllClubs;
      _searchResults = _tempAllClubs;
    });
  }

  Language? _language;
  UserManager? _userManager;
  ClubManager? _clubManager;

  @override
  void initState() {
    super.initState();
    getClubs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _language = Language.of(context);
    _userManager = Provider.of<UserManager>(context);
    _clubManager = Provider.of<ClubManager>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _searchControlller.dispose();
  }

  Widget _search() {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          if (focus) {
            setState(() {
              _searchVisible = true;
            });
          } else {
            setState(() {
              _searchVisible = false;
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: UIConstants.getWidth(context, width: 400, multiplier: .6),
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).own().yacmLogoColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(UIConstants.borderRadius * 2 / 3),
                  topRight: Radius.circular(UIConstants.borderRadius * 2 / 3),
                  bottomLeft: _searchVisible
                      ? Radius.zero
                      : Radius.circular(UIConstants.borderRadius * 2 / 3),
                  bottomRight: _searchVisible
                      ? Radius.zero
                      : Radius.circular(UIConstants.borderRadius * 2 / 3)),
              color: Theme.of(context).own().background),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: TextField(
                  controller: _searchControlller,
                  style: TextStyle(color: Colors.grey[700]),
                  cursorColor: Theme.of(context).own().yacmLogoColor,
                  decoration: InputDecoration(
                      hintText: _language!.search,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      contentPadding:
                          EdgeInsets.only(bottom: 15, left: 8, right: 8)),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        _cancelVisible = true;
                        _searchVisible = true;
                        _searchResults = [];
                        _allClubs.forEach((element) {
                          if (element.clubName
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            _searchResults.add(element);
                          }
                        });
                      } else {
                        _cancelVisible = false;
                        _searchResults = _allClubs;
                      }
                    });
                  },
                ),
              ),
              Visibility(
                visible: _cancelVisible,
                child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _cancelVisible = false;
                          _searchControlller.clear();
                          _searchResults = _allClubs;
                        });
                      },
                      child: widget.isSmall
                          ? Icon(Icons.close, color: Colors.grey[700])
                          : Text(
                              _language!.cancel,
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
                          _language!.notifications,
                          style: TextStyle(
                              color: Theme.of(context).own().yacmLogoColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            bool result = await Provider.of<UserManager>(context, listen: false)
                .signOut();
            if (result) {
              Navigator.pushNamed(context, RouteNames.notLoggedIn);
            }
          },
          child: widget.isSmall
              ? Icon(
                  Icons.exit_to_app,
                  color: Colors.grey[700],
                )
              : Text(
                  _language!.signOut,
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
                    title: _language!.home,
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
                    title: _language!.pinned,
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
                    title: _language!.explore,
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
                    title: _language!.subscription,
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
                    title: _language!.profile,
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
                    _language!.suggested,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).own().yacmLogoColor),
                  ),
                ),
                for (String club in Helper.suggested.keys)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteNames.club + "?id=$club");
                      },
                      child: Text(Helper.suggested[club],
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

  Widget _suggestions() {
    List<Widget> _results = [];

    for (Club club in _searchResults) {
      _results.add(InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.club + "?id=${club.id}");
        },
        child: Text(
          club.clubName,
          textAlign: TextAlign.start,
          maxLines: null,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600]),
        ),
      ));
    }

    return Container(
        width: UIConstants.getWidth(context, width: 400, multiplier: .6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Theme.of(context).own().yacmLogoColor),
                right: BorderSide(color: Theme.of(context).own().yacmLogoColor),
                left: BorderSide(color: Theme.of(context).own().yacmLogoColor),
                bottom:
                    BorderSide(color: Theme.of(context).own().yacmLogoColor)),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(UIConstants.borderRadius * 2 / 3),
              bottomLeft: Radius.circular(UIConstants.borderRadius * 2 / 3),
            ),
            color: Theme.of(context).own().background),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: _results));
  }

  Widget _searchSuggestion() {
    return Visibility(
      visible: _searchVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isSmall
              ? Icon(
                  Icons.menu,
                  color: Colors.transparent,
                )
              : Text(
                  "YACM",
                  style: GoogleFonts.pacifico(
                      color: Colors.transparent,
                      fontSize: widget.isSmall ? 18 : 24,
                      fontWeight: FontWeight.bold),
                ),
          Spacer(),
          _suggestions(),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.isSmall
                        ? Icon(
                            Icons.notifications,
                            color: Colors.transparent,
                          )
                        : Text(
                            _language!.notifications,
                            style: TextStyle(
                                color: Colors.transparent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                  ],
                ),
              ),
              widget.isSmall
                  ? Icon(
                      Icons.exit_to_app,
                      color: Colors.transparent,
                    )
                  : Text(
                      _language!.signOut,
                      style: TextStyle(
                          color: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
            ],
          )
        ],
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
                    _searchSuggestion(),
                    StreamBuilder(
                        stream: _userManager!.getNotifications(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return Visibility(
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
                                          color: Theme.of(context)
                                              .own()
                                              .yacmLogoColor),
                                      borderRadius: BorderRadius.circular(
                                          UIConstants.borderRadius / 2),
                                      color:
                                          Theme.of(context).own().background),
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, int index) {
                                      return ListTile(
                                        title: Text(
                                          snapshot.data!.docs[index]["title"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .own()
                                                  .yacmLogoColor),
                                        ),
                                        subtitle: Text(
                                          snapshot.data!.docs[index]
                                              ["subtitle"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.grey[700]),
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            _userManager!.deleteNotification(
                                                snapshot.data!.docs[index].id);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red[700],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        })
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
