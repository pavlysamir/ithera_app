import 'dart:async';
import 'package:flutter/material.dart';

class CountdownButton extends StatefulWidget {
  const CountdownButton({super.key});

  @override
  _CountdownButtonState createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  static const int initialTime = 5 * 60; // 5 minutes in seconds
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = initialTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formattedTime,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        //const SizedBox(height: 5),
        TextButton(
          onPressed: _remainingTime > 0
              ? null
              : () {
                  // RegisterCubit.get(context)!.verifyMobileNum();
                },
          child: Text(
            _remainingTime > 0 ? 'Please wait' : 'Resend',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
