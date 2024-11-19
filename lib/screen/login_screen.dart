import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:education_apps/provider/auth_provider.dart';
import 'package:education_apps/widget/textfield/textfield_email_widget.dart';
import 'package:education_apps/widget/textfield/textfield_pass_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      // Add your code to upload the image to your database here
    }
  }

  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProfider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Nexus Network Education',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: loadAuth.form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        loadAuth.isLogin ? "Login" : "Register",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Profile Image as a Circle
                      if (!loadAuth.isLogin)
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _image != null
                                ? FileImage(File(_image!.path))
                                : null,
                            child: const Icon(Icons.person,
                                size: 50, color: Colors.black54),
                          ),
                        ),
                      const SizedBox(height: 20),
                      TextfieldEmailWidget(controller: emailController),
                      const SizedBox(height: 15),
                      TextfieldPasswordWidget(controller: passwordController),
                      if (!loadAuth.isLogin) ...[
                        const SizedBox(height: 15),
                        Text('Name:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller:
                              nameController, // Using the new name controller
                          onSaved: (value) {
                            loadAuth.enteredName = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Text('Age:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: ageController,
                          onSaved: (value) {
                            loadAuth.enteredAge = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Text('School:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: schoolController,
                          onSaved: (value) {
                            loadAuth.enteredSchool = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your school';
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          loadAuth.submit(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          loadAuth.isLogin ? "Login" : "Register",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              loadAuth.isLogin = !loadAuth.isLogin;
                            });
                          },
                          child: Text(
                            loadAuth.isLogin
                                ? "Create account"
                                : "I already have an account",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
