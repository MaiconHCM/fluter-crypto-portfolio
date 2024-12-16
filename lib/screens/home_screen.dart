import 'package:flutter/material.dart';
import 'package:projeto/widgets/crypto_input.dart';
import 'package:projeto/widgets/crypto_tile.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Crypto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final provider = Provider.of<CryptoProvider>(context, listen: false);
              provider.updatePriceAll();
            },
            tooltip: 'Atualizar Todos',
          ),
        ],
      ),
      body: Column(
        children: [
          CryptoInput(),
          Expanded(
            child: Consumer<CryptoProvider>(
              builder: (context, provider, _) {
                return ListView.builder(
                  itemCount: provider.cryptos.length, // Tamanho da lista
                  itemBuilder: (context, index) {
                    final crypto = provider.cryptos[index]; // Item atual
                    return ListTile(
                      title: Text(crypto['name']!),
                      subtitle: Text('Price: \$${crypto['price']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.removeCrypto(crypto['name']!); // Remover item
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
