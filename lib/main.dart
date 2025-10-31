
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/sl_dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();

  runApp(MyApp());
}


