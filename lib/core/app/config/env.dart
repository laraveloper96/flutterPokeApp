final class Env {
  Env._privateConstructor({required this.baseUrl, required this.baseUrlImage});

  final String baseUrl;
  final String baseUrlImage;

  static Env? _instance;

  static Env get instance {
    if (_instance != null) return _instance!;
    _instance = Env._privateConstructor(
      baseUrl: const String.fromEnvironment('BASE_URL'),
      baseUrlImage: const String.fromEnvironment('BASE_URL_IMAGE'),
    );
    return _instance!;
  }
}
