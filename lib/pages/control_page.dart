import 'package:flutter/material.dart';
import 'package:flutter_demo/values/app_colors.dart';
import 'package:flutter_demo/values/app_styles.dart';
import 'package:flutter_demo/values/share_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue () async{
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter)??5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'Your control',
          textAlign: TextAlign.right,
          style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_left_outlined,
            color: AppColors.textColor,
            size: 50,
          ),
        ),
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(children: [
          const Spacer(),
          Text(
            'How much a number word at once',
            style:
                AppStyle.h4.copyWith(color: AppColors.lightGrey, fontSize: 18),
          ),
          const Spacer(),
          Text(
            '${sliderValue.toInt()}',
            style: AppStyle.h1.copyWith(
                color: AppColors.primaryColor,
                fontSize: 150,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Slider(
              value: sliderValue,
              min: 5,
              max: 100,
              divisions: 95,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              }),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Slide to set',
              style: AppStyle.h5.copyWith(color: AppColors.textColor),
            ),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ]),
      ),

    );
  }
}
