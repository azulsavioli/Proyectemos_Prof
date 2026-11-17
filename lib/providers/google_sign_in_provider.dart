import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInProvider() {
    _subscription = GoogleSignIn.instance.authenticationEvents.listen(
      _onEvent,
      onError: _onError,
    );
  }

  StreamSubscription<GoogleSignInAuthenticationEvent>? _subscription;
  bool busy = false;
  String? lastError;

  Future<void> _onEvent(GoogleSignInAuthenticationEvent event) async {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn(:final user):
        await _signInWithFirebase(user);
      case GoogleSignInAuthenticationEventSignOut():
        break;
    }
  }

  Future<void> _signInWithFirebase(GoogleSignInAccount account) async {
    final idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      lastError = 'O Google não devolveu um token de acesso.';
      notifyListeners();
      return;
    }

    busy = true;
    lastError = null;
    notifyListeners();
    try {
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      lastError = error.message ?? 'Não foi possível entrar com o Google.';
    } catch (error) {
      lastError = 'Não foi possível concluir o acesso.';
      if (kDebugMode) {
        debugPrint('Falha ao autenticar no Firebase: $error');
      }
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  void _onError(Object error) {
    final message = describeAuthError(error);
    if (message.isEmpty) {
      return;
    }
    lastError = message;
    busy = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    lastError = null;
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

String describeAuthError(Object error) {
  if (error is GoogleSignInException) {
    if (error.code == GoogleSignInExceptionCode.canceled ||
        error.code == GoogleSignInExceptionCode.interrupted) {
      return '';
    }
    final description = error.description;
    if (description != null && description.isNotEmpty) {
      return description;
    }
    return 'Não foi possível entrar com o Google.';
  }
  return 'Não foi possível entrar com o Google.';
}
