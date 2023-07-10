bool validateCardNumber(String cardNumber) {
  RegExp regex = RegExp(r'^\d{12,19}$');
  return regex.hasMatch(cardNumber);
}
