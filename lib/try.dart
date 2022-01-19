
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Try extends StatefulWidget {
  const Try({Key? key}) : super(key: key);

  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {

  static const Map<String, Duration> frequencyOptions = {
    "30 seconds": Duration(seconds: 30),
    "1 minute": Duration(minutes: 1),
    "2 minutes": Duration(minutes: 2),
  };

  Duration _frequencyValue = Duration(seconds: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  DropdownButton<Duration>(
        items: frequencyOptions
            .map((description, value) {
          return MapEntry(
              description,
              DropdownMenuItem<Duration>(
                value: value,
                child: Text(description),
              ));
        })
            .values
            .toList(),
        value: _frequencyValue,
        onChanged: (Duration? newValue) {
          if (newValue != null) {
            setState(() {
              _frequencyValue = newValue;
            });
          }
        },
      ),
    );
  }
}
