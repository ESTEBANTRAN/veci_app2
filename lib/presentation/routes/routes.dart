import 'package:get/get.dart';
import 'package:veci_app/ui/views/home_view.dart';
//views
import './views/welcome.dart';
import './views/loggin/loggin.dart';
import 'views/create_account.dart';

class Routes {
  // Rutas estáticas
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String crearCuenta = '/crear-cuenta';

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
      transition: Transition.fadeIn,
    ),
    GetPage(name: home, page: () => HomeView(), transition: Transition.fadeIn),
    GetPage(
      name: crearCuenta,
      page: () => CrearCuentaView(),
      transition: Transition.rightToLeft,
    ),
  ];

  // Métodos de navegación helper
  static void goToHome() => Get.toNamed(home);
  static void goToLogin() => Get.toNamed(login);
  static void goToCrearCuenta() => Get.toNamed(crearCuenta);
  static void goBack() => Get.back();
}
