import 'package:flutter/services.dart';

class NativeChannel {
  static const platform = MethodChannel('crypto_tracker/channel');

  Future<void> showMessage(String message) async {
    try {
      await platform.invokeMethod('showMessage', {'message': message});
    } on PlatformException catch (e) {
      print("Erro: ${e.message}");
    }
  }
}
