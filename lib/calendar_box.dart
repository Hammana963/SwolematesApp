import 'package:flutter/material.dart';

class CalendarBox extends StatelessWidget {
  final child;
  bool selected;
  final function;

  CalendarBox({this.child, required this.selected, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        // color: Colors.blue,
        decoration: BoxDecoration(
            color: selected ? Colors.green : Colors.grey,
            border: Border.all(color: Colors.black, width: 0.2)),
        // color: Colors.blue,
        // child: Center(child: Text((child).toString())), // dont group
        // child: Center(child: Text((child % 7).toString())), // group by columns
        // child: Center(child: Text(((child - (child % 7)) ~/ 7).toString())), // group by rows
      ),
    );
    ;
  }
}
