import 'package:flutter/material.dart';
import 'package:flutter_demo/models/english_today.dart';
import 'package:flutter_demo/values/app_colors.dart';
import 'package:flutter_demo/values/app_styles.dart';
class AllWordPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordPage({Key? key,required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          textAlign: TextAlign.right,
          style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(
              context
            );
          },
          child: const Icon(
            Icons.arrow_left_outlined,
            color: AppColors.textColor,
            size: 50,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: words.map((e) => Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Text(
              e.noun??'',
              style: AppStyle.h4.copyWith(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.fade
              ),
            ),
          )).toList(),
        )
      ),
    );
  }
}