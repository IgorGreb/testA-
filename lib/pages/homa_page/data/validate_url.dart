class ValidateUrl {
  // Метод для перевірки валідності URL
  static bool isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }
}
