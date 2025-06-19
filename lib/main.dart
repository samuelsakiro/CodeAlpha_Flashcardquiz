import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app/data/repositories/flashcard_repository_impl.dart';
import 'app/domain/usecases/ delete_flashcard.dart';

import 'app/domain/usecases/add_flashcard.dart';
import 'app/domain/usecases/get_flashcards.dart';
import 'app/domain/usecases/update_flashcard.dart';
import 'app/presentation/providers/flashcard_notifier.dart';
import 'app/presentation/screens/flashcard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox('flashcards');
  // ✅ Initialize Hive without path_provider


  // ❌ No adapter needed since we’re using Map storage
  await Hive.openBox('flashcards');

  final repo = FlashcardRepositoryImpl();

  runApp(
    ChangeNotifierProvider(
      create: (_) => FlashcardNotifier(
        getFlashcards: GetFlashcards(repo),
        addFlashcard: AddFlashcard(repo),
        updateFlashcard: UpdateFlashcard(repo),
        deleteFlashcard: DeleteFlashcard(repo),
      ),
      child: const FlashcardApp(),
    ),
  );
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard Quiz',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const FlashcardScreen(),
    );
  }
}
