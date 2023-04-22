import 'dart:collection';

import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final int index;
  final void Function()? function;
  final bool selected;

  const FilterButton({
    Key? key,
    required this.index,
    required this.function,
    required this.selected,
  }) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  Map<int, String> textOptions = HashMap();

  @override
  Widget build(BuildContext context) {
    textOptions[0] = "Strength";
    textOptions[1] = "Cardio";
    textOptions[2] = "Flexibility";
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 3,
          ),
          color: (widget.selected) ? Colors.green : Colors.white,
          //Color(0xFF05861A)
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            textOptions[widget.index]!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: (widget.selected) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
