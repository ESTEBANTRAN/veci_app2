import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../bloc/controllers/auth_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Por favor ingresa tu correo electrónico',
                  );
                  return;
                }
                try {
                  await authController.sendPasswordResetEmail(email);
                  Get.snackbar(
                    'Listo',
                    'Se ha enviado un correo para restablecer tu contraseña',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  Get.back();
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'No se pudo enviar el correo. Verifica el correo ingresado.',
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Enviar enlace'),
            ),
          ],
        ),
      ),
    );
  }
}
