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
}
