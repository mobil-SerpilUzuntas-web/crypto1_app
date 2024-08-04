import 'package:crypto1_app/View/navBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/image/bitcoin1.gif'),
              ),
              SizedBox(
                height: myHeight * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: const Text(
                      'Crypto Investment',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.04,
                  ),
                  const Text(
                    'Learn more abount cryptocurrency,look to',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  const Text(
                    'the future in TO Crypto',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: myHeight * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Navbar()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 68, 22, 6),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: myWidth * 0.05,
                          vertical: myHeight * 0.014),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CREATE PORTFOLIO',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                          RotationTransition(
                              turns: AlwaysStoppedAnimation(310 / 360),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
