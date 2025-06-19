import 'package:flashcard/app/domain/%20models/flashcard.dart';

abstract class FlashcardRepository {
  Future<List<Flashcard>> getAllFlashcards();
  Future<void> addFlashcard(String question, String answer);
  Future<void> updateFlashcard(Flashcard flashcard);
  Future<void> deleteFlashcard(String id);
}
