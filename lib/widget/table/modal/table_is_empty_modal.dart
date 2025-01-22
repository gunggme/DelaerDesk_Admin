import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableIsEmptyModal extends StatelessWidget {
  const TableIsEmptyModal({super.key});

  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );

  final TextStyle descriptionTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 241,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("테이블이 비어있습니다.", style: titleTextStyle),
            Text("테이블을 생성해주세요.", style: descriptionTextStyle),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("확인"),
            ),
          ],
        ),
      ),
    );
  }
}
