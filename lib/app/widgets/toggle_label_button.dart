import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleLabelButton extends StatelessWidget {
  final bool showAnswer;
  final VoidCallback onPressed;

  const ToggleLabelButton({
    super.key,
    required this.showAnswer,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        showAnswer ? 'Answer' : 'Question',
        style: GoogleFonts.openSans(),
      ),
    );
  }
}
