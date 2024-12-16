import 'package:flutter/material.dart';
import '../services/crypto_service.dart';
import 'package:projeto/storage/local_storage.dart';

class CryptoProvider with ChangeNotifier {
  String _price = '0';
  String _name = "";
  List<Map<String, String>> _cryptos = []; // Lista de criptomoedas

  final LocalStorage _localStorage = LocalStorage();

  CryptoProvider() {
    _loadCryptos(); // Carrega as criptomoedas salvas ao inicializar
  }

  String get price => _price;
  String get name => _name;
  List<Map<String, String>> get cryptos => _cryptos;

  // Carregar criptomoedas do localStorage
  Future<void> _loadCryptos() async {
    final savedCryptos = await _localStorage.getItem('cryptos') ?? [];
    _cryptos = List<Map<String, String>>.from(
      (savedCryptos as List).map(
            (crypto) => {
          'name': crypto['name'].toString(),
          'price': crypto['price'].toString(),
        },
      ),
    );
    updatePriceAll();
  }


  Future<void> updatePrice(String crypto) async {
    final service = CryptoService();
    crypto = crypto.toLowerCase();
    final data = await service.fetchCryptoPrice(crypto);

    if (data.containsKey(crypto)) {
      _price = data[crypto]['usd'].toString();
      _name = crypto;

      final existingIndex = _cryptos.indexWhere((item) => item['name'] == crypto);

      if (existingIndex != -1) {
        // Atualizar o preço da cripto existente
        _cryptos[existingIndex] = {'name': crypto, 'price': _price};
      } else {
        // Adicionar nova cripto à lista
        final newCrypto = {'name': crypto, 'price': _price};
        _cryptos.add(newCrypto);
      }

      // Salvar a lista atualizada no localStorage
      await _localStorage.setItem('cryptos', _cryptos);
      notifyListeners();
    }
  }

  Future<void> updatePriceAll() async {
    final service = CryptoService();
    final data = await service.fetchCryptoPrice(getAllCryptoNames());



    for (var crypto in _cryptos) {
      String cryptoName = crypto['name'] ?? '';
      if (data.containsKey(cryptoName)) {
        _price = data[cryptoName]['usd'].toString();
        _name = cryptoName;

        final existingIndex = _cryptos.indexWhere((item) => item['name'] == cryptoName);
        _cryptos[existingIndex] = {'name': cryptoName, 'price': _price};


        // Salvar a lista atualizada no localStorage
        await _localStorage.setItem('cryptos', _cryptos);
        notifyListeners();
      }

    }
  }

  Future<void> removeCrypto(String cryptoName) async {
    _cryptos.removeWhere((crypto) => crypto['name'] == cryptoName);
    await _localStorage.setItem('cryptos', _cryptos);
    notifyListeners();
  }
  String getAllCryptoNames() {
    return _cryptos.map((crypto) => crypto['name']!).join(',');
  }
}

