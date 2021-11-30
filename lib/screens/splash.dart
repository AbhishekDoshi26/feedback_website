import 'dart:async';
import 'package:feedback_website/constants/contact_constants.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController logoController;
  late Animation logoAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/avatar.jpg"), context);
    precacheImage(const AssetImage("assets/flutter.png"), context);
  }

  @override
  void initState() {
    super.initState();
    logoController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    logoController.forward(); //Proceeds animation forward
    logoController.addListener(() {
      setState(() {});
    });
    logoAnimation = CurvedAnimation(
      parent: logoController,
      curve: Curves.bounceInOut,
    );

    Timer(const Duration(seconds: 4), () {
      logoAnimation.removeListener(() {});
      logoController.dispose();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size:
                  logoAnimation.value * MediaQuery.of(context).size.height / 2,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(colors: [
                Colors.blue.shade400,
                Colors.blue.shade900,
              ]).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                ContactDetails.name,
                style: TextStyle(
                  fontSize: logoAnimation.value *
                      (MediaQuery.of(context).size.width / 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
