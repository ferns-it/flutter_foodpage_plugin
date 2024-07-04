class MenuBuilderValidators {
  // Validator for dish name
  static String? validateDishName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Dish name is required';
    }
    if (value.length < 3) {
      return 'Dish name must be at least 3 characters long';
    }
    return null;
  }

 
  // Validator for category name
  static String? validateCategoryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category name is required';
    }
    if (value.length < 3) {
      return 'Category name must be at least 3 characters long';
    }
    return null;
  }

  static String? validateInteger(String? value) {
    if (value != null && value.isNotEmpty) {
      final int? number = int.tryParse(value);
      if (number == null) {
        return 'Please enter a valid integer';
      }
    }
    return null;
  }

  // Validator for price
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Price must be a valid number';
    }
    if (price <= 0) {
      return 'Price must be greater than zero';
    }
    return null;
  }

  static String? validateModifierGroupName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Group name is required';
    }
    if (value.length < 3) {
      return 'Group name must be at least 3 characters long';
    }
    return null;
  }

  static String? validateModifierOptionName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Option name is required';
    }
    if (value.length < 3) {
      return 'Option name must be at least 3 characters long';
    }
    return null;
  }

  static String? validateModifierPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Price must be a valid number';
    }
    return null;
  }
}
