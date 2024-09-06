import 'package:flutter/foundation.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiController extends ChangeNotifier with BaseController {
  bool _dishDescriptionGenerating = false;

  bool get dishDescriptionGenerating => _dishDescriptionGenerating;

  bool _dishIngredientsGenerating = false;

  bool get dishIngredientsGenerating => _dishIngredientsGenerating;

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

  // Generate dish ingredients
  Future<String?> generateDishIngredients(String dishName) async {
    try {
      _dishIngredientsGenerating = true;
      notifyListeners();
      final gemini = Gemini.instance;
      final result = await gemini.text(
        "Write down the ingredients for $dishName, separating the items with commas in the sentence. The sentence should contain only the ingredient details.",
      );
      return result?.output;
    } finally {
      _dishIngredientsGenerating = false;
      notifyListeners();
    }
  }
}
