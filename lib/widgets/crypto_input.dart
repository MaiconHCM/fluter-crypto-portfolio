import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';

class CryptoInput extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  final List<String> cryptoSuggestions = [
    'Bitcoin',
    'Ethereum',
    'Cardano',
    'XRP',
    'Polkadot',
    'Solana',
    'Dogecoin',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return cryptoSuggestions.where((crypto) => crypto.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              ));
            },
            onSelected: (String selection) {
              _controller.text = selection; // Atualiza o texto do campo
            },
            fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: 'Digite a moeda',
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final provider = Provider.of<CryptoProvider>(context, listen: false);
              provider.updatePrice(_controller.text); // Chama o update com o texto selecionado
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }
}
