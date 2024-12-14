// stock_list_tile.dart
import 'package:flutter/material.dart';

class StockListTile extends StatelessWidget {
  final String name;
  final double price;
  final VoidCallback onTap;

  const StockListTile({
    Key? key,
    required this.name,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        '\$${price.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(Icons.arrow_forward, color: Colors.blueAccent),
    );
  }
}
