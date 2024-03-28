extension StringExtension on String {
  String get capitalize {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    } else {
      return '';
    }
  }

  String get capitalizeAll {
    return replaceAll(RegExp(' +'), ' ').split(' ').map((String value) => value.capitalize).join(' ');
  }
}
