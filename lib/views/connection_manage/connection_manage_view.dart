import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollet_admin/controllers/inMenu/connection_manage_controller.dart';

class ConnectionManageView extends GetView<ConnectionManageController> {
  const ConnectionManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('ConnectionManageView')),
    );
  }
}
