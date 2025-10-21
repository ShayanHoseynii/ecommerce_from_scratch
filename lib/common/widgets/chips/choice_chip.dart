import 'package:cwt_starter_template/common/widgets/containers/circular_container.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    print('text in ChoiceChip: $text');
    final isColor = THelperFunctions.getColor(text) != null;
    final color = THelperFunctions.getColor(text);
    print('ChoiceChip Color: $color, isColor: $isColor');
    return ChoiceChip(
      label: isColor ? SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      avatar:
          isColor
              ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: color!,
              )
              : null,
      labelPadding: isColor ? EdgeInsets.all(0) : null,
      padding: isColor ? EdgeInsets.all(0) : null,
      shape: isColor ? CircleBorder() : null,
      selectedColor: isColor ? color : null,
      backgroundColor: isColor ? color : null,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
