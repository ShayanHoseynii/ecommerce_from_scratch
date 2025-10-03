import 'package:flutter/material.dart';

class ChoiceChip2 extends StatelessWidget {
  const ChoiceChip2({super.key, required this.text, required this.selected, this.onSelected});

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(text),
      selected: selected,
      onSelected: onSelected,
      );
  }
}
