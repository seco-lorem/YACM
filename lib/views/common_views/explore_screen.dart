import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/helper.dart';
import 'package:yacm/views/common_widgets/post_widgets/grid_post_widget.dart';

/// This is a screen for explore page
/// which works both on mobile (iOS and Android) and web
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(top: 60),
      color: Theme.of(context).own().background,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: GridPost(posts: Helper.posts),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
