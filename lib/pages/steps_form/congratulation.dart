import 'package:flutter/material.dart';
import 'package:forzado/pages/steps_form/step_form.dart';

class CongratulationAnimation extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<CongratulationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();

    // Inicializar AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        if (_controller.status == AnimationStatus.completed) {
          setState(() {
            _isComplete = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              final route = MaterialPageRoute(builder: (_) => StepperForm());
              Navigator.pushReplacement(context, route);
            });
          });
        }
      });

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.1416)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: Icon(
                _isComplete ? Icons.check_circle : Icons.sync,
                color: _isComplete ? Colors.green : Colors.blue,
                size: 80,
              ),
            );
          },
        ),
      ),
    );
  }
}
