import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_widgets/get_language.dart';
import 'package:yacm/views/common_widgets/get_theme.dart';
import 'package:yacm/views/common_widgets/not_logged_in_widgets/sign_up_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/event_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/poll_widget.dart';

class NotLoggedIn extends StatefulWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  _NotLoggedInState createState() => _NotLoggedInState();
}

class _NotLoggedInState extends State<NotLoggedIn> {
  bool _mouseHoverOnSignIn = false;
  bool _signUpVisible = false;
  bool _themeChosen = false;
  bool _languageChosen = true;
  Language? _language;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _language = Language.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).own().background,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "YACM",
                          style: GoogleFonts.pacifico(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).own().yacmLogoColor),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _signUpVisible = !_signUpVisible;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              _mouseHoverOnSignIn = value;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    UIConstants.borderRadius / 2),
                                color: _mouseHoverOnSignIn
                                    ? Theme.of(context).own().yacmLogoColor
                                    : Theme.of(context)
                                        .own()
                                        .yacmLogoColor
                                        .withOpacity(.7)),
                            child: Text(
                              _language!.loginPageLogin,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Theme.of(context).own().background),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: Provider.of<UserManager>(context).getPosts(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> stream) {
                      if (stream.hasData) {
                        List<Widget> _posts = [
                          SizedBox(width: MediaQuery.of(context).size.width)
                        ];
                        for (DocumentSnapshot post in stream.data!.docs) {
                          if (post.get("type") == "event") {
                            _posts.add(Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: EvenWidget(
                                  loggedIn: Provider.of<UserManager>(context)
                                          .user !=
                                      null,
                                  manager:
                                      Provider.of<UserManager>(context).user !=
                                              null &&
                                          post.get("managers").contains(
                                              Provider.of<UserManager>(context)
                                                  .user!
                                                  .id),
                                  advisor: Provider.of<UserManager>(context).user !=
                                          null &&
                                      post.get("advisor").compareTo(
                                              Provider.of<UserManager>(context)
                                                  .user!
                                                  .id) ==
                                          0,
                                  language: _language!,
                                  post: Event.fromDocumentSnapshot(post),
                                  comments: []),
                            ));
                          } else if (post.get("type") == "poll") {
                            _posts.add(Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: PollWidget(
                                  loggedIn: Provider.of<UserManager>(context).user !=
                                      null,
                                  manager:
                                      Provider.of<UserManager>(context).user != null &&
                                          post.get("managers").contains(
                                              Provider.of<UserManager>(context)
                                                  .user!
                                                  .id),
                                  advisor: Provider.of<UserManager>(context).user !=
                                          null &&
                                      post.get("advisor").compareTo(Provider.of<UserManager>(context).user!.id) ==
                                          0,
                                  hasVoted: Provider.of<UserManager>(context).user !=
                                          null &&
                                      !post.get("voters").contains(
                                          Provider.of<UserManager>(context).user!.id),
                                  language: _language!,
                                  post: Poll.fromDocumentSnapshot(post),
                                  comments: []),
                            ));
                          }
                        }
                        return Expanded(
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: _posts,
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
              Visibility(
                visible: _signUpVisible,
                child: SignUp(
                  language: _language!,
                  onClose: () {
                    setState(() {
                      _signUpVisible = !_signUpVisible;
                    });
                  },
                ),
              ),
              Visibility(
                visible: !_themeChosen,
                child: GetTheme(
                    language: _language!,
                    onClose: () {
                      setState(() {
                        _themeChosen = !_themeChosen;
                        _languageChosen = !_languageChosen;
                      });
                    },
                    onChanged: () {},
                    dark: false,
                    onContine: () {
                      setState(() {
                        _themeChosen = !_themeChosen;
                        _languageChosen = !_languageChosen;
                      });
                    }),
              ),
              Visibility(
                visible: !_languageChosen,
                child: GetLanguage(
                    language: _language!,
                    onClose: () {
                      setState(() {
                        _languageChosen = !_languageChosen;
                      });
                    },
                    onContine: () {}),
              )
            ],
          )),
    );
  }
}
