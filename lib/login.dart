import 'package:fluter_final_project/signup.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluter_final_project/welcome.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'pageone.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loggedIn = false;
  String email = '';
  String password = '';
  String result = '';

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    if (loggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Welcome()));
     }
  }

  loginn() async {
    var url = 'https://innumerous-sockets.000webhostapp.com/php/login.php';
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    Map<String, dynamic> createCredentials() {
      return {
        'email': email,
        'password': password,
      };
    }

    Map<String, dynamic> postData = createCredentials();
    var jsonData = json.encode(postData);

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonData,
          )
          .timeout(const Duration(seconds: 7)); // Add timeout

      if (response.statusCode == 200) {
        setState(() {
          result = json.decode(response.body)['message'];
        });

        if (result == '') {
          sharedPreferences.setBool('loginstate', true);
          setState(() {
            loggedIn = true;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Welcome()));
        }
      } else {
        sharedPreferences.setBool('loginstate', false);
        setState(() {
          loggedIn = false;
        });
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
                        'login',
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
                      Text(result,
                          style: TextStyle(color: Colors.red, fontSize: 20)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: loginn,
                        child: Text(
                          'LogIn',
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
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: const Text(
                              'SignUp',
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
