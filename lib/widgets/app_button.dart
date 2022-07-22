import 'package:flutter/material.dart';
import 'package:flutter_demo/values/app_colors.dart';
import 'package:flutter_demo/values/app_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 14),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26,
              offset: Offset(3,3),
              blurRadius: 6
            )
          ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(label,
          style: AppStyle.h5.copyWith(color: AppColors.textColor),
    
        ),
      ),
    );
  }
}
