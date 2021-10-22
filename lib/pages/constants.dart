import 'package:flutter/material.dart';

List<String> algList = [
  'Selection Sort',
  'Bubble Sort',
  'Insertion Sort',
  'Merge Sort',
  'Quicksort',
  'Heap Sort',
  'Radix Sort',
  'Pigeonhole Sort',
  'Shellsort',
  'Comb Sort',
  'Bucket Sort'
];

class IndexBox extends StatefulWidget {
  @override
  _IndexBoxState createState() => _IndexBoxState();
  final int value;
  final double maxHeight;
  final double maxWidth;
  final int totalAmount;
  IndexBox({this.value, this.maxHeight, this.maxWidth, this.totalAmount});
}

class _IndexBoxState extends State<IndexBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.maxWidth / widget.totalAmount,
      height: widget.maxHeight * (widget.value / 100.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
