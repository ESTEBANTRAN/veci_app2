import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bloc/controllers/auth_controller.dart';
import 'presentation/routes/auth_gate.dart';
import 'presentation/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart'; // <-- Agrega esta línea

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Bloquear orientación solo vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VeciApp',
      getPages: Routes.pages,
      home: const AuthGate(), // Aquí usamos el AuthGate
    );
  }
}
