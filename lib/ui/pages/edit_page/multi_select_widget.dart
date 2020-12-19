import 'package:senior_launcher/models/edit_model.dart';
import 'package:senior_launcher/models/item.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';

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

        return CheckboxListTile(
          key: Key(item.id),
          title: Text(
            item.name,
            style: TextStyles.listTitle,
          ),
          subtitle: showId
              ? Text(
                  item.id,
                  style: TextStyles.listTitle,
                )
              : null,
          secondary: item.icon.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: Image(
                    image: MemoryImage(item.icon),
                  ).image,
                  backgroundColor: Colors.white,
                  radius: 29,
                )
              : const CircleAvatar(
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
          value: isFav,
          onChanged: (bool isChecked) {
            toggleFav(position);
          },
        );
      },
      separatorBuilder: (_, __) {
        return Divider(
          thickness: Values.dividerThickness,
        );
      },
    );
  }
}
