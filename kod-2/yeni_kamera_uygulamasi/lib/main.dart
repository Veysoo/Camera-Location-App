import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final picker = ImagePicker();
  File? image;
  Position? p1;
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    if (await Permission.locationWhenInUse.isGranted) {
      // GPS izni zaten verilmişse burada işlemleri gerçekleştirin
      print('GPS izni zaten verilmiş.');
    } else {
      // GPS izni verilmemişse izin iste
      final status = await Permission.locationWhenInUse.request();
      if (status.isGranted) {
        print('GPS izni verildi.');
      } else {
        print('GPS izni verilmedi.');
      }
    }
  }

  Map<String, dynamic>? exifData1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kamera"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: image == null
                      ? Text('Fotoğraf seçilmedi.')
                      : Image.file(image!),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    child: Center(
                      child: exifData1 != null
                          ? Text(
                              'Enlem : ${p1?.latitude} , Boylam : ${p1?.longitude} , \n Exif Verileri : ${exifData1}')
                          : Text('Veriler Gelecek.'),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  p1 = await konum();
                  fotoGetir(ImageSource.gallery);
                },
                child: Text("GALERİDEN SEÇ")),
            ElevatedButton(
                onPressed: () async {
                  p1 = await konum();
                  fotoGetir(ImageSource.camera);
                },
                child: Text("KAMERADAN ÇEK")),
          ],
        ),
      ),
    );
  }

  Future<Position> konum() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  void fotoGetir(ImageSource? source) async {
    try {
      await getImage(source!);
    } catch (e) {
      print(e);
    }
  }

  getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      image = File(pickedFile!.path);
    });

    final exifData = await readExifFromBytes(await image!.readAsBytes());

    setState(() {
      exifData1 = exifData;
    });
  }
}
