import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/app/bindings/app_binding.dart';
import 'package:hollet_admin/app/bindings/login_binding.dart';
import 'package:hollet_admin/app/bindings/preset_edit_manage_binding.dart';
import 'package:hollet_admin/app/bindings/preset_manage_binding.dart';
import 'package:hollet_admin/app/bindings/store_manage_binding.dart';
import 'package:hollet_admin/app/bindings/store_manage_edit_binding.dart';
import 'package:hollet_admin/views/login/login_view.dart';
import 'package:hollet_admin/views/preset_manage/preset_edit_manage_view.dart';
import 'package:hollet_admin/views/preset_manage/preset_manage_view.dart';
import 'package:hollet_admin/views/store_manage/store_manage_edit_view.dart';
import '../views/store_manage/store_manage_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  final Color highLightColor = const Color(0xFF18AC8D);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: highLightColor),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        initialBinding: AppBinding(),
        home: Container(
          child: TextButton(
            onPressed: () {
              Get.toNamed('/store_manage');
            },
            child: const Text("매장 관리"),
          ),
        ),
        getPages: [
          GetPage(
            name: '/store_manage',
            page: () => const StoreManageView(),
            binding: StoreManageBinding(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/preset_manage',
            page: () => const PresetManageView(),
            binding: PresetManageBinding(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/store_manage_edit',
            page: () => const StoreManageEditView(),
            binding: StoreManageEditBinding(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/preset_edit_manage',
            page: () => const PresetEditManageView(),
            binding: PresetEditManageBinding(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/login',
            page: () => const LoginView(),
            binding: LoginBinding(),
            transition: Transition.noTransition,
          ),
        ],
      ),
    );
  }
}
