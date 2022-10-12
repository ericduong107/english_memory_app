import 'package:english_memory_app/models/english_today.dart';
import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AllWordsScreen extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsScreen({super.key, required this.words});

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
        "English today",
        style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(AppAssets.leftArrow),
      ),
    );
  }

  Widget main() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: words
            .map((item) => Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.primaryColor,
                  ),
                  child: AutoSizeText(item.noun ?? "",
                      style: AppStyle.h3.copyWith(shadows: [
                        BoxShadow(
                            color: AppColors.shadowColor,
                            offset: const Offset(2, 4),
                            blurRadius: 4),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.fade),
                ))
            .toList(),
      ),
    );
  }
}
