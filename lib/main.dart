import 'package:flutter/material.dart';
import 'package:veci_app/config/theme/app_theme.dart';
//getx
import 'package:get/get.dart';
import './presentation/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application...
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Veci App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: colorList[0]),
      initialRoute: Routes.initial,
      getPages: Routes.pages,
    );
  }
}
