import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  // Variables observables
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxString address = ''.obs;
  final RxString city = ''.obs;
  final RxString state = ''.obs;
  final RxString zip = ''.obs;
  final RxString country = ''.obs;

  // Cargar perfil del usuario autenticado
  Future<void> loadProfile() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data() ?? {};
          name.value = data['name'] ?? '';
          email.value = data['email'] ?? '';
          phone.value = data['phone'] ?? '';
          address.value = data['address'] ?? '';
          city.value = data['city'] ?? '';
          state.value = data['state'] ?? '';
          zip.value = data['zip'] ?? '';
          country.value = data['country'] ?? '';
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo cargar el perfil',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  // Actualizar perfil del usuario autenticado
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? zip,
    String? country,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final updateData = <String, dynamic>{};
        if (name != null) updateData['name'] = name;
        if (email != null) updateData['email'] = email;
        if (phone != null) updateData['phone'] = phone;
        if (address != null) updateData['address'] = address;
        if (city != null) updateData['city'] = city;
        if (state != null) updateData['state'] = state;
        if (zip != null) updateData['zip'] = zip;
        if (country != null) updateData['country'] = country;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(updateData);
        await loadProfile();
        Get.snackbar(
          'Éxito',
          'Perfil actualizado',
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo actualizar el perfil',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
