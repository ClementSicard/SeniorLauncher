import 'package:senior_launcher/models/edit_model.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:senior_launcher/utils/circle_avatar_custom.dart';

class ReorderWidget extends StatelessWidget {
  final EditModel editModel;
  final bool showId;

  const ReorderWidget(this.editModel, {Key key, @required this.showId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Item> _favItems = editModel.sortedItems;

    void reorderItems(int oldIndex, int newIndex) {
      editModel.reorderFavItems(oldIndex, newIndex);
    }

    return ReorderableListView(
      children: _favItems
          .map((Item item) => ReorderableCard(
                item: item,
                key: Key(item.id),
              ))
          .toList(),
      onReorder: (oldIndex, newIndex) => reorderItems(oldIndex, newIndex),
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 4),
    );
  }
}

class ReorderableCard extends StatelessWidget {
  const ReorderableCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            item.name,
            style: TextStyles.listTitle,
          ),
          leading: CustomCircleAvatar(item),
          trailing: const Icon(Icons.drag_handle),
        ),
      ),
    );
  }
}
