import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Center the logo on top
          Center(
            child: Container(
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
              child: Image.asset('assets/images/splash2.png'),
            ),
          ),

          // Position the loading indicator below the logo with some padding
          Positioned(
            bottom: 350.0, // Adjust padding as needed
            right: 0.0,
            left: 0.0,
            child: Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.black,
                  size: 40,
                  secondRingColor: Colors.black,
                  thirdRingColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
