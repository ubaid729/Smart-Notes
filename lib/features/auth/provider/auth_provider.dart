
import 'package:create_smart_notes/features/auth/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthServices _authService = AuthServices();

  bool isLoading = false;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _authService.login(
        email: email,
        password: password,
      );
      return null; // Null means success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _authService.signup(
        email: email,
        password: password,
      );
      return null; 
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
 Future<String?> resetPassword({
  required String email,
}) async {
  try {
    isLoading = true;
    notifyListeners();

    await _authService.resetpassword(
      email: email,
    );

    return null;

  } on FirebaseAuthException catch (e) {
    return e.message;

  } catch (e) {
    return e.toString();

  } finally {
    isLoading = false;
    notifyListeners();
  }
}
}