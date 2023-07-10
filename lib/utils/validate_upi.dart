bool validateUpiId(String upiId) {
  // Regular expression pattern for UPI ID validation
  RegExp regex = RegExp(r'^[\w.-]+@[\w-]+(\.[\w-]+)*$');

  return regex.hasMatch(upiId);
}
