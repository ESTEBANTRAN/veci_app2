import 'package:get/get.dart';
//views
import './views/welcome.dart';
import './views/loggin/loggin.dart';
import './views/home.dart';

class Routes {
  // Rutas estáticas
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';

  // Lista de páginas para GetX
  static final List<GetPage> pages = [
    GetPage(
      name: initial, 
      page: () => const WelcomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login, 
      page: () => const LoginView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: home, 
      page: () => const HomeView(),
      transition: Transition.rightToLeft,
    ),
  ];

  // Métodos de navegación helper
  static void goToHome() => Get.toNamed(home);
  static void goToLogin() => Get.toNamed(login);
  static void goBack() => Get.back();
}