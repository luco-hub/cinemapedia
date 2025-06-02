

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String movieAppKey = dotenv.env['THE_MOVIEDB_API_KEY'] ?? 'none';
}