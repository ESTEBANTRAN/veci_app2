import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Fondo con gradiente para un toque más moderno
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FA), // Un azul claro muy sutil
              Color(0xFFBBDEFB), // Un azul un poco más vibrante
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Estira los elementos horizontalmente
              children: [
                // 2. Placeholder para una imagen o ilustración
                // Si tienes una imagen en assets/images/welcome.png, úsala así:
                // Image.asset(
                //   'assets/images/welcome_community.png', // Asegúrate de tener esta imagen en tu proyecto
                //   height: 200,
                // ),
                // Si no tienes una imagen, un icono mejorado o un logo más distintivo:
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    // Actualizado: usando withAlpha en lugar de withOpacity
                    color: Colors.white.withAlpha(204), // 0.8 * 255 ≈ 204
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // Actualizado: usando withAlpha en lugar de withOpacity
                        color: Colors.black.withAlpha(26), // 0.1 * 255 ≈ 26
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons
                        .handshake_outlined, // Un icono más representativo de "comunidad"
                    size: 100,
                    color: Colors
                        .blueAccent, // Color de icono un poco más vibrante
                  ),
                ),

                const SizedBox(height: 40),

                // 3. Título principal mejorado
                Text(
                  '¡Bienvenido a VeciApp!',
                  style: TextStyle(
                    fontSize: 38, // Un poco más grande
                    fontWeight: FontWeight.w900, // Más audaz
                    color:
                        Colors.blue.shade800, // Un azul más oscuro y profundo
                    letterSpacing: 1.2, // Espaciado entre letras
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // 4. Subtítulo o descripción con estilo mejorado
                const Text(
                  'Conecta con tus vecinos, comparte recursos y construye una comunidad más fuerte.',
                  style: TextStyle(
                    fontSize: 17, // Ligeramente más grande
                    color: Colors
                        .black54, // Un gris más oscuro para mejor legibilidad
                    height: 1.5, // Espaciado de línea para mejor lectura
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60), // Más espacio antes de los botones
                // 5. Botón de inicio de sesión (Primary Button)
                ElevatedButton(
                  onPressed: () => Get.toNamed("/login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Un azul más vivo
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ), // Aumenta el padding vertical
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ), // Bordes más redondeados
                    ),
                    elevation: 5, // Sombra para un efecto 3D sutil
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 19, // Un poco más grande
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 6. Botón de registro (Secondary Button)
                OutlinedButton(
                  onPressed: () => Get.toNamed(
                    "/crear-cuenta",
                  ), // Navegación a la pantalla de creación de cuenta
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.blue.shade400,
                      width: 2,
                    ), // Borde más visible
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ), // Bordes más redondeados
                    ),
                    foregroundColor:
                        Colors.blue.shade700, // Texto de color azul más oscuro
                  ),
                  child: const Text(
                    'Crear Cuenta',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
