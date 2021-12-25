import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/post/posts/poll.dart';

class Helper {
  static List<Post> posts = [
    Event(
        "_author",
        "_club",
        false,
        "_message",
        DateTime.now(),
        [
          "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg"
        ],
        DateTime.now(),
        DateTime.now(),
        [],
        "1"),
    Poll("_author", "_club", false, "_message", DateTime.now(),
        ["1", "2", "3", "4", "5"], [1, 2, 3, 4, 5], "_question", "11"),
    Event(
        "_author",
        "_club",
        false,
        "_message",
        DateTime.now(),
        [
          "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg"
        ],
        DateTime.now(),
        DateTime.now(),
        [],
        "2"),
    Poll("_author", "_club", false, "_message", DateTime.now(),
        ["1", "2", "3", "4", "5"], [1, 2, 3, 4, 5], "_question", "12"),
    Event(
        "_author",
        "_club",
        false,
        "_message",
        DateTime.now(),
        [
          "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg"
        ],
        DateTime.now(),
        DateTime.now(),
        [],
        "3"),
    Poll("_author", "_club", false, "_message", DateTime.now(),
        ["1", "2", "3", "4", "5"], [1, 2, 3, 4, 5], "_question", "13"),
  ];

  static List<Message> comments = [
    Message(
        "_message",
        "_senderName",
        "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg",
        DateTime.now().toString(),
        ""),
    Message(
        "_message",
        "_senderName",
        "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg",
        DateTime.now().toString(),
        ""),
    Message(
        "_message",
        "_senderName",
        "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg",
        DateTime.now().toString(),
        ""),
    Message(
        "_message",
        "_senderName",
        "https://image.shutterstock.com/image-photo/view-modern-skyscrapers-abstract-architecture-600w-1323075257.jpg",
        DateTime.now().toString(),
        "")
  ];
}
