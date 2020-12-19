import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../constants/custom_functions.dart';
import '../theme.dart';

class FatButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidFunction onClickAction;

  const FatButton(this.label, this.icon, this.onClickAction);
  const FatButton.next(this.label, this.onClickAction)
      : icon = Icons.navigate_next;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyles.actionButtonLabel,
          ),
          Icon(
            icon,
            size: 35,
          )
        ],
      ),
      onPressed: () => onClickAction(),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidFunction onClickAction;

  const PrimaryButton(this.label, this.onClickAction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: AutoSizeText(
          label,
          maxLines: 1,
          style: TextStyles.primaryButtonLabel,
        ),
        onPressed: () => onClickAction(),
      ),
    );
  }
}
