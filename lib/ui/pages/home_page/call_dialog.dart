import 'dart:ui';
import 'package:senior_launcher/models/app_model.dart';
import 'package:senior_launcher/models/contact_model.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/generated/l10n.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:senior_launcher/utils/constants.dart';
import 'package:senior_launcher/utils/update.dart';

Future CallDialog(BuildContext context, Item contact,
    {bool support = false, bool secureCall = false}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text(
        contact.name,
        style: TextStyles.dialogTitle,
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: const Icon(
                    Icons.call,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
                Text(
                  S.of(context).dlgCall,
                  style: TextStyles.dialogActionMain,
                ),
              ],
            ),
          ),
          onPressed: () => {
            Navigator.pop(context),
            Provider.of<ContactModel>(context, listen: false)
                .callPhoneNumber(contact.id)
          },
          isDefaultAction: true,
        ),
        CupertinoActionSheetAction(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: Icon(
                    Icons.sms,
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                ),
                Text(
                  'Envoyer un SMS',
                  style: TextStyles.dialogActionMain,
                ),
              ],
            ),
          ),
          onPressed: () => {
            Navigator.pop(context),
            Provider.of<ContactModel>(context, listen: false)
                .sendSMSPhoneNumber(contact.id),
          },
          isDefaultAction: true,
        ),
        Visibility(
          visible: contact.id != '',
          child: CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Icon(
                      MaterialCommunityIcons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Contacter sur WhatsApp',
                    style: TextStyles.dialogActionMain,
                  ),
                ],
              ),
            ),
            onPressed: () => {
              Navigator.pop(context),
              Provider.of<ContactModel>(context, listen: false)
                  .goToWhatsAppConv(contact.id)
            },
            isDefaultAction: true,
          ),
        ),
        Visibility(
          visible: support || contact.id == Constants.TEL_CLEMENT,
          child: CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Icon(
                      MaterialCommunityIcons.teamviewer,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Contrôle à distance',
                    style: TextStyles.dialogActionMain,
                  ),
                ],
              ),
            ),
            onPressed: () {
              final String id = 'com.teamviewer.quicksupport.market';
              Navigator.pop(context);
              Provider.of<AppModel>(context, listen: false).launchApp(id);
            },
            isDefaultAction: true,
          ),
        ),
        Visibility(
          visible: support,
          child: CupertinoActionSheetAction(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Icon(
                      MaterialCommunityIcons.update,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Mettre à jour',
                    style: TextStyles.dialogActionMain,
                  ),
                ],
              ),
            ),
            onPressed: () => Update.checkUpdateAndroid(context),
            isDefaultAction: true,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            S.of(context).dlgCancel.toUpperCase(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}
