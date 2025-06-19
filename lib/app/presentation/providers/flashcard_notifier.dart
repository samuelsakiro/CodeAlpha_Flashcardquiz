import 'package:flashcard/app/domain/%20models/flashcard.dart';
import 'package:flashcard/app/domain/usecases/%20delete_flashcard.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/add_flashcard.dart';
import '../../domain/usecases/get_flashcards.dart';
import '../../domain/usecases/update_flashcard.dart';

class FlashcardNotifier extends ChangeNotifier {
  final GetFlashcards getFlashcards;
  final AddFlashcard addFlashcard;
  final UpdateFlashcard updateFlashcard;
  final DeleteFlashcard deleteFlashcard;

  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  bool _showAnswer = false;

  FlashcardNotifier({
    required this.getFlashcards,
    required this.addFlashcard,
    required this.updateFlashcard,
    required this.deleteFlashcard,
  }) {
    loadFlashcards();
  }

  List<Flashcard> get flashcards => _flashcards;
  int get currentIndex => _currentIndex;
  bool get showAnswer => _showAnswer;

  Flashcard? get currentFlashcard {
    if (_flashcards.isEmpty || _currentIndex >= _flashcards.length) return null;
    return _flashcards[_currentIndex];
  }

  Future<void> loadFlashcards() async {
    _flashcards = await getFlashcards();
    _currentIndex = 0;
    _showAnswer = false;
    notifyListeners();
  }

  void toggleAnswer() {
    _showAnswer = !_showAnswer;
    notifyListeners();
  }

  void nextCard() {
    if (_flashcards.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _flashcards.length;
    _showAnswer = false;
    notifyListeners();
  }

  void previousCard() {
    if (_flashcards.isEmpty) return;
    _currentIndex =
        (_currentIndex - 1 + _flashcards.length) % _flashcards.length;
    _showAnswer = false;
    notifyListeners();
  }

  Future<void> add(String question, String answer) async {
    await addFlashcard(question, answer);
    await loadFlashcards();
  }

  Future<void> update(Flashcard flashcard) async {
    await updateFlashcard(flashcard);
    await loadFlashcards();
  }

  Future<void> delete(String id) async {
    await deleteFlashcard(id);
    await loadFlashcards();
  }
}
