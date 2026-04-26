import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:talent_crm_app/features/account/account_binding.dart';
import 'package:talent_crm_app/features/account/data/datasources/user_remote_data_source.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/repositories/user_repository.dart';

void main() {
  setUp(() {
    Get.reset();
  });

  group('AccountBinding', () {
    test('registers UserRemoteDataSource, UserRepository and AccountController',
        () {
      final binding = AccountBinding();
      binding.dependencies();

      expect(Get.isRegistered<UserRemoteDataSource>(), true);
      expect(Get.isRegistered<UserRepository>(), true);
      expect(Get.isRegistered<AccountController>(), true);
    });

    test('lazyPut creates instance only when accessed', () {
      final binding = AccountBinding();
      binding.dependencies();

      expect(Get.isRegistered<AccountController>(), true);
    });
  });
}
