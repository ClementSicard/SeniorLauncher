import 'package:flutter/material.dart';
import 'package:senior_launcher/ui/colors.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            backgroundColor: CustomColors.seniorGrey,
            children: <Widget>[
              Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
