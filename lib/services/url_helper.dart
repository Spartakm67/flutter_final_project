class UrlHelper {
  static const String _baseUrl = 'https://joinposter.com';

  static String getFullImageUrl(String path) {
    return Uri.parse(_baseUrl).resolve(path.replaceAll('\\', '')).toString();
  }

  static String get baseUrl => _baseUrl;

  static String appendPath(String path) {
    return Uri.parse(_baseUrl).resolve(path).toString();
  }
}
