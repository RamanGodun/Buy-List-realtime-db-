class Constants {
  static const String _baseUrl =
      'study-project-36199-default-rtdb.europe-west1.firebasedatabase.app';

  static String get baseUrl => _baseUrl;
  static Uri get shoppingListUrl => Uri.https(_baseUrl, 'shopping-list.json');
}
