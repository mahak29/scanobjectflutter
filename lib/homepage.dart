import 'package:brainsys/signin.dart';
import 'package:brainsys/signup.dart';

import 'package:flutter/material.dart';

import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
             Container(
                height: 250,
                width: 500,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/login.gif"))),

                //color: Colors.red
              ),
            
            FlutterToggleTab(
                width: 70,
                borderRadius: 20,
                height: 40,
                labels: const ["Existing User", "New User"],
                selectedLabelIndex: (index) {
                  setState(() {
                    _isSelected = index;
                  });
                },
                marginSelected: const EdgeInsets.all(3),
                selectedBackgroundColors: const [Colors.black45],
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                unSelectedTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                selectedIndex: _isSelected),
            const SizedBox(
              height: 20,
            ),
            _isSelected == 0 ? SignIn() : SignUp()
          ],
        ),
      ),
    );
  }
}
