import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictactoe/home.dart';


class Launch extends StatefulWidget {
  Launch({super.key});

  @override
  State<Launch> createState() => LaunchState();
}

class LaunchState extends State<Launch> with SingleTickerProviderStateMixin{
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();
    navigateTohome();
  }

  navigateTohome() async {
  
    await Future.delayed(const Duration(seconds:5), () {
 
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Tic Tac Toe')));
      
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/tactoe.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset(
                      'assets/images/tictac.png',
                      height: 200,
                      width: 200,
                    ),
            ),
            Positioned(
              top: 750.0, // Adjust top position
              left: 170.0, // Adjust left position
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('from', style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text('kasune', style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
  ); 
  }
}
