import 'package:senior_launcher/constants/edit_mode.dart';
import 'package:senior_launcher/constants/route_names.dart';
import 'package:senior_launcher/models/app_model.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/generated/l10n.dart';
import 'package:senior_launcher/ui/common/loading_widget.dart';
import 'package:senior_launcher/ui/pages/home_page/fav_grid_view.dart';
import 'package:senior_launcher/ui/common/info_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppsTab extends StatelessWidget {
  const AppsTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openAllApps() {
      Provider.of<AppModel>(context, listen: false).reloadLists();
      Navigator.pushNamed(context, AppDrawerRoute);
    }

    void openEditScreen() {
      Navigator.pushNamed(context, EditPageRoute, arguments: EditMode.apps);
    }

    void launchApp(Item app) {
      Provider.of<AppModel>(context, listen: false).launchApp(app.id);
    }

    return Column(children: <Widget>[
      Flexible(
        child: Consumer<AppModel>(
          builder: (_, appModel, __) => Column(
            children: <Widget>[
              if (appModel.isFavListLoaded && appModel.favApps.isNotEmpty) ...[
                FavGridView(appModel.favApps, launchApp, openEditScreen),
              ] else if (appModel.isFavListLoaded &&
                  appModel.favApps.isEmpty) ...[
                Expanded(
                  child: InfoActionWidget.add(
                    message: S.of(context).msgNoFavourites,
                    buttonLabel: S.of(context).btnAddFavApps,
                    buttonOnClickAction: openEditScreen,
                  ),
                ),
              ] else ...[
                Center(
                  child: LoadingWidget(),
                )
              ],
            ],
          ),
        ),
      ),
      // Align(
      //   alignment: Alignment.bottomCenter,
      //   child: PrimaryButton(S.of(context).btnAllApps, openAllApps),
      // ),
    ]);
  }
}
