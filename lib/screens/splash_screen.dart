import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peace_pulse/screens/home_screen.dart';
import 'package:peace_pulse/utils/app_colors.dart';
import 'package:peace_pulse/utils/constants.dart';
import 'package:peace_pulse/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 3),
        () =>

            // Navigator.pushNamed(context, MyRoutes.homeRoute),

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                ModalRoute.withName("/Home")));

    // colorFilter:
    // const ColorFilter.mode(Colors.transparent, BlendMode.srcIn),
    var mLogo = SvgPicture.asset(Constants.completeLogoName,
        width: 180, semanticsLabel: 'Logo on Splash');

// child: Container(
//       decoration: BoxDecoration(
//           gradient: RadialGradient(
//               radius: 3.5,
//               colors: [Colors.green.shade50, Colors.green.shade900])),

    return Material(
      color: AppColors.appScreensBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: mLogo,
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 80),
                  Container(
                      color: Colors.amberAccent,
                      margin: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                      child: const LinearProgressIndicator(
                        color: AppColors.appDark,
                        backgroundColor: AppColors.appLight,
                      )),
                  const Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.only(right: 10.0, bottom: 4.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Version : 1 (1.0.1)",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appText),
                              ))))
                ],
              )),
        ],
      ),
    );
  }
}



//  child: Text(
//           "Splash Screen",
//           style: TextStyle(
//               fontSize: 50,
//               fontWeight: FontWeight.bold,
//               color: Colors.yellowAccent),
//         ),