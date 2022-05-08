import 'dart:io';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  String imagePath = '';
  DisplayImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/'),
        backgroundColor: Colors.black54,
        child: const Text('Logout', style: TextStyle(fontSize: 10),)//Icon(Icons.arrow_back),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54)),
              child: const Text(
                'SCAN OBJECT',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            width: 400,
            child: imagePath == '' ? null : Image.file(File(imagePath)),
          ),
        ],
      ),
    );
  }
}
