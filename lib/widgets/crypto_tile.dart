import 'package:flutter/material.dart';

class CryptoTile extends StatelessWidget {
  final String name;
  final String price;

  const CryptoTile({required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Preço: \$ $price'),
      ),
    );
  }
}
