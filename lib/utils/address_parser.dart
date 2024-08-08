class AddressParser {
  static Map<String, String?> parseFormattedAddress(String formattedAddress) {
    final addressRegex =
        RegExp(r'^(.+),\s+(.+),\s+([A-Z]{2})\s+(\d{5}),\s+USA$');
    final match = addressRegex.firstMatch(formattedAddress);

    if (match != null) {
      return {
        'address': match.group(1),
        'city': match.group(2),
        'state': match.group(3),
        'zipCode': match.group(4),
      };
    } else {
      return {
        'address': null,
        'city': null,
        'state': null,
        'zipCode': null,
      };
    }
  }
}
