import 'package:get/get.dart';

class ProfileController extends GetxController {
//variables
  final String name = ''.obs;
  final String email = ''.obs;
  final String phone = ''.obs;
  final String address = ''.obs;
  final String city = ''.obs;
  final String state = ''.obs;
  final String zip = ''.obs;
  final String country = ''.obs;
//metodos
Future<void> getProfileUid(String uid) async{
  try{
    //1 obtener el uid usuario 
    final uid=FirebaseAuth.instance.currentUser?.uid;
    if(uid!=null){
      //2 obtener el perfil del usuario
      final userdb=FirebaseFirestore.instance.collection('users').doc(uid);
      final user=await userdb.doc(uid).get();
      if(user.exists){
        final userdata=user.data();
        name.value=userdata['name'];
        email.value=userdata['email'];
        phone.value=userdata['phone'];
        address.value=userdata['address'];
      }
  }
} else{
  debugPrint('No se pudo obtener el usuario autenticado');
}
