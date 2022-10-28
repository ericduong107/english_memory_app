import 'package:english_memory_app/models/english_today.dart';
import 'package:english_memory_app/screens/favorites_screen.dart';
import 'package:english_memory_app/ultilities/custom_page_route.dart';
import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:like_button/like_button.dart';

class AllWordsScreen extends StatefulWidget {
  final List<EnglishToday> words;
  const AllWordsScreen({super.key, required this.words});

  @override
  State<AllWordsScreen> createState() => _AllWordsScreenState();
}

class _AllWordsScreenState extends State<AllWordsScreen> {
  String iconViewMode = AppAssets.list;
  String viewMode = "";

  @override
  void initState() {
    super.initState();
    viewMode = "grid";
    iconViewMode = AppAssets.list;
  }

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
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, SlideLeftRoute(page: const FavoritesScreen()));
          },
          child: Image.asset(
            AppAssets.heart,
            color: const Color(0xff353535),
            width: 40,
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            if (viewMode == "grid") {
              setState(() {
                iconViewMode = AppAssets.grid;
                viewMode = "list";
              });
            } else if (viewMode == "list") {
              setState(() {
                iconViewMode = AppAssets.list;
                viewMode = "grid";
              });
            }
          },
          child: Image.asset(
            iconViewMode,
            // color: Colors.black,
            width: 30,
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget main() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: viewMode == "grid" ? modeGrid() : modeList(),
    );
  }

  Widget modeList() {
    var w = widget.words;
    return ListView.builder(
      itemCount: w.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color:
                index % 2 == 0 ? AppColors.primaryColor : AppColors.secondColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              w[index].noun!,
              style: index % 2 == 0
                  ? AppStyle.h4
                  : AppStyle.h4.copyWith(color: AppColors.textColor),
            ),
            subtitle: Text(w[index].quote ??
                "Think of all the beauty still left around you and be happy"),
            leading: Text(
              index < 9 ? "0${index + 1}" : "${index + 1}",
              style: index % 2 == 0
                  ? AppStyle.h3
                  : AppStyle.h3.copyWith(color: AppColors.textColor),
            ),
            trailing: Icon(
              Icons.favorite,
              color: w[index].isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget modeGrid() {
    var w = widget.words;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: w.map((item) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.primaryColor,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AutoSizeText(item.noun ?? "",
                  style: AppStyle.h3.copyWith(shadows: [
                    BoxShadow(
                        color: AppColors.shadowColor,
                        offset: const Offset(2, 4),
                        blurRadius: 4),
                  ]),
                  maxLines: 1,
                  overflow: TextOverflow.fade),
              Positioned(
                top: 10,
                right: 10,
                child: favoriteButton(item),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget favoriteButton(wordIndex) {
    return LikeButton(
      onTap: (isLiked) async {
        setState(() {
          wordIndex.isFavorite = !wordIndex.isFavorite;
        });
        return wordIndex.isFavorite;
      },
      size: 30,
      isLiked: wordIndex.isFavorite,
      mainAxisAlignment: MainAxisAlignment.end,
      circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Container(
          alignment: Alignment.centerRight,
          child: ImageIcon(
            const AssetImage(AppAssets.heart),
            color: isLiked ? Colors.red : Colors.white,
            size: 30,
          ),
        );
      },
    );
  }
}
