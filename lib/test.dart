import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSwitchTile extends StatelessWidget {
  const CupertinoSwitchTile({
    // required this.title,
    required this.value,
    this.onChanged,
  });

  // final bool title;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: null,
      title: Text("test"),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}