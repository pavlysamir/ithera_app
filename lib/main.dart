import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/helpers/simple_bloc_observer.dart';
import 'package:ithera_app/firebase_options.dart';
import 'package:ithera_app/iThera_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  setUpServiceLocator();
  Bloc.observer = SimpleBlocObserver();

  runApp(ItheraApp());
}
