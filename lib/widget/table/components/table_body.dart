import 'package:flutter/material.dart';
import '../../../app/constants/app_colors.dart';

class TableBody extends StatelessWidget {
  final Size size;
  final bool isSelected;
  final Widget child;

  const TableBody({
    super.key,
    required this.size,
    required this.isSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color:
                isSelected ? AppColors.primary : Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
