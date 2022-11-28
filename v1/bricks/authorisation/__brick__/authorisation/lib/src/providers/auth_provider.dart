import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthStatus {
  const AuthStatus({this.recordAuth, this.clientException});

  final RecordAuth? recordAuth;
  final ClientException? clientException;

  AuthStatus copyWith({RecordAuth? recordAuth, ClientException? clientException}) {
    return AuthStatus(
      recordAuth: recordAuth ?? this.recordAuth,
      clientException: clientException ?? this.clientException,
    );
  }
}

class AuthService extends StateNotifier<AuthStatus> {
  AuthService() : super(const AuthStatus());

  /// Using trivial to set up Pocketbase hosted on Fly.io as backend for the example
  final pb = PocketBase("https://brickmanbe.fly.dev");

  Future<void> signIn({required String user, required String password}) async {
    try {
      final response = await pb.collection('users').authWithPassword(user, password);
      state = state.copyWith(recordAuth: response);
    } on ClientException catch (e) {
      state = state.copyWith(clientException: e);
    }
  }

  Future<void> signUp({required String user, required String password}) async {
    try {
      pb;

      await pb.collection('users').create(body: {
        "username": user,
        "password": password,
        "passwordConfirm": password,
      });
      await signIn(user: user, password: password);
    } on ClientException catch (e) {
      log(e.toString());
      state = state.copyWith(clientException: e);
    }
  }
}

final authProvider = StateNotifierProvider<AuthService, AuthStatus>((ref) {
  return AuthService();
});
