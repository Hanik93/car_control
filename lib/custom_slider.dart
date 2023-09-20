import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  CustomSlider({required this.value, required this.onChanged});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Slider(
            value: widget.value,
            onChanged: widget.onChanged,
            min: 0.0,
            max: 0.10,
            divisions: 10,
            label: "${widget.value.toStringAsFixed(2)}",
          ),
        ),
        Text("Speed", style: TextStyle(color: Colors.white, fontSize: 16))
      ],
    );
  }
}
