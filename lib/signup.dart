import 'package:brainsys/homepage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email1 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController passwd = TextEditingController();
  TextEditingController confirm_passwd = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isHidden = true;

  void _passwdview() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  String pass_validate(value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 8) {
      return "Password should not be more than 8 characters";
    } else if (value != passwd.text) {
      return "Password not matched";
    } else {
      return "";
    }
  }

  @override
  void dispose() {
    email1.dispose();
    passwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        width: 300,
        child: Column(
          children: [
            Container(
              height: 418,
              child: Card(
                  shadowColor: Colors.black,
                  elevation: 10,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              const IconButton(
                                  icon: Icon(Icons.person), onPressed: null),
                              Expanded(
                                  child: TextFormField(
                                controller: name,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 14),
                                    hintText: 'Full Name',
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter your name';
                                  }
                                },
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              const IconButton(
                                  icon: Icon(Icons.mail_outline),
                                  onPressed: null),
                              Expanded(
                                  child: TextFormField(
                                controller: email1,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 14),
                                    hintText: 'Email',
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                validator: (email) {
                                  email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              const IconButton(
                                  icon: Icon(Icons.phone), onPressed: null),
                              Expanded(
                                  child: TextFormField(
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: phone,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 14),
                                    hintText: 'Phone Number',
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter phone number';
                                  }
                                },
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: <Widget>[
                              const IconButton(
                                  icon: Icon(Icons.lock), onPressed: null),
                              Expanded(
                                  child: TextFormField(
                                controller: passwd,
                                obscureText: isHidden,
                                maxLength: 8,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintStyle: const TextStyle(fontSize: 14),
                                  suffix: InkWell(
                                      onTap: _passwdview,
                                      child: Icon(Icons.visibility)),
                                ),
                                validator: pass_validate,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: <Widget>[
                              const IconButton(
                                  icon: Icon(Icons.lock), onPressed: null),
                              Expanded(
                                  child: TextFormField(
                                controller: confirm_passwd,
                                maxLength: 8,
                                obscureText: isHidden,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 14),
                                  hintText: 'Confirm Password',
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  suffix: InkWell(
                                      onTap: _passwdview,
                                      child: const Icon(Icons.visibility)),
                                ),
                                validator: pass_validate,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () {
                                  print('signed up');
                                  signUp();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black38)),
                                child: const Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email1.text.trim(), password: passwd.text.trim());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e);
      Snack1.showSnackBar(e.toString());
    }
  }
}

GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

class Snack1 {
  static showSnackBar(String? text) {
    if (text == null) return;
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.redAccent,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
