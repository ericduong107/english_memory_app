import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List listWords;
  const SearchScreen({super.key, required this.listWords});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  List<String> history = [];

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
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
            setState(() {
              history.add(_controller.text);
            });
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
        onSubmitted: (String value) {},
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
    return ListView.separated(
      itemBuilder: (context, index) {
        if (history.isEmpty) {
          return Container();
        } else {
          return ListTile(
            title: Text(history[index]),
            trailing: InkWell(
              onTap: () {
                setState(() {
                  history.removeAt(index);
                });
              },
              child: Image.asset(
                AppAssets.close,
                width: 30,
              ),
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return const Divider(color: Colors.black45);
      },
      itemCount: history.length,
    );
  }
}
