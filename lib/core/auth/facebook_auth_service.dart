import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

enum FacebookLoginStatus {
  success,
  cancelled,
  failed,
  operationInProgress,
}

class FacebookLoginResult {
  final FacebookLoginStatus status;
  final String? accessToken;
  final String? message;

  const FacebookLoginResult({
    required this.status,
    this.accessToken,
    this.message,
  });
}

abstract class FacebookAuthService {
  Future<FacebookLoginResult> login();

  Future<void> logOut();
}

class FlutterFacebookAuthService implements FacebookAuthService {
  final FacebookAuth facebookAuth;

  FlutterFacebookAuthService({FacebookAuth? facebookAuth})
      : facebookAuth = facebookAuth ?? FacebookAuth.instance;

  @override
  Future<FacebookLoginResult> login() async {
    try {
      final result = await facebookAuth.login(
        permissions: const ['email', 'public_profile'],
        loginBehavior: LoginBehavior.nativeWithFallback,
      );

      return FacebookLoginResult(
        status: switch (result.status) {
          LoginStatus.success => FacebookLoginStatus.success,
          LoginStatus.cancelled => FacebookLoginStatus.cancelled,
          LoginStatus.operationInProgress =>
            FacebookLoginStatus.operationInProgress,
          LoginStatus.failed => FacebookLoginStatus.failed,
        },
        accessToken: result.accessToken?.tokenString,
        message: result.message,
      );
    } on MissingPluginException {
      return const FacebookLoginResult(
        status: FacebookLoginStatus.failed,
        message: 'Facebook login ainda nao esta configurado para este app.',
      );
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await facebookAuth.logOut();
    } on MissingPluginException {
      // Ignora quando o canal nativo ainda nao esta disponivel.
    }
  }
}
