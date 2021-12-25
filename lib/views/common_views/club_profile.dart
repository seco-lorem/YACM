import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/club_manager/club_manager.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/club/club.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/helper.dart';
import 'package:yacm/views/common_widgets/club_profile_widgets/club_profile_add_post.dart';
import 'package:yacm/views/common_widgets/club_profile_widgets/club_profile_footer.dart';
import 'package:yacm/views/common_widgets/club_profile_widgets/club_profile_header.dart';
import 'package:yacm/views/common_widgets/club_profile_widgets/club_profile_kick_member.dart';
import 'package:yacm/views/common_widgets/club_profile_widgets/club_profile_messages.dart';
import 'package:yacm/views/common_widgets/club_profile_widgets/club_profile_view_members.dart';
import 'package:yacm/views/common_widgets/post_widgets/event_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/grid_post_widget.dart';

/// This is a screen for club profile
/// which works both on mobile (iOS and Android) and web
class ClubProfile extends StatefulWidget {
  final String id;
  const ClubProfile({Key? key, required this.id}) : super(key: key);

  @override
  _ClubProfileState createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  bool postsActive = true;
  bool commentsOn = true;
  bool addPostType = true;
  bool _addPostVisible = false;
  bool _kickMembersVisible = false;
  bool _viewMembersVisible = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pollQuestionController = TextEditingController();
  final List<TextEditingController> _options = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final Map<String, String> _members = {
    "1": "Deniz Berkant Demirörs",
    "2": "Deniz Berkant Demirörs",
    "3": "Deniz Berkant Demirörs",
    "4": "Deniz Berkant Demirörs",
    "5": "Deniz Berkant Demirörs",
    "6": "Deniz Berkant Demirörs",
    "7": "Deniz Berkant Demirörs",
    "8": "Deniz Berkant Demirörs",
    "9": "Deniz Berkant Demirörs",
    "10": "Deniz Berkant Demirörs",
  };

  final List<Post> _posts = [
    Poll(
        "club",
        "club",
        true,
        "message",
        DateTime.now(),
        ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"],
        [1, 1, 1, 1, 1],
        "This is a sample question,",
        "234"),
    Event(
        "author",
        "club",
        true,
        "message",
        DateTime.now(),
        [
          "https://lh3.googleusercontent.com/proxy/LIId8Z2wWUFCjKrZbmfGiMxg5AahvgT4dIGOjcrdNh3exKa2dXbbObsUyHKyBckm3y8NbNvIbpfvmntyMPDcl9l7UpM22He5ikEYoCyVYeq7GVGlIzOgWqf6RGwsPyG9",
          "https://image.shutterstock.com/image-photo/view-valley-castle-hohenschwangau-600w-103574675.jpg",
          "https://image.shutterstock.com/image-photo/fairy-forest-covered-snow-moon-600w-744558304.jpg"
        ],
        DateTime.now().subtract(Duration(days: 1)),
        DateTime.now().add(Duration(days: 1)),
        [],
        "234"),
    Poll(
        "club",
        "club",
        true,
        "message",
        DateTime.now(),
        ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"],
        [1, 1, 1, 1, 1],
        "This is a sample question,",
        ""),
    Event(
        "author",
        "club",
        true,
        "message",
        DateTime.now(),
        [
          "https://lh3.googleusercontent.com/proxy/LIId8Z2wWUFCjKrZbmfGiMxg5AahvgT4dIGOjcrdNh3exKa2dXbbObsUyHKyBckm3y8NbNvIbpfvmntyMPDcl9l7UpM22He5ikEYoCyVYeq7GVGlIzOgWqf6RGwsPyG9",
          "https://image.shutterstock.com/image-photo/view-valley-castle-hohenschwangau-600w-103574675.jpg",
          "https://image.shutterstock.com/image-photo/fairy-forest-covered-snow-moon-600w-744558304.jpg"
        ],
        DateTime.now().subtract(Duration(days: 1)),
        DateTime.now().add(Duration(days: 1)),
        [],
        ""),
    Poll(
        "club",
        "club",
        true,
        "message",
        DateTime.now(),
        ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"],
        [1, 1, 1, 1, 1],
        "This is a sample question,",
        ""),
    Event(
        "author",
        "club",
        true,
        "message",
        DateTime.now(),
        [
          "https://lh3.googleusercontent.com/proxy/LIId8Z2wWUFCjKrZbmfGiMxg5AahvgT4dIGOjcrdNh3exKa2dXbbObsUyHKyBckm3y8NbNvIbpfvmntyMPDcl9l7UpM22He5ikEYoCyVYeq7GVGlIzOgWqf6RGwsPyG9",
          "https://image.shutterstock.com/image-photo/view-valley-castle-hohenschwangau-600w-103574675.jpg",
          "https://image.shutterstock.com/image-photo/fairy-forest-covered-snow-moon-600w-744558304.jpg"
        ],
        DateTime.now().subtract(Duration(days: 1)),
        DateTime.now().add(Duration(days: 1)),
        [],
        "")
  ];

  void onPageChange() {
    setState(() {
      postsActive = !postsActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).own().background,
      child: StreamBuilder(
          stream: Provider.of<ClubManager>(context, listen: false)
              .getClubStream(widget.id),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            Club _club = Club.fromDocumentSnapshot(snapshot.data!);
            return Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ClubProfileHeader(
                          onViewMembers: () {
                            setState(() {
                              _viewMembersVisible = !_viewMembersVisible;
                            });
                          },
                          onKickMembers: () {
                            setState(() {
                              _kickMembersVisible = !_kickMembersVisible;
                            });
                          },
                          onCreatePost: () {
                            setState(() {
                              _addPostVisible = !_addPostVisible;
                            });
                          },
                          url: _club.clubPhoto,
                          isAdmin: true,
                          description: "This is a sample description",
                          postsActive: postsActive,
                          onPageChange: () => onPageChange()),
                      postsActive
                          ? StreamBuilder(
                              stream: Provider.of<ClubManager>(context)
                                  .getClubPosts(widget.id),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> stream) {
                                List<Post> posts = [];
                                if (stream.hasData) {
                                  for (DocumentSnapshot post
                                      in stream.data!.docs) {
                                    if (post.get("type") == "event") {
                                      posts.add(
                                          Event.fromDocumentSnapshot(post));
                                    } else if (post.get("type") == "poll") {
                                      posts
                                          .add(Poll.fromDocumentSnapshot(post));
                                    }
                                  }
                                }
                                return GridPost(posts: posts);
                              },
                            )
                          : ClubProfileMessages(
                              isAdmin: false, messages: Helper.comments),
                      Visibility(
                        visible: !postsActive,
                        child: ClubProfileSendMessage(),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _viewMembersVisible,
                  child: ViewMembers(members: _club.members),
                ),
                Visibility(
                  visible: _kickMembersVisible,
                  child: KickMembers(members: _members),
                ),
                Visibility(
                    visible: _addPostVisible,
                    child: AddPost(
                        onPublish: () {},
                        postChoice: addPostType,
                        onPostTypeChange: () {
                          setState(() {
                            addPostType = !addPostType;
                          });
                        },
                        photos: [],
                        addPhoto: (index) {
                          print(index);
                        },
                        options: _options,
                        pollQuestionController: _pollQuestionController,
                        descriptionController: _descriptionController,
                        commentsOn: commentsOn,
                        changeCommentsOn: (data) {
                          setState(() {
                            commentsOn = data;
                          });
                        })),
                Visibility(
                  visible: _addPostVisible ||
                      _kickMembersVisible ||
                      _viewMembersVisible,
                  child: Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _descriptionController.clear();
                          _pollQuestionController.clear();
                          _options.forEach((TextEditingController element) {
                            element.clear();
                          });
                          commentsOn = true;
                          addPostType = true;
                          _addPostVisible = false;
                          _kickMembersVisible = false;
                          _viewMembersVisible = false;
                        });
                      },
                    ),
                  ),
                )
              ],
            );
          }),
    ));
  }
}
