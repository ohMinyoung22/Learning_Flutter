import 'package:flutter/material.dart';
import 'package:random_number/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Body(maxNumber: maxNumber),
              _Footer(
                maxNumber: maxNumber,
                onSliderChanged: onSliderChanged,
                onButtonPressed: onButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }

  void onSliderChanged(val) {
    setState(() {
      maxNumber = val;
    });
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: maxNumber.toString().split('').map((e) => Text(e)).toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final ValueChanged<double>? onSliderChanged;
  final double maxNumber;
  final VoidCallback onButtonPressed;

  const _Footer(
      {required this.onButtonPressed,
      required this.maxNumber,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            min: 1000,
            max: 100000,
            value: maxNumber,
            onChanged: onSliderChanged),
        ElevatedButton(
          onPressed: onButtonPressed,
          child: Text('저장!'),
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
        )
      ],
    );
  }
}
