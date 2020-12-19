import 'package:senior_launcher/data_sources/app_repository.dart';
import 'package:senior_launcher/data_sources/contact_repository.dart';
import 'package:senior_launcher/models/app_model.dart';
import 'package:senior_launcher/models/contact_model.dart';
import 'package:senior_launcher/generated/l10n.dart';
import 'package:senior_launcher/ui/pages/home_page/home_page.dart';
import 'package:senior_launcher/ui/router.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(
            create: (_) => AppModel(dataRepository: AppRepository())),
        ChangeNotifierProvider<ContactModel>(
          create: (_) => ContactModel(
            dataRepository: ContactRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'SeniorLauncher',
        home: DefaultTabController(length: 2, child: HomePage()),
        onGenerateRoute: generateRoute,
        localizationsDelegates: [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
