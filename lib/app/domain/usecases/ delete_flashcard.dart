import '../repositories/flashcard_repository.dart';

class DeleteFlashcard {
  final FlashcardRepository repository;

  DeleteFlashcard(this.repository);

  Future<void> call(String id) {
    return repository.deleteFlashcard(id);
  }
}
