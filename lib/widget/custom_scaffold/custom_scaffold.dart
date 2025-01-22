import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? child;
  final Widget? appBarTitle;
  final List<Widget>? appBarActions;
  final List<NavigationItem>? menuItems = [
    NavigationItem(
      title: "매장 관리",
      icon: const Icon(Icons.store),
      onTap: () {
        Get.offAllNamed('/store_manage');
      },
      route: '/store_manage',
    ),
    NavigationItem(
      title: "연결 관리",
      icon: const Icon(Icons.link),
      onTap: () {},
    ),
    NavigationItem(
      title: "프리셋 관리",
      icon: const Icon(Icons.settings),
      onTap: () {
        Get.offAllNamed('/preset_manage');
      },
      route: '/preset_manage',
    ),
    NavigationItem(
      title: "회원 내역",
      icon: const Icon(Icons.people),
      onTap: () {},
    ),
    NavigationItem(
      title: "게임 내역",
      icon: const Icon(Icons.games),
      onTap: () {},
    ),
    NavigationItem(
      title: "정산 내역",
      icon: const Icon(Icons.calculate),
      onTap: () {},
    ),
  ];

  final Color highLightColor = const Color(0xFF18AC8D);

  CustomScaffold({
    super.key,
    this.child,
    this.appBarTitle,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildSideMenu(context),
          Expanded(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: _buildBody(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideMenu(BuildContext context) {
    return Material(
      child: Container(
        width: 250,
        color: const Color(0xFF1B1C1E),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 46),
              child: const Text(
                "Hollet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...menuItems?.map((item) => _buildMenuItem(context, item)) ?? [],
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, NavigationItem item) {
    return Container(
      decoration: BoxDecoration(
        color: item.route == Get.currentRoute
            ? highLightColor
            : Colors.transparent,
      ),
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Text(
            item.title,
            style: TextStyle(
              color: item.route == Get.currentRoute
                  ? Colors.white
                  : const Color(0xFFD1D1D1),
              fontSize: 15,
              decoration: TextDecoration.none,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: item.onTap,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (appBarTitle != null) appBarTitle!,
          const Spacer(),
          if (appBarActions != null) ...appBarActions!,
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2),
      child: child ?? const SizedBox(),
    );
  }
}

class NavigationItem {
  final String title;
  final Icon icon;
  final VoidCallback? onTap;
  final String? route;
  NavigationItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.route,
  });
}
