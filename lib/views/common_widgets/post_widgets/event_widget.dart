import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/post_manager/post_manager.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_settings_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_widget.dart';

class EvenWidget extends StatefulWidget {
  final Language language;
  final Event post;
  final List<Message> comments;
  final bool manager;
  final bool advisor;
  final bool loggedIn;
  final bool popOnDelete;
  final List<String> managers;

  const EvenWidget(
      {Key? key,
      required this.language,
      required this.post,
      required this.comments,
      required this.manager,
      required this.advisor,
      required this.loggedIn,
      required this.managers,
      this.popOnDelete = false})
      : super(key: key);

  @override
  _EvenWidgetState createState() => _EvenWidgetState();
}

class _EvenWidgetState extends State<EvenWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<Widget> _photos() {
    List<Widget> _images = [];

    for (String url in widget.post.images) {
      _images.add(ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(UIConstants.borderRadius / 2),
            topRight: Radius.circular(UIConstants.borderRadius / 2)),
        child: Image.network(url, fit: BoxFit.fill),
      ));
    }
    return _images;
  }

  PostManager? _postManager;
  UserManager? _userManager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userManager = Provider.of<UserManager>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _postManager = Provider.of<PostManager>(context, listen: false);
  }

  void _nextPhoto() {
    if (_currentIndex != widget.post.images.length - 1) {
      print("next");
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void _previousPhoto() {
    if (_currentIndex != 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = UIConstants.getPostWidth(context);
    return Card(
      shadowColor: Colors.black,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.borderRadius / 2),
      ),
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstants.borderRadius / 2),
            color: Theme.of(context).own().background,
            boxShadow: []),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox(
                    width: width,
                    height: width,
                    child: PageView(
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        controller: _pageController,
                        children: _photos()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: _currentIndex != 0,
                        child: IconButton(
                          onPressed: () => _previousPhoto(),
                          icon: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white),
                        ),
                      ),
                      Visibility(
                        visible: _currentIndex != widget.post.images.length - 1,
                        child: IconButton(
                          onPressed: () => _nextPhoto(),
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: PostSettings(
                          popOnDelete: widget.popOnDelete,
                          managers: widget.managers,
                          post: widget.post,
                          clubID: widget.post.clubID,
                          manager: widget.manager,
                          advisor: widget.advisor,
                          loggedIn: widget.loggedIn))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: PostWidget(
                  language: widget.language,
                  post: widget.post,
                  comments: widget.comments,
                  icons: [
                    Icon(
                      Icons.attachment,
                      color: Theme.of(context).own().postWidgetIcons,
                    ),
                    Icon(
                      Icons.pin_drop,
                      color: Theme.of(context).own().postWidgetIcons,
                    ),
                  ],
                  onIconTaps: [
                    () async {
                      await _postManager!
                          .attendPost(widget.post.id, _userManager!.user!.name);
                    },
                    () async {
                      await _postManager!.pinPost(widget.post.id);
                    }
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
