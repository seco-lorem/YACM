import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_settings_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_widget.dart';

class EvenWidget extends StatefulWidget {
  final Language language;
  final Event post;
  final List<Message> comments;

  const EvenWidget(
      {Key? key,
      required this.language,
      required this.post,
      required this.comments})
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

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
            color: Color.fromRGBO(224, 205, 178, 1),
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
                          manager: true, advisor: true, loggedIn: true))
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
                      color: Color.fromRGBO(94, 119, 3, 1),
                    ),
                    Icon(
                      Icons.pin_drop,
                      color: Color.fromRGBO(94, 119, 3, 1),
                    ),
                  ],
                  onIconTaps: [
                    () {},
                    () {}
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
