import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../domain/ models/flashcard.dart';
import '../../widgets/flashcard_display.dart';
import '../../widgets/input_field.dart';
import '../providers/flashcard_notifier.dart';


class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FlashcardNotifier>(context, listen: false).loadFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<FlashcardNotifier>();
    final flashcard = notifier.currentFlashcard;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flashcard Quiz',
          style: GoogleFonts.robotoSlab(),
        ),
      ),
      body: Center(
        child: flashcard == null
            ? Text(
          'No flashcards yet',
          style: GoogleFonts.robotoSlab(fontSize: 18),
        )
            : Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlashcardDisplay(
                  flashcard: flashcard,
                  showAnswer: notifier.showAnswer,
                  onTap: notifier.toggleAnswer,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: notifier.toggleAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    notifier.showAnswer ? 'Answer' : 'Question',
                    style: GoogleFonts.openSans(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: flashcard == null
          ? null
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: notifier.previousCard,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditDialog(context, flashcard),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => _confirmDelete(context, flashcard),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: notifier.nextCard,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Add Flashcard',
          style: GoogleFonts.robotoSlab(),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputFieldBuilder(controller: questionController, label: 'Question'),
              const SizedBox(height: 12),
              InputFieldBuilder(controller: answerController, label: 'Answer'),
            ],
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              final q = questionController.text.trim();
              final a = answerController.text.trim();
              if (q.isNotEmpty && a.isNotEmpty) {
                context.read<FlashcardNotifier>().add(q, a).then((_) {
                  Navigator.pop(context);
                });
              }
            },
            icon: const Icon(Icons.add),
            label: Text(
              'Add',
              style: GoogleFonts.openSans(),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Flashcard flashcard) {
    final q = TextEditingController(text: flashcard.question);
    final a = TextEditingController(text: flashcard.answer);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Edit Flashcard',
          style: GoogleFonts.robotoSlab(),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputFieldBuilder(controller: q, label: 'Question'),
              const SizedBox(height: 12),
              InputFieldBuilder(controller: a, label: 'Answer'),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (q.text.trim().isNotEmpty && a.text.trim().isNotEmpty) {
                final updated = Flashcard(
                  id: flashcard.id,
                  question: q.text.trim(),
                  answer: a.text.trim(),
                );
                context.read<FlashcardNotifier>().update(updated).then((_) => Navigator.pop(context));
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.openSans(),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Flashcard flashcard) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Delete Flashcard',
          style: GoogleFonts.robotoSlab(),
        ),
        content: Text(
          'Are you sure you want to delete this flashcard?',
          style: GoogleFonts.openSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.openSans(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<FlashcardNotifier>().delete(flashcard.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.openSans(),
            ),
          ),
        ],
      ),
    );
  }
}
