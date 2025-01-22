import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginIdInputController = TextEditingController();
  final loginPasswordInputController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> login() async {
    final loginId = loginIdInputController.text;
    final loginPassword = loginPasswordInputController.text;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    print('loginId: $loginId, loginPassword: $loginPassword');
    Get.offAllNamed('/store_manage');
  }
}
