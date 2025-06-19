import 'package:flashcard/app/domain/%20models/flashcard.dart';

import '../repositories/flashcard_repository.dart';

class GetFlashcards {
  final FlashcardRepository repository;

  GetFlashcards(this.repository);

  Future<List<Flashcard>> call() {
    return repository.getAllFlashcards();
  }
}
