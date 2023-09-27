import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/utils/color_source.dart';

class FallingBallScreen extends StatefulWidget {
  const FallingBallScreen({Key? key}) : super(key: key);

  @override
  _FallingBallScreenState createState() => _FallingBallScreenState();
}

class _FallingBallScreenState extends State<FallingBallScreen> {
  double ballPositionY = 0.0;
  double ballVelocityY = 1.0;
  int successfulDirectionChanges = 0;

  @override
  void initState() {
    super.initState();
    startFalling();
  }

  void startFalling() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        ballPositionY += ballVelocityY;

        if (ballPositionY <= 0 ||
            ballPositionY >= MediaQuery.of(context).size.height - 50) {
          ballVelocityY *= -1;
          successfulDirectionChanges++;

          if (ballPositionY <= 0) {
            ballPositionY = 0;
          } else if (ballPositionY >= MediaQuery.of(context).size.height - 50) {
            ballPositionY = MediaQuery.of(context).size.height - 50;
          }
        }
      });
    });
  }

  void onTapScreen() {
    setState(() {
      ballVelocityY *= -1;
      successfulDirectionChanges++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: onTapScreen,
        child: Stack(
          children: [
            Positioned(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    color: ColorsSourceApp.blue,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    color: ColorsSourceApp.red,
                  ),
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2,
              top: ballPositionY,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsSourceApp.yellow,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Successful Direction Changes: $successfulDirectionChanges',
                  style: const TextStyle(
                      fontSize: 18, color: ColorsSourceApp.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
