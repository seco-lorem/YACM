import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final List<Widget> posts;
  const HomeBody({Key? key, this.posts = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: double.infinity,
          child: Column(children: posts),
        ),
      ),
    );
  }
}
