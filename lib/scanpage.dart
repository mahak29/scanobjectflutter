import 'dart:async';


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:brainsys/welcome.dart';

class ScanPage extends StatefulWidget {
  ScanPage({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  final CameraDescription cameras;
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final key = GlobalKey();
  late CameraController _controller;

  ScanController controller = ScanController();

  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       child: CameraPreview(_controller));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
 }),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  Navigator.pushNamed(context, '/second');
                   await Navigator.push(
                     context,
                   MaterialPageRoute(
                     builder: ((context) =>
                       DisplayImage(imagePath: image.path,))));
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                ),
              )
            )));
  }
}
