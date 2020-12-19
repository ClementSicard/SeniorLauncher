import 'package:senior_launcher/models/item.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final Item item;
  const CustomCircleAvatar(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.icon.isNotEmpty &&
            isNumeric(item.id.replaceAll(RegExp('\\+'), ''))
        ? CircleAvatar(
            child: CircleAvatar(
              backgroundImage: Image(
                image: MemoryImage(item.icon),
              ).image,
              backgroundColor: Colors.white,
              radius: 26,
            ),
            backgroundColor: Colors.redAccent,
            radius: 29,
          )
        : item.icon.isNotEmpty
            ? CircleAvatar(
                backgroundImage: Image(
                  image: MemoryImage(item.icon),
                ).image,
                backgroundColor: Colors.white,
                radius: 29,
              )
            : const CircleAvatar(
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                radius: 29,
                backgroundColor: Colors.redAccent,
              );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
