mixin FormValidationMixin {
  String? emptyValidation(dynamic value) {
    if (value == null || value
        .toString()
        .trim()
        .isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
