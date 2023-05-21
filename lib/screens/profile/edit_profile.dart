import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/file_storage_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileStorage =
        Provider.of<FileStorageProvider>(context, listen: false);
    // fileStorage.uploadProfilePic(image!.path, userId);
    String password = "12345678";
    final userData = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: image == null
                            ? null
                            : MemoryImage(profilePic, scale: 1),
                      ),
                      IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userUsername,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userEmail,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Cenk Duran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'cekoley',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'cekoley@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("email" + emailController.text);
                  print("user" + usernameController.text);
                  print("name" + nameController.text);
                  print(password);

                  if (usernameController.text == "" ||
                      emailController.text == "" ||
                      nameController.text == "") {
                    usernameController.text = userUsername;
                    emailController.text = userEmail;
                    nameController.text = nameOfUser;
                  }

                  if (!EmailValidator.validate(emailController.text)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text('Invalid Email'),
                              content:
                                  Text('Please enter a valid email address'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ));
                  } else {
                    userData
                        .updateUserInfo(
                            userId,
                            nameController.text,
                            usernameController.text,
                            emailController.text,
                            password)
                        .then((value) {
                      if (value) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Platform.isIOS
                                ? CupertinoAlertDialog(
                                    title: Text('Success'),
                                    content: Text(
                                        'Profile is successfully updated!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/home');
                                          pageNum = 4;
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                : AlertDialog(
                                    title: Text('Success'),
                                    content: Text(
                                        'Profile is successfully updated!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/home');
                                          pageNum = 4;
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Platform.isIOS
                                ? CupertinoAlertDialog(
                                    title: Text('Error'),
                                    content: Text('Profile cannot be updated'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                : AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Profile cannot be updated'),
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
                  }
                },
                child: Text('Save'),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => Platform.isIOS
                          ? CupertinoAlertDialog(
                              title: Text('Delete Account'),
                              content: Text(
                                  'Are you sure you want to delete your account?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    userData.deleteUser(userId);
                                    Navigator.of(ctx).pop();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/login', (route) => false);
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            )
                          : AlertDialog(
                              title: Text('Delete Account'),
                              content: Text(
                                  'Are you sure you want to delete your account?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    userData.deleteUser(userId);
                                    Navigator.of(ctx).pop();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/login', (route) => false);
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            ));
                },
                child: Text(
                  'Delete Account',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
