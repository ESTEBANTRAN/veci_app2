import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/model/user_model.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String uid;
  final Rx<UserModel?> userModel = Rx<UserModel?>(null);
  final Rx<AuthStatus> authStatus = AuthStatus.initial.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAuth();
  }

  void _initializeAuth() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        uid = currentUser.uid;
        await loadUserData();
        authStatus.value = AuthStatus.authenticated;
      } else {
        authStatus.value = AuthStatus.unauthenticated;
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      authStatus.value = AuthStatus.unauthenticated;
    }
  }

  Future<void> loadUserData() async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        userModel.value = UserModel.fromMap(userDoc.data()!);
      }
    } catch (e) {
      debugPrint("Error loading user data: ${e.toString()}");
    }
  }

  // Registro de usuario
  Future<bool> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? avatarUrl,
    String? address,
    String? country,
    String? state,
    String? city,
    String? citadel,
    String? houseNumber,
    DateTime? birthDate,
    String? role,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      uid = userCredential.user!.uid;

      UserModel user = UserModel(
        id: uid,
        name: name,
        email: email,
        phone: phone,
        avatarUrl: avatarUrl,
        address: address,
        country: country,
        state: state,
        city: city,
        citadel: citadel,
        houseNumber: houseNumber,
        birthDate: birthDate,
        role: role,
      );

      await _firestore.collection('users').doc(uid).set(user.toMap());
      userModel.value = user;
      authStatus.value = AuthStatus.authenticated;
      return true;
    } catch (e) {
      debugPrint("Register error: ${e.toString()}");
      return false;
    }
  }

  // Login
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      uid = userCredential.user!.uid;
      await loadUserData();
      authStatus.value = AuthStatus.authenticated;
      return true;
    } catch (e) {
      debugPrint("Login error: ${e.toString()}");
      authStatus.value = AuthStatus.unauthenticated;
      return false;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    userModel.value = null;
    authStatus.value = AuthStatus.unauthenticated;
  }
}
