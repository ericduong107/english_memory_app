import 'package:english_memory_app/main.dart';
import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: appBar(),
      body: main(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          print("exchange");
        },
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.secondColor,
      title: Text(
        "English today",
        style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
      ),
      leading: InkWell(
        onTap: () {},
        child: Image.asset(AppAssets.menu),
      ),
    );
  }

  Widget main() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: size.height * 1 / 10,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              '"It is amazing how complete is the delusion that beauty is goodness."',
              style: AppStyle.h5
                  .copyWith(fontSize: 12, color: AppColors.textColor),
            ),
          ),
          Container(
            height: size.height * 2 / 3,
            color: Colors.red,
            child: PageView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Text("$index");
              },
            ),
          ),
        ],
      ),
    );
  }
}
