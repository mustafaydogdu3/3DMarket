import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/app/view/app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const AppView());
}
