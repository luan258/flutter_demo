import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/values/app_colors.dart';
import 'package:flutter_demo/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Welcome to',
              style: AppStyle.h3,
            ),
          )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'English',
                  style: AppStyle.h2.copyWith(
                      color: AppColors.blackGrey, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Qoutes',
                    textAlign: TextAlign.right,
                    style: AppStyle.h4.copyWith(
                      height: 0.5
                    ),
                  ),
                )
              ],
            )),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),     //tesst
                child: RawMaterialButton(
                  onPressed: (){
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()));
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const HomePage()), (route) => false);
                  },
                  fillColor: AppColors.lightBlue,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.navigate_next,size: 60),
                ),
              ),
              )
        ]),
      ),
    );
  }
}
