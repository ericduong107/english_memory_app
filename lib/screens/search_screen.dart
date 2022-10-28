import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: appBar(),
      body: main(),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(AppAssets.leftArrow),
      ),
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      actions: [
        InkWell(
          onTap: () {
            print("Search: ${_controller.text}");
          },
          child: Image.asset(
            AppAssets.search,
            width: 35,
          ),
        )
      ],
      title: TextField(
        controller: _controller,
        autofocus: true,
        onSubmitted: (String value) {
          print('Submit: $value');
        },
        keyboardType: TextInputType.text,
        cursorColor: AppColors.greyText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search...",
          hintStyle: AppStyle.h5.copyWith(color: AppColors.greyText),
        ),
      ),
    );
  }

  Widget main() {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      ),
    );
  }
}
