import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bloc/controllers/auth_controller.dart';
import '../../presentation/routes/routes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VeciApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navegar a notificaciones o alarmas
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navegar a perfil de usuario
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Obx(() {
              final user = authController.userModel.value;
              return UserAccountsDrawerHeader(
                accountName: Text(user?.name ?? "Usuario"),
                accountEmail: Text(user?.email ?? "usuario@example.com"),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              );
            }),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Routes.goToProfile();
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar Sesión'),
              onTap: () async {
                await authController.signOut();
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildMenuItem(
            icon: Icons.article,
            title: 'Noticias',
            color: Colors.orange,
            onTap: () {
              // Navegar a sección de noticias
            },
          ),
          _buildMenuItem(
            icon: Icons.message,
            title: 'Mensajes',
            color: Colors.blue,
            onTap: () {
              // Navegar a mensajes entre vecinos
            },
          ),
          _buildMenuItem(
            icon: Icons.notifications_active,
            title: 'Alarmas',
            color: Colors.red,
            onTap: () {
              // Navegar a alarmas o alertas vecinales
            },
          ),
          _buildMenuItem(
            icon: Icons.people,
            title: 'Comunidad',
            color: Colors.green,
            onTap: () {
              // Navegar a comunidad, vecinos cercanos, etc.
            },
          ),
          _buildMenuItem(
            icon: Icons.shopping_cart,
            title: 'Servicios',
            color: Colors.purple,
            onTap: () {
              // Navegar a servicios ofrecidos por vecinos o externos
            },
          ),
          _buildMenuItem(
            icon: Icons.event,
            title: 'Eventos',
            color: Colors.teal,
            onTap: () {
              // Navegar a eventos de la ciudadela o barrio
            },
          ),
          _buildMenuItem(
            icon: Icons.help,
            title: 'Ayuda',
            color: Colors.grey,
            onTap: () {
              // Navegar a sección de ayuda o soporte
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
