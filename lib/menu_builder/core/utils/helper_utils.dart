import 'package:flutter/material.dart';
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

String convertToAMPM(String time24) {
  List<String> parts = time24.split(":");
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  String period = hour >= 12 ? "PM" : "AM";
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Adjust for 12-hour format

  return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
  final minute = timeOfDay.minute.toString().padLeft(2, '0');
  final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:$minute $period';
}
