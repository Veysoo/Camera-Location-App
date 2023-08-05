import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeni_kamera_uygulamasi/providers/mesajlar.dart';

class IkinciSayfa extends StatefulWidget {
  const IkinciSayfa({super.key});

  @override
  State<IkinciSayfa> createState() => _IkinciSayfaState();
}

class _IkinciSayfaState extends State<IkinciSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EXİF VE KONUM BİLGİLERİ"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: (Provider.of<veriler>(context).sehir != null)
                ? Text(
                    "Sehir : ${Provider.of<veriler>(context).sehir}, ulke : ${Provider.of<veriler>(context).ulke} , sokak : ${Provider.of<veriler>(context).sokak}, Exif verileri : ${Provider.of<veriler>(context).exif}")
                : Text("Lütfen önceki sayfadan fotoğraf yükleyin"),
          ),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Önceki sayfaya dön"),
            ),
          ),
        ],
      ),
    );
  }
}
