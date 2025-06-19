
import '../repositories/flashcard_repository.dart';

class AddFlashcard {
  final FlashcardRepository repository;

  AddFlashcard(this.repository);

  Future<void> call(String question, String answer) {
    return repository.addFlashcard(question, answer);
  }
}
