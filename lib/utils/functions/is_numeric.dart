/// Is Numeric
///
/// Check if supplied string is numeric
///
bool isNumeric(String? s) {
  // If supplied string is null return false
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
