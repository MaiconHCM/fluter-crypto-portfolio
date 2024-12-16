import 'package:dio/dio.dart';

class CryptoService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchCryptoPrice(String crypto) async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/simple/price',
        queryParameters: {'ids': crypto, 'vs_currencies': 'usd'},
      );
      return response.data;
    } catch (e) {
      throw Exception('Erro ao buscar preço.');
    }
  }

}
