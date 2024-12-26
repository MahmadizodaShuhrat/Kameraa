import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late VlcPlayerController _vlcController;

  Future<void> requestPermissions() async {
    var status = await [
      Permission.camera,
      Permission.storage,
    ].request();

    if (status[Permission.camera]?.isDenied ?? true) {
      print('Иҷозати камера рад шуд!');
    }
    if (status[Permission.storage]?.isDenied ?? true) {
      print('Иҷозати хос дархост шуд!');
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions(); 
    _vlcController = VlcPlayerController.network(
      'rtsp://admin:Dushanbe_2024@95.142.89.10:5050',
      hwAcc: HwAcc.full,
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    _vlcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Просмотр камеры'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _vlcController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
