import 'package:flutter/material.dart';
import 'package:flutter_demo/models/english_today.dart';
import 'package:flutter_demo/values/app_colors.dart';
import 'package:flutter_demo/values/app_styles.dart';

class AllWordPageItem extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordPageItem({Key? key, required this.words}) : super(key: key);

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
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_left_outlined,
            color: AppColors.textColor,
            size: 50,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: (index%2)==0?AppColors.primaryColor:AppColors.secondColor,
            child: ListTile(
              leading: Icon(
                words[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                color: words[index].isFavorite ? Colors.red : null,
              ),
              subtitle: Text('Subtitle: ${words[index].noun!}'),
              contentPadding: const EdgeInsets.all(16),
              title: Text(words[index].noun!,style:(index%2)==0? AppStyle.h4:AppStyle.h4.copyWith(color: AppColors.textColor)),
            ),
          );
        },
      ),
    );
  }
}
