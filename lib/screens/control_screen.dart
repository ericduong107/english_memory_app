import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:english_memory_app/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = len.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: appBar(),
      body: main(),
    );
  }

  Widget main() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(),
          Text(
            "How much a number word at once?",
            style:
                AppStyle.h4.copyWith(color: AppColors.lightGrey, fontSize: 18),
          ),
          const Spacer(),
          Text(
            "${sliderValue.toInt()}",
            style: AppStyle.h1.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 150),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Slider(
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                activeColor: AppColors.primaryColor,
                thumbColor: Colors.white,
                inactiveColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerLeft,
            child: Text(
              "slide to set",
              style: AppStyle.h4
                  .copyWith(color: AppColors.textColor, fontSize: 18),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.secondColor,
      title: Text(
        "Your control",
        style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
      ),
      leading: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
        child: Image.asset(AppAssets.leftArrow),
      ),
    );
  }
}
