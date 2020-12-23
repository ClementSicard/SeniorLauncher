import 'package:senior_launcher/models/item.dart';
import 'package:flutter/material.dart';
import 'package:senior_launcher/ui/colors.dart';

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
              backgroundColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? seniorDarkGrey
                      : Colors.white,
              radius: 26,
            ),
            backgroundColor: Colors.redAccent,
            radius: 29,
          )
        : item.icon.isNotEmpty
            ? Container(
                height: 58,
                child: ClipRRect(
                  child: Image(
                    image: MemoryImage(item.icon),
                  ),
                  borderRadius: BorderRadius.circular(60.0),
                ),
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
    return s != null ? double.parse(s, (e) => null) != null : false;
  }
}
