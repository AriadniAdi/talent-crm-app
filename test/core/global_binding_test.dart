import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:talent_crm_app/core/global_binding.dart';
import 'package:talent_crm_app/features/auth/repositories/auth_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockDb;

  setUp(() {
    Get.reset();
    mockAuth = MockFirebaseAuth();
    mockDb = MockFirebaseFirestore();

    // Stub auth state for manager initialization
    when(() => mockAuth.currentUser).thenReturn(null);
    when(() => mockAuth.authStateChanges())
        .thenAnswer((_) => const Stream.empty());

    // Inject mocks that GlobalBinding would normally get from static instances
    Get.put<FirebaseAuth>(mockAuth);
    Get.put<FirebaseFirestore>(mockDb);
  });

  group('GlobalBinding', () {
    test('registers http.Client in Get', () {
      final binding = GlobalBinding();

      binding.dependencies();

      expect(Get.isRegistered<http.Client>(), true);
    });

    test('registered http.Client can be retrieved', () {
      final binding = GlobalBinding();

      binding.dependencies();

      final client = Get.find<http.Client>();

      expect(client, isA<http.Client>());
    });

    test('http.Client is permanent', () {
      final binding = GlobalBinding();

      binding.dependencies();

      expect(Get.isRegistered<http.Client>(), true);

      Get.delete<http.Client>();

      // permanent: true impede deleção
      expect(Get.isRegistered<http.Client>(), true);
    });

    test('registers auth repository lazily', () {
      final binding = GlobalBinding();

      binding.dependencies();

      expect(Get.isRegistered<AuthRepository>(), true);
    });
  });
}
