import 'package:brainsys/google_auth.dart';
import 'package:brainsys/signup.dart';
import 'package:brainsys/welcome.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();

  bool isHidden = true;
  bool isloggedin = false;
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
    email.dispose();
    passwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        width: 300,
        //  color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 228,
              child: Card(
                shadowColor: Colors.black,
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          const IconButton(
                              icon: Icon(Icons.mail_outline), onPressed: null),
                          Expanded(
                              child: TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                            validator: (email) {
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null;
                            },
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          const IconButton(
                              icon: Icon(Icons.lock), onPressed: null),
                          Expanded(
                              child: TextFormField(
                            controller: passwd,
                            obscureText: isHidden,
                            maxLength: 8,
                            cursorColor: Colors.black26,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                suffix: InkWell(
                                    onTap: _passwdview,
                                    child: const Icon(
                                      Icons.visibility,
                                      size: 20,
                                    ))),
                            validator: pass_validate,
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              print('signed in');
                              signIn();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black38)),
                            child: const Text(
                              'SIGN IN',
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      color: Colors.black,
                      //height: 36,
                    )),
              ),
              const Text("OR"),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                print('hhhhhhhhhhhhhh');

                FirebaseService service = FirebaseService();
                try {
                  await service.signInwithGoogle();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => WelcomeScreen())));
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    Text(e.message!);
                  }
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black45,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: const BorderSide(color: Colors.grey)),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                        image: AssetImage("assets/google_logo.png"),
                        height: 25.0),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: passwd.text.trim());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } catch (e) {
      print(e.toString());

      Snack1.showSnackBar(e.toString());
    }
  }
}
