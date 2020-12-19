import 'package:auto_size_text/auto_size_text.dart';
import 'package:senior_launcher/constants/custom_functions.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:senior_launcher/utils/circle_avatar_custom.dart';

class FavGridView extends StatelessWidget {
  final List<Item> favItems;
  final VoidItemFunction itemOnClickAction;
  final VoidFunction openEditScreenFunction;

  const FavGridView(
    this.favItems,
    this.itemOnClickAction,
    this.openEditScreenFunction, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutoSizeGroup itemName = AutoSizeGroup();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        child: GridView.count(
          childAspectRatio: 1.25,
          crossAxisCount: 2,
          children: favItems.map((item) {
            return Card(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 1,
              child: InkWell(
                splashColor: Colors.red.withAlpha(50),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ...[
                        CustomCircleAvatar(item),
                      ],
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: AutoSizeText(
                            item.name,
                            group: itemName,
                            maxLines: 2,
                            style: TextStyles.cardTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => itemOnClickAction(item),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
