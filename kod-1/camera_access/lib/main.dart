import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();
  runApp(MyApp(cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  MyApp(this.cameras);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamera'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 330,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller!);
                  } else {      
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            Container(
              child: Center(child: Text("Fotograf gelecek")),
              height: 300,
              width: 330,
            ),

            ElevatedButton(
              onPressed: () {

              },
              child: Icon(Icons.picture_in_picture),
            ),
          ],
        ),
      ),
    );
  }
}
