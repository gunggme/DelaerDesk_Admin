import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/controllers/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  TextStyle get _titleTextStyle => const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _inputTitleTextStyle => const TextStyle(
        fontSize: 16,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hollet', style: _titleTextStyle),
            _buildInputField('아이디', controller.loginIdInputController),
            const SizedBox(height: 30),
            _buildInputField('비밀번호', controller.loginPasswordInputController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.login();
              },
              child: const Text('로그인'),
            ),
          ],
        ),
        // 로딩 중 표시
        Obx(
          () => Visibility(
            visible: controller.isLoading.value,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: _inputTitleTextStyle),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '$label를 입력해주세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
