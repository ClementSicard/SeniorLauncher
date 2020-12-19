import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class NativeMethods {
  final platform = MethodChannel('arjunsinh.xyz/senior_launcher');

  void launchContactsApp() {
    platform.invokeMethod('launchContactsApp');
  }

  void launchDialerApp(String number) {
    platform.invokeMethod('launchDialerWithNumber', {'number': number});
  }

  void launchWhatsAppConv(String number) async {
    var whatsappUrl = 'whatsapp://send?phone=$number';
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            'open whatsapp app link or do a snackbar with notification that there is no whatsapp installed');
  }

  void startPhoneCall(String number) {
    platform.invokeMethod('startPhoneCall', {'number': number});
  }

  void sendSMStoANumber(String number) async {
    String uri = 'sms:' + number;
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Future<bool> hasTelephoneFeature() async {
    return await platform.invokeMethod<bool>('hasTelephoneFeature');
  }

  Future<List<String>> getDeprecatedPrefsList() async {
    List<String> stringList = [];
    try {
      stringList =
          await platform.invokeListMethod<String>('getDeprecatedFavAppIds');
    } on PlatformException catch (e) {
      print(e);
    }
    return stringList;
  }
}
