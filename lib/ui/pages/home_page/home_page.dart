import 'package:auto_size_text/auto_size_text.dart';
import 'package:senior_launcher/constants/edit_mode.dart';
import 'package:senior_launcher/models/date_time_model.dart';
import 'package:senior_launcher/generated/l10n.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/ui/pages/home_page/apps_tab.dart';
import 'package:senior_launcher/ui/pages/home_page/contacts_tab.dart';
import 'package:senior_launcher/ui/pages/home_page/edit_dialog.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'call_dialog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AutoSizeGroup _appBarTextSizeGroup = AutoSizeGroup();

    void openEditDialog(int tabIndex) {
      EditMode editMode;

      if (tabIndex == 0) {
        editMode = EditMode.apps;
      } else {
        editMode = EditMode.contacts;
      }

      EditDialog(context, editMode);
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: ChangeNotifierProvider(
        create: (_) =>
            DateTimeModel(MediaQuery.of(context).alwaysUse24HourFormat),
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  print('Assistance');
                  var contactClement = Item('+33781781494',
                      'Appeler Clément à la rescousse 🚨', null);
                  CallDialog(context, contactClement, true);
                },
                icon: const Icon(
                  FontAwesome.life_bouy,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        openEditDialog(DefaultTabController.of(context).index),
                  ),
                ),
              ],
              centerTitle: true,
              title: Consumer<DateTimeModel>(
                builder: (_, dateTimeModel, __) => AutoSizeText(
                  dateTimeModel.time,
                  maxLines: 1,
                  style: TextStyles.headerTime,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size(0, 80),
                child: Column(
                  children: <Widget>[
                    Consumer<DateTimeModel>(
                      builder: (_, dateTimeModel, __) => AutoSizeText(
                        dateTimeModel.date,
                        group: _appBarTextSizeGroup,
                        maxLines: 1,
                        style: TextStyles.headerDate,
                      ),
                    ),
                    TabBar(tabs: [
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                child: Icon(Icons.apps),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  S.of(context).Apps,
                                  group: _appBarTextSizeGroup,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                                child: Icon(Icons.contacts),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  S.of(context).Contacts,
                                  group: _appBarTextSizeGroup,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 50),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            body: TabBarView(children: <Widget>[AppsTab(), ContactsTab()])),
      ),
    );
  }
}
