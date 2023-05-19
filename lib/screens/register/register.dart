import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/authentication_provider.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool passwordCheck = false;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/IMG_4829.JPG'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 100),
              child: Text(
                'Travela',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) {
                              emailController.text = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(),
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) {
                              passwordController.text = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) {
                              confirmPasswordController.text = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Full Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) {
                              nameController.text = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) {
                              usernameController.text = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              handleSignUp();
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleSignUp() {
    print(emailController.text);
    print(passwordController.text);
    print(confirmPasswordController.text);
    print(nameController.text);
    print(usernameController.text);
    if (passwordController.text == confirmPasswordController.text) {
      passwordCheck = true;
    }
    if (!EmailValidator.validate(emailController.text)) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Invalid Email'),
                content: Text('Please enter a valid email address'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ));
    } else if (passwordCheck) {
      final authenticaticationData =
          Provider.of<AuthenticationProvider>(context, listen: false);
      authenticaticationData
          .register(
        email: emailController.text,
        name: nameController.text,
        username: usernameController.text,
        password: passwordController.text,
      )
          .then((value) {
        if (value && usernameController.text != '') {
          //login
          authenticaticationData
              .login(
                email: emailController.text,
                name: nameController.text,
                username: usernameController.text,
                password: passwordController.text,
              )
              .then((value) => {
                    if (value)
                      {
                        Navigator.pushReplacementNamed(
                            context, '/questionnaire'),
                      }
                  });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('Could not register'),
                    content: Text('Please try again'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ));
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Passwords do not match'),
          content: Text('Please enter matching passwords'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
