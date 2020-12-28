import 'package:permission_handler/permission_handler.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:senior_launcher/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Update {
  static void checkUpdateAndroid(BuildContext context) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      http.Response response =
          await http.get('https://clementsicard.github.io/AppInstaller/');
      final String resp = response.body;
      int index = resp.indexOf('-->');
      var resp2 = resp.substring(index + 3);
      int secIndex = index + 3 + resp2.indexOf('-->');
      var version = resp.substring(index + 8, secIndex);
      print(version);
      final String toDisplay =
          'Nouvelle version disponible! ($version)\nLa version actuelle est la ' +
              Constants.CURRENT_VERSION;
      print(toDisplay);
      if (Constants.CURRENT_VERSION != version) {
        Navigator.pop(context);
        return showDialog(
          context: context,
          builder: (nContext) {
            return AlertDialog(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: Text(
                toDisplay,
                style: TextStyles.dialogTitle,
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'Mettre à jour ?',
                textAlign: TextAlign.center,
                style: TextStyles.dialogActionMain,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  iconSize: 80,
                  onPressed: () async {
                    const url =
                        'https://dl.dropboxusercontent.com/s/1uzf6uwalzjym4a/SeniorLauncher.apk';
                    if (await canLaunch(url)) {
                      const downloadFolderPath =
                          '/storage/emulated/0/Download/';
                      var appName = 'SeniorLauncher_$version.apk';
                      await Fluttertoast.showToast(
                        msg: 'Téléchargement de la mise à jour...',
                        toastLength: Toast.LENGTH_LONG,
                      );
                      final taskId = await FlutterDownloader.enqueue(
                        url: url,
                        fileName: appName,
                        savedDir: downloadFolderPath,
                        showNotification: true,
                        openFileFromNotification: true,
                      );
                      try {
                        bool success = false;
                        while (!success) {
                          await Future.delayed(const Duration(seconds: 2));
                          success =
                              await FlutterDownloader.open(taskId: taskId);
                        }
                      } catch (e) {
                        await Fluttertoast.showToast(
                            msg: "Erreur lors de l'ouverture de l'APK");
                      }
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  color: Colors.green,
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  iconSize: 80,
                  onPressed: () => Navigator.pop(nContext),
                  color: Colors.red,
                ),
              ],
            );
          },
        );
      } else {
        Navigator.pop(context);
        return showDialog(
          context: context,
          builder: (nContext) {
            return AlertDialog(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: const Text(
                'Pas de nouvelle mise à jour disponible',
                style: TextStyles.dialogTitle,
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'Version: ${Constants.CURRENT_VERSION}',
                style: TextStyles.infoMessage,
              ),
              actions: [
                FlatButton(
                  child: const Text(
                    'RETOUR',
                    style: TextStyles.dialogAction,
                  ),
                  onPressed: () => Navigator.pop(nContext),
                ),
              ],
            );
          },
        );
      }
    } catch (_) {
      await Fluttertoast.showToast(msg: 'Erreur pendant la mise à jour');
    }
  }

  static void launchManual(BuildContext context) async {
    const url =
        'https://drive.google.com/file/d/1cvWyqcxeO9f9ppLecnCNPcDs2Utl_0Yv/view?usp=sharing';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
