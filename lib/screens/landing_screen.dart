import 'package:english_memory_app/screens/home_screen.dart';
import 'package:english_memory_app/ultilities/custom_page_route.dart';
import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
     * Ẩn thanh trạng thái ngày giờ, dung lượng pin
     * và ẩn các nút home, back, task view
     */
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome to",
                  style: AppStyle.h3,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "English",
                    style: AppStyle.h2.copyWith(
                      color: AppColors.blackGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      'Qoutes"',
                      style: AppStyle.h4.copyWith(height: 0.5),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: RawMaterialButton(
                  fillColor: AppColors.lightBlue,
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      FadeRoute(page: const HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: Image.asset(AppAssets.rightArrow),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
