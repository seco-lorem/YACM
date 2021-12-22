import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClubProfilePage(title: 'Calculator'),
    );
  }
}

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ClubProfilePageState createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  var posts = [
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
    {
      "id": "",
      "image":
          "https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png"
    },
  ];

  String clubDescription =
      "Club description: Lorem ipsum dolor sit amet consectetur adipiscing elit";

  static const double previewSize = 300;
  static const double previewSpacing = 50.0;
  static const double previewRunSpacing = 50.0;
  static const double previewPadding = 200.0;

  bool postsTab = true;

  // ignore: prefer_function_declarations_over_variables
  onTapFunction(String postID) {}

  switchTab(bool toChat) {
    postsTab = !toChat;
  }

  Widget postPreview(
          {required double size,
          required String url,
          required Function(String) onTap,
          required String postId}) =>
      Material(
        child: InkWell(
          onTap: onTap(postId),
          child: SizedBox(
              width: size,
              height: size,
              child: Image.network(url, fit: BoxFit.cover)),
        ),
      );

  Widget clubPosts() {
    List<Widget> postWidgets = [];
    for (int i = 0; i < posts.length; i++) {
      postWidgets.add(postPreview(
          size: MediaQuery.of(context).size.width * 2 / 9,
          url: posts[i]["image"]!,
          onTap: onTapFunction,
          postId: posts[i]["id"]!));
    }

    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: Wrap(
          children: postWidgets,
          //spacing: previewSpacing,
          //runSpacing: previewRunSpacing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png',
                  fit: BoxFit.fitWidth),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 12.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 48.0,
                        fontWeight:
                            postsTab ? FontWeight.normal : FontWeight.bold,
                      )),
                      onPressed: () {
                        setState(() {
                          postsTab = false;
                        });
                      },
                      child: Text("Posts")),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 12.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 48.0,
                        fontWeight:
                            !postsTab ? FontWeight.normal : FontWeight.bold,
                      )),
                      onPressed: () {
                        setState(() {
                          postsTab = true;
                        });
                      },
                      child: Text("Chat")),
                )
              ],
            ),
            clubPosts()
          ],
        )),
      ),
    );
  }
}