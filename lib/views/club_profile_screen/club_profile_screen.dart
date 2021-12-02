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
              child: Image.network(url, fit: BoxFit.fill)),
        ),
      );

  Widget clubPosts() {
    List<Widget> postWidgets = [];
    for (int i = 0; i < posts.length; i++) {
      postWidgets.add(postPreview(
          size: previewSize,
          url: posts[i]["image"]!,
          onTap: onTapFunction,
          postId: posts[i]["id"]!));
    }

    return Container(
      padding: const EdgeInsets.all(previewPadding),
      child: Wrap(
        children: postWidgets,
        spacing: previewSpacing,
        runSpacing: previewRunSpacing,
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
            Image.network(
                'https://upload.wikimedia.org/wikipedia/tr/e/ee/Bilkent%C3%9Cniversitesi-logo.png'),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 12.0),
                child: Text(clubDescription,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ))),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox.expand(
                      child: InkWell(
                          onTap: () {},
                          child: Text("Posts",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: postsTab
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 22)))),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 20,
                  ),
                  SizedBox.expand(
                      child: InkWell(
                          onTap: () {},
                          child: Text("Chat",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: postsTab
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  fontSize: 22))))
                ])),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 12.0),
                    child: Text("Posts",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 48.0,
                          fontWeight:
                              postsTab ? FontWeight.normal : FontWeight.bold,
                        ))),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 12.0),
                    child: Text("Chat",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 48.0,
                          fontWeight:
                              !postsTab ? FontWeight.normal : FontWeight.bold,
                        ))),
              ],
            ),*/
            clubPosts()
          ],
        )),
      ),
    );
  }
}
