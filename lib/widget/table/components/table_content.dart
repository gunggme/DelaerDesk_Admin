import 'package:flutter/material.dart';
import 'table_status.dart';

class TableContent extends StatelessWidget {
  final String title;
  final int playerCount;
  final int maxPlayerCount;
  final bool isConnected;
  final Size size;

  const TableContent({
    super.key,
    required this.title,
    required this.playerCount,
    required this.maxPlayerCount,
    required this.isConnected,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        TableStatus(
          playerCount: playerCount,
          maxPlayerCount: maxPlayerCount,
          isConnected: isConnected,
          width: size.width,
        ),
      ],
    );
  }
}
