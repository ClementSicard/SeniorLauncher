import 'package:provider/provider.dart';
import 'package:senior_launcher/models/contact_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:senior_launcher/constants/edit_mode.dart';
import 'package:senior_launcher/generated/l10n.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/ui/pages/home_page/apps_tab.dart';
import 'package:senior_launcher/ui/pages/home_page/contacts_tab.dart';
import 'package:senior_launcher/ui/pages/home_page/edit_dialog.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:senior_launcher/utils/clock.dart';
import 'package:senior_launcher/utils/constants.dart';
import 'package:senior_launcher/utils/date.dart';
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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            print('Assistance');
            const contactClement = Item(Constants.TEL_CLEMENT,
                'Appeler Clément à la rescousse 🚨', null);
            CallDialog(context, contactClement, support: true);
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
              icon: const Text(
                'SOS',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (nContext) {
                  List<Item> urgences = const [
                    Item('15', 'SAMU', null),
                    Item('17', 'POLICE', null),
                    Item('18', 'POMPIERS', null),
                    Item('112', 'GENERAL', null),
                  ];
                  return CupertinoActionSheet(
                    actions: urgences
                        .map(
                          (u) => CupertinoActionSheetAction(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  title: Text(
                                    'Es-tu sûre de vouloir appeler le ${u.id} ?',
                                    style: TextStyles.dialogTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  content: null,
                                  actions: [
                                    IconButton(
                                      icon: const Icon(Icons.check),
                                      iconSize: 110,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Provider.of<ContactModel>(context,
                                                listen: false)
                                            .callPhoneNumber(u.id);
                                      },
                                      color: Colors.green,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.clear),
                                      iconSize: 110,
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.red,
                                    ),
                                  ],
                                );
                              },
                            ),
                            child: Text(
                              '${u.name} (${u.id})',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            isDestructiveAction: true,
                          ),
                        )
                        .toList(),
                    cancelButton: CupertinoActionSheetAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.pop(nContext),
                      child: const Text('ANNULER'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: GestureDetector(
          onLongPress: () =>
              openEditDialog(DefaultTabController.of(context).index),
          child: Clock(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0, 90),
          child: Column(
            children: <Widget>[
              DateWidget(),
              const SizedBox(height: 20),
              TabBar(
                tabs: [
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
                              style: const TextStyle(fontSize: 50),
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
                            child: Icon(Icons.people),
                          ),
                          Flexible(
                            child: AutoSizeText(
                              S.of(context).Contacts,
                              group: _appBarTextSizeGroup,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 50),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                indicatorColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          AppsTab(),
          ContactsTab(),
        ],
      ),
    );
  }
}
