import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:talent_crm_app/features/account/presentation/account_controller.dart';
import 'package:talent_crm_app/features/account/presentation/account_page.dart';

class AccountShell extends GetView<AccountController> {
  const AccountShell({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountPage();
  }
}
