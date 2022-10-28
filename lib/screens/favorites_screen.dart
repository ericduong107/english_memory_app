import 'package:english_memory_app/models/english_today.dart';
import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FavoritesScreen extends StatelessWidget {
  // final List<EnglishToday> words;
  const FavoritesScreen({
    super.key,
    // required this.words,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: appBar(context),
      body: main(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.secondColor,
      title: Text(
        "Favorites",
        style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(AppAssets.leftArrow),
      ),
      actions: [
        Image.asset(
          AppAssets.grid,
          // color: Colors.black,
          width: 30,
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget main() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: const Text("Duongw Khang Hy"),
    );
  }
}
