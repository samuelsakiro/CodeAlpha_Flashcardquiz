import 'package:flashcard/app/domain/%20models/flashcard.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/flashcard_repository.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final _box = Hive.box('flashcards');

  @override
  Future<List<Flashcard>> getAllFlashcards() async {
    return _box.values
        .map((e) => Flashcard.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> addFlashcard(String question, String answer) async {
    final id = const Uuid().v4();
    final flashcard = Flashcard(id: id, question: question, answer: answer);
    await _box.put(id, flashcard.toMap());
  }

  @override
  Future<void> updateFlashcard(Flashcard flashcard) async {
    await _box.put(flashcard.id, flashcard.toMap());
  }

  @override
  Future<void> deleteFlashcard(String id) async {
    await _box.delete(id);
  }
}
