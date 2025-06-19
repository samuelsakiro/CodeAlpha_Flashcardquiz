import 'package:flashcard/app/domain/%20models/flashcard.dart';

import '../repositories/flashcard_repository.dart';

class UpdateFlashcard {
  final FlashcardRepository repository;

  UpdateFlashcard(this.repository);

  Future<void> call(Flashcard flashcard) {
    return repository.updateFlashcard(flashcard);
  }
}
