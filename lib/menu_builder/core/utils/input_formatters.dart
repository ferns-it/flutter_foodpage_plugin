import 'package:flutter/services.dart';

class NoEmojiTextInputFormatter extends TextInputFormatter {
  const NoEmojiTextInputFormatter();

  static bool containsEmoji(String text) => text.runes.any(_isEmojiRune);

  static String stripEmojis(String text) {
    if (!containsEmoji(text)) {
      return text;
    }

    final StringBuffer sanitizedText = StringBuffer();
    for (final int rune in text.runes) {
      if (!_isEmojiRune(rune)) {
        sanitizedText.writeCharCode(rune);
      }
    }
    return sanitizedText.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;
    if (!containsEmoji(text)) {
      return newValue;
    }

    final String sanitizedText = stripEmojis(text);
    return TextEditingValue(
      text: sanitizedText,
      selection: TextSelection.collapsed(
        offset:
            _mapOffset(text, sanitizedText, newValue.selection.extentOffset),
      ),
    );
  }

  static int _mapOffset(String text, String sanitizedText, int offset) {
    if (offset < 0) {
      return sanitizedText.length;
    }
    if (offset == 0) {
      return 0;
    }
    if (offset >= text.length) {
      return sanitizedText.length;
    }
    return stripEmojis(text.substring(0, offset)).length;
  }

  static bool _isEmojiRune(int rune) {
    return (rune >= 0x1F000 && rune <= 0x1FAFF) ||
        (rune >= 0x2600 && rune <= 0x27BF) ||
        (rune >= 0x2190 && rune <= 0x21FF) ||
        (rune >= 0x2300 && rune <= 0x23FF) ||
        (rune >= 0x25A0 && rune <= 0x25FF) ||
        (rune >= 0x2900 && rune <= 0x297F) ||
        (rune >= 0x2B00 && rune <= 0x2BFF) ||
        (rune == 0x203C || rune == 0x2049) ||
        (rune == 0x2139) ||
        (rune == 0x24C2) ||
        (rune == 0x3030 || rune == 0x303D) ||
        (rune == 0x3297 || rune == 0x3299) ||
        (rune == 0x200D) ||
        (rune == 0x20E3) ||
        (rune >= 0xFE00 && rune <= 0xFE0F) ||
        (rune >= 0xE0020 && rune <= 0xE007F);
  }
}
