import 'package:senior_launcher/models/edit_model.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:senior_launcher/utils/circle_avatar_custom.dart';

class MultiSelectWidget extends StatelessWidget {
  final EditModel editModel;
  final bool showId;

  const MultiSelectWidget(this.editModel, {Key key, @required this.showId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Item> _allItems = editModel.sortedItems;

    void toggleFav(int position) {
      editModel.toggleFav(position);
    }

    return ListView.separated(
      itemCount: _allItems.length,
      itemBuilder: (context, position) {
        var item = _allItems[position];
        var isFav = editModel.isFav(position);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SwitchListTile(
              key: Key(item.id),
              title: Text(
                item.name,
                style: TextStyles.listTitle,
              ),
              subtitle: showId
                  ? Text(
                      item.id,
                      style: TextStyles.listSubtitle,
                    )
                  : null,
              secondary: CustomCircleAvatar(item),
              value: isFav,
              onChanged: (bool isChecked) {
                toggleFav(position);
              },
            ),
          ),
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 5,
        );
        // return const Divider(
        //   thickness: Values.dividerThickness,
        // );
      },
    );
  }
}
