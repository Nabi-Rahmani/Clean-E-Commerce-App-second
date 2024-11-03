class FormValidators {
  static const int minUsernameLength = 3;
  static const int minPasswordLength = 6;

  static const double minPrice = 0.0;
  static const double maxPrice = 999999.99;
  // Generalized username validation
  static String? validateUsername(String? username,
      {String emptyMessage = 'Please enter a valid username'}) {
    if (username == null || username.trim().isEmpty) {
      return emptyMessage;
    }
    if (username.trim().length < minUsernameLength) {
      return 'Username must be at least $minUsernameLength characters';
    }
    if (username.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    // if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(username)) {
    //   return 'Username can only contain letters, numbers, dots and underscores';
    // }
    return null;
  }

  // Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Please enter an email address';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Please enter a password';
    }
    if (password.trim().length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? validatePrice(String? price) {
    if (price == null || price.trim().isEmpty) {
      return 'Please enter a price';
    }

    // Try to parse the price
    final double? numericPrice = double.tryParse(price.trim());
    if (numericPrice == null) {
      return 'Please enter a valid number';
    }

    // Check minimum price
    if (numericPrice < minPrice) {
      return 'Price cannot be negative';
    }

    // Check maximum price
    if (numericPrice > maxPrice) {
      return 'Price cannot exceed ${maxPrice.toStringAsFixed(2)}';
    }

    // Check decimal places (optional)
    if (price.contains('.')) {
      final decimals = price.split('.')[1];
      if (decimals.length > 2) {
        return 'Price cannot have more than 2 decimal places';
      }
    }

    return null;
  }

  static String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    // Additional validation can be added here (e.g., length checks)
    return null; // Return null if validation passes
  }
}
