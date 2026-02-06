import 'package:flutter/material.dart';
import 'package:pokeapp/core/app/app.dart';

import 'core/di/service_locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const PokeApp());
}
