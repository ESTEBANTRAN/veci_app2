import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bloc/controllers/auth_controller.dart';
import '../../ui/views/home_view.dart';
import 'views/welcome.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      switch (authController.authStatus.value) {
        case AuthStatus.authenticated:
          return HomeView();
        case AuthStatus.unauthenticated:
          return const WelcomeView();
        default:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
      }
    });
  }
}
