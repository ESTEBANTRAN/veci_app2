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
  final RxString houseNumber = ''.obs;
  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);

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
          houseNumber.value = data['houseNumber'] ?? '';
          
          // Manejar birthDate
          if (data['birthDate'] != null) {
            try {
              birthDate.value = DateTime.tryParse(data['birthDate']);
            } catch (e) {
              birthDate.value = null;
            }
          } else {
            birthDate.value = null;
          }
        } else {
          // Si el documento no existe, crear uno básico
          await _createInitialProfile(uid);
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo cargar el perfil: ${e.toString()}',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  // Crear perfil inicial si no existe
  Future<void> _createInitialProfile(String uid) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final initialData = {
          'id': uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'phone': '',
          'address': '',
          'city': '',
          'state': '',
          'zip': '',
          'country': '',
          'houseNumber': '',
          'birthDate': null,
          'role': null,
          'avatarUrl': user.photoURL,
          'citadel': null,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(initialData);

        // Cargar los datos iniciales
        name.value = initialData['name'] ?? '';
        email.value = initialData['email'] ?? '';
        phone.value = initialData['phone'] ?? '';
        address.value = initialData['address'] ?? '';
        city.value = initialData['city'] ?? '';
        state.value = initialData['state'] ?? '';
        zip.value = initialData['zip'] ?? '';
        country.value = initialData['country'] ?? '';
        houseNumber.value = initialData['houseNumber'] ?? '';
        birthDate.value = null;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo crear el perfil inicial: ${e.toString()}',
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
    String? houseNumber,
    DateTime? birthDate,
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
        if (houseNumber != null) updateData['houseNumber'] = houseNumber;
        if (birthDate != null) {
          updateData['birthDate'] = birthDate.toIso8601String();
        }

        // Usar set con merge para crear el documento si no existe
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(updateData, SetOptions(merge: true));
            
        await loadProfile();
        Get.snackbar(
          'Éxito',
          'Perfil actualizado correctamente',
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo actualizar el perfil: ${e.toString()}',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
