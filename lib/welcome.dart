import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fluter_final_project/pageOne.dart';
import 'package:fluter_final_project/pagetwo.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Row(children: [
          Column(children: [
            Container(width: 195,height: 803,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.red, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 401,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                    ,onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => pagetwo(),));
                  },
                    child: Container(width: 100,height: 50,

                      child: Center(
                        child: Text(
                          "Germany",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ),
          ],),
          Column(children: [
            Container(width: 197,height: 803,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.white, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 401,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                    ,onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => pageone(),));
                  },
                    child: Container(width: 100,height: 50,

                      child: Center(
                        child: Text(
                          "Italy",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],)
        ],));
  }
}
