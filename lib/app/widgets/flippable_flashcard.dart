import 'package:flutter/material.dart';

class FlippableFlashcard extends StatefulWidget {
  final String frontText;
  final String backText;
  final bool showBack;

  const FlippableFlashcard({
    super.key,
    required this.frontText,
    required this.backText,
    required this.showBack,
  });

  @override
  State<FlippableFlashcard> createState() => _FlippableFlashcardState();
}

class _FlippableFlashcardState extends State<FlippableFlashcard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant FlippableFlashcard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showBack != oldWidget.showBack) {
      widget.showBack ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final isBackVisible = _animation.value >= 0.5;
        final rotationY = _animation.value * 3.14;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(rotationY),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Colors.indigo[50],
            child: Container(
              height: 250,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(32),
              child: Text(
                isBackVisible ? widget.backText : widget.frontText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
