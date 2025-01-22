import 'package:flutter/material.dart';
import '../constants/table_size_constants.dart';
import '../../../app/constants/app_colors.dart';

class ResizeHandlerWidget extends StatelessWidget {
  const ResizeHandlerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: TableSizeConstants.HANDLER_SIZE * 2,
      height: TableSizeConstants.HANDLER_SIZE * 2,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Container(
        width: TableSizeConstants.HANDLER_SIZE,
        height: TableSizeConstants.HANDLER_SIZE,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
