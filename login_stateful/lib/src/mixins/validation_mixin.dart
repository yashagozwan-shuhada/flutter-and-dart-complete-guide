mixin ValidationMixin {
  String? validationEmail(String? value) {
    if (value != null && value.isEmpty) {
      return 'Email cannot be empty';
    }

    if (!value!.contains('@')) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? validationPassword(String? value) {
    if (value != null && value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value!.length < 4) {
      return 'password must be at lease 4 character';
    }

    return null;
  }
}
