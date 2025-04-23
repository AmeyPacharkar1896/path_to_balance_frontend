import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  static Future<void> init() async {
    // Adjust the fileName path based on your working directory.
    // For example, if your .env is in the project root but the working directory is different, use:
    await dotenv.load(fileName: ".env");
  }

  static String get baseUrl => dotenv.get('BASE_URL');
}
