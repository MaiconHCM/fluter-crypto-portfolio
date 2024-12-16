import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/providers/crypto_provider.dart';

void main() {
  test('Deve atualizar o preço da criptomoeda', () async {
    final provider = CryptoProvider();
    await provider.updatePrice('bitcoin');
    expect(provider.price, isNot('0'));
  });
}
