import 'package:flutter/foundation.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiController extends ChangeNotifier with BaseController {
  bool _dishDescriptionGenerating = false;

  bool get dishDescriptionGenerating => _dishDescriptionGenerating;

  // Initialize gemini
  void initializeGemini(String apiKey) {
    Gemini.init(apiKey: apiKey);
  }

  // Generate dish description
  Future<String?> generateDishDescription(String dishName) async {
    try {
      _dishDescriptionGenerating = true;
      notifyListeners();
      final gemini = Gemini.instance;
      final result =
          await gemini.text("Write a short description about $dishName");
      return result?.output;
    } finally {
      _dishDescriptionGenerating = false;
      notifyListeners();
    }
  }

  // Spelling and Grammar Correct the content with AI
  Future<String?> spellAndGrammarDishDescription(String content) async {
    try {
      _dishDescriptionGenerating = true;
      notifyListeners();
      final gemini = Gemini.instance;
      final result =
          await gemini.text("Correct the Writing and Grammar of $content");
      return result?.output;
    } finally {
      _dishDescriptionGenerating = false;
      notifyListeners();
    }
  }
}
