import 'package:SeniorLauncher/screens/names.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<ApplicationWithIcon> apps;
  int wrapSize = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: true,
            onlyAppsWithLaunchIntent: true),
        builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
          if (data.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            apps = data.data;
            return SingleChildScrollView(
              child: Wrap(
                children: [
                  Row(
                    children: apps.map(
                      (app) {
                        if (appNames.contains(app.appName)) {
                          return GestureDetector(
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width / wrapSize,
                              height:
                                  MediaQuery.of(context).size.width / wrapSize,
                              child: Expanded(
                                child: Card(
                                  child: app is ApplicationWithIcon
                                      ? CircleAvatar(
                                          backgroundImage:
                                              MemoryImage(app.icon),
                                          backgroundColor: Colors.white,
                                        )
                                      // title: Text('${app.appName}'),
                                      : null,
                                ),
                              ),
                            ),
                            onTap: () => DeviceApps.openApp(app.packageName),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
