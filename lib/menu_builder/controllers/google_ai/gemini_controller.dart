import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
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

  String _cleanOutput(String? raw) {
    if (raw == null) return '';
    var text = raw.trim();

    // Remove markdown bold/italic, headings and blockquote markers
    text = text
        .replaceAll(RegExp(r'\*\*|__'), '')
        .replaceAll(RegExp(r'(?<!\w)\*|\*(?!\w)'), '')
        .replaceAll(RegExp(r'^\s{0,3}#{1,6}\s*', multiLine: true), '')
        .replaceAll(RegExp(r'^\s*>\s?', multiLine: true), '');

    // Remove wrapping quotes
    text = text.replaceAll(RegExp(r'^["“]|["”]$'), '');

    // Collapse extra blank lines
    text = text.replaceAll(RegExp(r'\n{2,}'), '\n').trim();
    return text;
  }

  // Generate dish description
  Future<String?> generateDishDescription(String dishName) async {
    try {
      _dishDescriptionGenerating = true;
      notifyListeners();
      final gemini = Gemini.instance;
      final result = await gemini.text(
        'Write ONE menu description for the dish "$dishName". '
        'Maximum 15 words, one sentence. '
        'Plain text only: no markdown, no title, no options, no quotes. '
        'Output only the description.',
        modelName: 'models/gemini-3.8-flash',
      );
      return _cleanOutput(result?.output);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        showToastMessage(
          "Too many requests. Please try again later.",
        );
      } else {
        showToastMessage(
          "Unable to generate description.",
        );
      }

      return null;
    } catch (e) {
      showToastMessage(
        "Unable to generate description.",
      );

      return null;
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
      final result = await gemini.text(
        "Correct the Writing and Grammar of $content",
        modelName: 'models/gemini-3.8-flash',
      );
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
        modelName: 'models/gemini-3.8-flash',
      );
      return result?.output;
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        showToastMessage(
          "Too many requests. Please try again later.",
        );
      } else {
        showToastMessage(
          "Unable to generate ingredients.",
        );
      }

      return null;
    } catch (e) {
      showToastMessage(
        "Unable to generate ingredients.",
      );

      return null;
    } finally {
      _dishIngredientsGenerating = false;
      notifyListeners();
    }
  }
}
