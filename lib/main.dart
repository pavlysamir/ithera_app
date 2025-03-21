import 'package:flutter/material.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/iThera_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(const ItheraApp());
}
