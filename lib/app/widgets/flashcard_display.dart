import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/ models/flashcard.dart';



class FlashcardDisplay extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onTap;

  const FlashcardDisplay({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Card(
          key: ValueKey<bool>(showAnswer),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: showAnswer ? Colors.amber.shade100 : Colors.indigo.shade100,
          child: Container(
            height: 280,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showAnswer ? 'Answer' : 'Question',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  showAnswer ? flashcard.answer : flashcard.question,
                  style: GoogleFonts.robotoSlab(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
