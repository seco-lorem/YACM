import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';
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
  late ClubManager _clubManager;
  late UserManager _userManager;
  List<File?> _photos = [null, null, null, null, null, null, null, null];

  void onPageChange(List<String> members) {}

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _clubManager = Provider.of<ClubManager>(context);
    _userManager = Provider.of<UserManager>(context);
  }

  Future<void> onPublish(Club club) async {
    if (addPostType) {
      await _clubManager.createEventPost({
        "attenders": [],
        "message": _descriptionController.text,
        "commentsOn": commentsOn,
        "publishDate": DateTime.now(),
        "beginDate": DateTime.now(),
        "endDate": DateTime.now(),
        "prerequisites": [],
        "managers": club.managers,
        "members": club.members,
        "advisor": club.advisor,
        "clubID": club.id,
        "clubName": club.clubName,
        "userPinned": [],
        "images": [],
        "type": "event"
      }, _photos);
    } else {
      List<String> _pollOptions = [];
      List<Map> _pollVotes = [];
      for (TextEditingController controller in _options) {
        if (controller.text.isNotEmpty) {
          _pollOptions.add(controller.text);
          _pollVotes.add({});
        }
      }
      await _clubManager.createPollPost({
        "message": _descriptionController.text,
        "commentsOn": commentsOn,
        "publishDate": DateTime.now(),
        "managers": club.managers,
        "members": club.members,
        "advisor": club.advisor,
        "clubID": club.id,
        "clubName": club.clubName,
        "votes": _pollVotes,
        "voters": [],
        "question": _pollQuestionController.text,
        "options": _pollOptions,
        "type": "poll",
        "userPinned": []
      });
    }

    setState(() {
      postsActive = true;
      commentsOn = true;
      addPostType = true;
      _addPostVisible = false;
      _descriptionController.clear();
      _pollQuestionController.clear();
      _photos = [null, null, null, null, null, null, null, null];
      _options[0].clear();
      _options[1].clear();
      _options[2].clear();
      _options[3].clear();
      _options[4].clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isAndroid || Platform.isIOS
          ? AppBar(
              backgroundColor: Theme.of(context).own().background,
            )
          : null,
      backgroundColor: Theme.of(context).own().background,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).own().background,
          child: StreamBuilder(
              stream: Provider.of<ClubManager>(context, listen: false)
                  .getClubStream(widget.id),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                Club _club = Club.fromDocumentSnapshot(snapshot.data!);
                return Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        ClubProfileHeader(
                            name: _userManager.user!.name,
                            clubID: _club.id,
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
                            isAdmin: Provider.of<UserManager>(context).user !=
                                    null
                                ? _club.managers.contains(
                                    Provider.of<UserManager>(context).user!.id)
                                : false,
                            description: _club.description,
                            postsActive: postsActive,
                            onPageChange: () {
                              if (_club.members
                                  .contains(_userManager.user!.id)) {
                                setState(() {
                                  postsActive = !postsActive;
                                });
                              }
                            }),
                        Expanded(
                          child: postsActive
                              ? StreamBuilder(
                                  stream: Provider.of<ClubManager>(context)
                                      .getClubPosts(widget.id),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> stream) {
                                    List<Post> posts = [];

                                    for (DocumentSnapshot post
                                        in stream.data!.docs) {
                                      if (post.get("type") == "event") {
                                        posts.add(
                                            Event.fromDocumentSnapshot(post));
                                      } else if (post.get("type") == "poll") {
                                        posts.add(
                                            Poll.fromDocumentSnapshot(post));
                                      }
                                    }

                                    return GridPost(
                                        posts: posts.reversed.toList());
                                  },
                                )
                              : ClubProfileMessages(
                                  isAdmin:
                                      Provider.of<UserManager>(context).user !=
                                              null
                                          ? _club.managers.contains(
                                              Provider.of<UserManager>(context)
                                                  .user!
                                                  .id)
                                          : false,
                                  clubID: _club.id),
                        ),
                        Visibility(
                          visible: !postsActive,
                          child: ClubProfileSendMessage(clubID: _club.id),
                        )
                      ],
                    ),
                    Visibility(
                      visible: _viewMembersVisible,
                      child: ViewMembers(members: _club.memberNames),
                    ),
                    Visibility(
                      visible: _kickMembersVisible,
                      child: KickMembers(
                        members: _club.memberNames,
                        clubID: _club.id,
                      ),
                    ),
                    Visibility(
                        visible: _addPostVisible,
                        child: AddPost(
                            onPublish: () {
                              onPublish(_club);
                            },
                            postChoice: addPostType,
                            onPostTypeChange: () {
                              setState(() {
                                addPostType = !addPostType;
                              });
                            },
                            photos: _photos,
                            addPhoto: (index) async {
                              XFile? _tempPhoto = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              if (_tempPhoto != null) {
                                var _tempPhotoForWeb =
                                    await _tempPhoto.readAsBytes();
                                setState(() {
                                  if (Platform.isIOS || Platform.isAndroid) {
                                    _photos[index] = File(_tempPhoto.path);
                                  } else {
                                    _photos[index] =
                                        File.fromRawPath(_tempPhotoForWeb);
                                  }
                                });
                              }
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
        ),
      ),
    );
  }
}
