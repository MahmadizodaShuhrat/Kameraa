import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  VlcPlayerController? _vlcController;

  Future<void> requestPermissions() async {
    bool cameraGranted = false;

    do {
      var status = await [
        Permission.camera,
        Permission.storage,
      ].request();

      cameraGranted = status[Permission.camera]?.isGranted ?? false;

      if (!cameraGranted) {
        print('Иҷозати камера рад шуд! Лутфан иҷоза диҳед.');
      }

      if (status[Permission.storage]?.isDenied ?? true) {
        print('Иҷозати хос рад шуд! Лутфан иҷоза диҳед.');
      }
    } while (!cameraGranted);

    print('Иҷозати камера дода шуд!');
  }

  @override
  void initState() {
    super.initState();
    _emitPermissionRequest();
  }

  void _emitPermissionRequest() async {
    await requestPermissions();
    _vlcController = VlcPlayerController.network(
      'rtsp://admin:Dushanbe_2024@95.142.89.10:5050',
      hwAcc: HwAcc.full,
      autoPlay: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _vlcController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Просмотр камеры'),
      ),
      body: _vlcController == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: VlcPlayer(
                controller: _vlcController!,
                aspectRatio: 16 / 9,
                placeholder: Center(child: CircularProgressIndicator()),
              ),
            ),
    );
  }
}
