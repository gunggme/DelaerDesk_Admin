import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const App());
}
