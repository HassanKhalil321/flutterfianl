import 'package:fluter_final_project/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluter_final_project/welcome.dart';

import 'package:http/http.dart' as http;
import 'pageone.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email = '';
  String password = '';
  String result = ''; // Variable to store the response message

  Map<String, String> createCredentials() {
    return {
      'email': email,
      'password': password,
    };
  }

  signup() async {
    var url = 'https://innumerous-sockets.000webhostapp.com/php/project.php/signup';

    Map<String, dynamic> postData = createCredentials();
    var jsonData = json.encode(postData);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      ).timeout(const Duration(seconds: 7));

      if (response.statusCode == 200) {
        setState(() {
          result = json.decode(response.body)['message'];
        });



        if (result == 'Email already exists') {
        } else if (result == '') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome(),));
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  child: Column(
                    children: [
                      const Text(
                        'SignUp',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 0),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),
                      Text(result,style: TextStyle(color: Colors.red,fontSize: 20)),
                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: signup,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  login(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
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
      ),
    );
  }
}
