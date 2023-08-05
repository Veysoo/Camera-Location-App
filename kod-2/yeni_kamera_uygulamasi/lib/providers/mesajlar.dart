import 'package:flutter/material.dart';

class veriler with ChangeNotifier {
  Map<String, dynamic>? exif;
  String? sehir;
  String? ulke;
  String? sokak;

  void veri() {
    print("exif: $exif, sehir : $sehir , ulke : $ulke ,sokak : $sokak ");
    notifyListeners();
  }
}
