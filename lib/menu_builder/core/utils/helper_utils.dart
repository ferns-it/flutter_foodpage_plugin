import 'package:html/parser.dart';
import 'package:intl/intl.dart';

String removeHtmlTags(String? value) {
  final data = parse(value);
  final result = parse(data.body?.text).documentElement?.text;
  return result ?? 'Not Available';
}

String convertFirstCharacterToUpperCase(String input) {
  if (input.isEmpty) {
    return input;
  }

  return input[0].toUpperCase() + input.substring(1);
}

List<int> generateNumberArray(int targetNumber) {
  List<int> numberArray = [];
  for (int i = 1; i <= targetNumber; i++) {
    numberArray.add(i);
  }
  return numberArray;
}

String formatDoubleWithThousandsSeparator(double value) {
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(value);
}
