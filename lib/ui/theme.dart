import 'package:senior_launcher/ui/colors.dart';
import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  primaryColor: Colors.red[400],
  accentColor: Colors.redAccent[100],
  backgroundColor: seniorWhite,
  cardColor: seniorGrey,
  textTheme: Typography.blackMountainView,
  cardTheme: CardTheme(
    color: seniorGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    margin: const EdgeInsets.all(4.0),
    elevation: 0,
  ),
);

var darkTheme = ThemeData(
  primaryColor: Colors.red[400],
  accentColor: Colors.redAccent[100],
  backgroundColor: seniorBlack,
  cardColor: seniorDarkGrey,
  dividerTheme: DividerThemeData(color: seniorGrey),
  textTheme: Typography.whiteMountainView,
  cardTheme: CardTheme(
    color: seniorDarkGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    margin: const EdgeInsets.all(4),
    elevation: 0,
  ),
);

class TextStyles {
  static const cardTitle = TextStyle(fontSize: 21);
  static const listTitle = TextStyle(fontSize: 21);
  static const listSubtitle = TextStyle(fontSize: 17);
  static const headerTime = TextStyle(fontSize: 27);
  static const headerDate = TextStyle(color: Colors.white, fontSize: 21);
  static const infoMessage = TextStyle(fontSize: 19);
  static const actionButtonLabel = TextStyle(fontSize: 21, color: Colors.white);
  static const primaryButtonLabel =
      TextStyle(color: Colors.white, fontSize: 45, height: 1);
  static const dialogTitle = TextStyle(color: Colors.black, fontSize: 20);
  static const dialogAction = TextStyle(color: Colors.blue, fontSize: 18);
  static const dialogActionMain =
      TextStyle(color: Colors.blue, fontSize: 19, fontWeight: FontWeight.w400);
}

class Values {
  static const double dividerThickness = 0;
  static const double primaryButtonHeight = 55;
  static const double fabSafeBottomPadding = 45;
}
