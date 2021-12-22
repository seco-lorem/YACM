import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

/// This is a widget that implements the view for publishing posts
///
/// It works for both [Event] and [Poll] posts
class AddPost extends StatelessWidget {
  final bool postChoice;
  final VoidCallback onPostTypeChange;
  final List<File?> photos;
  final Function(int) addPhoto;
  final List<TextEditingController> options;
  final TextEditingController pollQuestionController;
  final TextEditingController descriptionController;
  final bool commentsOn;
  final Function(bool) changeCommentsOn;
  final VoidCallback onPublish;
  const AddPost(
      {Key? key,
      required this.postChoice,
      required this.onPostTypeChange,
      required this.photos,
      required this.addPhoto,
      required this.options,
      required this.pollQuestionController,
      required this.descriptionController,
      required this.commentsOn,
      required this.changeCommentsOn,
      required this.onPublish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _photo(int index, File? photo) {
      return InkWell(
        onTap: () => addPhoto(index),
        child: Container(
          width: (UIConstants.getPostWidth(context) / 5) - 10,
          height: (UIConstants.getPostWidth(context) / 5) - 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstants.borderRadius),
            color: Colors.transparent.withOpacity(.1),
          ),
          child: photo != null
              ? Image.file(
                  photo,
                  fit: BoxFit.fill,
                )
              : Center(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).own().optionColor,
                  ),
                ),
        ),
      );
    }

    Widget _option(int index) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        width: UIConstants.getPostWidth(context) * .8,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).own().optionColor),
          borderRadius: BorderRadius.circular(UIConstants.borderRadius),
          color: Theme.of(context).own().optionColor,
        ),
        child: TextField(
            maxLength: 80,
            textAlign: TextAlign.justify,
            controller: options[index],
            style: TextStyle(
                color: Theme.of(context).own().optionText, fontSize: 16),
            cursorColor: Theme.of(context).own().optionText,
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: "Option (will be ignored if empty)",
                hintStyle: TextStyle(
                    color: Theme.of(context).own().optionText.withOpacity(.9),
                    fontSize: 16))),
      );
    }

    List<Widget> addPhotos() {
      List<File?> _photos = photos;

      for (int i = photos.length; i < 8; i++) {
        _photos.add(null);
      }

      List<Widget> _returnList = [];
      for (int i = 0; i < 8; i++) {
        _returnList.add(_photo(i, _photos[i]));
      }

      return _returnList;
    }

    Widget addOptions() {
      List<Widget> _returnList = [
        TextField(
            maxLength: 80,
            textAlign: TextAlign.center,
            controller: pollQuestionController,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            cursorColor: Colors.grey[600],
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: "Type Question")),
      ];
      for (int i = 0; i < 5; i++) {
        _returnList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: _option(i),
        ));
      }

      return Column(
        children: _returnList,
      );
    }

    Widget addDescription() {
      return ListTile(
        title: Text(
          "Description",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).own().optionColor),
        ),
        subtitle: TextField(
            maxLength: 80,
            textAlign: TextAlign.justify,
            controller: descriptionController,
            style: TextStyle(color: Colors.grey[600], fontSize: 15),
            cursorColor: Colors.grey[600],
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: "Type Description")),
      );
    }

    Widget addCommentsOn() {
      return ListTile(
        leading: Text("Enable Comments",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).own().optionColor)),
        trailing: Switch.adaptive(
          value: commentsOn,
          onChanged: changeCommentsOn,
        ),
      );
    }

    Widget create() {
      return InkWell(
        onTap: onPublish,
        child: Container(
          width: UIConstants.getPostWidth(context) * .6,
          decoration: BoxDecoration(
              color: Theme.of(context).own().optionColor,
              borderRadius: BorderRadius.circular(UIConstants.borderRadius)),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Center(
              child: Text("Publish",
                  style: TextStyle(
                      color: Theme.of(context).own().background,
                      fontSize: 16))),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(.7),
      child: Center(
        child: Container(
          width: UIConstants.getPostWidth(context),
          height: UIConstants.getPostWidth(context) * .8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).own().background,
              border: Border.all(color: Colors.transparent.withOpacity(.5)),
              borderRadius: BorderRadius.circular(UIConstants.borderRadius)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: onPostTypeChange,
                        child: Text(
                          "Event",
                          style: TextStyle(
                              color: Theme.of(context).own().optionColor,
                              fontWeight: postChoice
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 16),
                        )),
                    TextButton(
                        onPressed: onPostTypeChange,
                        child: Text(
                          "Poll",
                          style: TextStyle(
                              color: Theme.of(context).own().optionColor,
                              fontWeight: !postChoice
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 16),
                        ))
                  ],
                ),
                Visibility(
                  visible: postChoice,
                  child: SizedBox(
                    width: UIConstants.getPostWidth(context) - 40,
                    child: Center(
                      child: Wrap(
                        children: addPhotos(),
                        spacing: 10,
                        runSpacing: 10,
                      ),
                    ),
                  ),
                ),
                Visibility(visible: !postChoice, child: addOptions()),
                addDescription(),
                addCommentsOn(),
                create(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}