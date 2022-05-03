import 'package:brainsys/homepage.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const Text(
              'to',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const Text(
              'Brainsys',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black38)),
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
