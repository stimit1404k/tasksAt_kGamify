import 'dart:async';
import 'package:flutter/material.dart';

class FlipClock extends StatefulWidget {
  @override
  _FlipClockState createState() => _FlipClockState();
}

class _FlipClockState extends State<FlipClock> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flip Clock')),
      body: Center(
        child: FlipClockPainter(
          time: _formatTime(_currentTime),
        ),
      ),
    );
  }
}

class FlipClockPainter extends StatelessWidget {
  final String time;

  FlipClockPainter({required this.time});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(400, 200), // Width and height of the clock
      painter: _FlipClockPainter(time),
    );
  }
}

class _FlipClockPainter extends CustomPainter {
  final String time;
  _FlipClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Paint textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final double margin = 10.0;
    final double letterWidth = 50.0;
    final double letterHeight = 100.0;
    final double spacing = 15.0;

    // Draw background
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), backgroundPaint);

    // Draw each digit in the time string
    for (int i = 0; i < time.length; i++) {
      if (time[i] == ':') continue; // Skip the colon
      double x = i * (letterWidth + spacing) + margin;
      double y = margin;

      _drawFlipDigit(canvas, textPaint, x, y, time[i]);
    }
  }

  void _drawFlipDigit(Canvas canvas, Paint paint, double x, double y, String digit) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: digit,
        style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));

    // Simulate the flipping animation (you can customize this further)
    canvas.save();
    canvas.translate(x + 25, y + 50); // Centering the text
    canvas.rotate(0); // Rotate by 180 degrees for flip effect (Can animate this)
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}