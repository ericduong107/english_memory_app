import 'dart:math';

import 'package:english_memory_app/models/english_today.dart';
import 'package:english_memory_app/packages/quote/quote.dart';
import 'package:english_memory_app/packages/quote/quote_model.dart';
import 'package:english_memory_app/screens/all_words_screen.dart';
import 'package:english_memory_app/screens/control_screen.dart';
import 'package:english_memory_app/screens/favorites_screen.dart';
import 'package:english_memory_app/screens/landing_screen.dart';
import 'package:english_memory_app/screens/search_screen.dart';
import 'package:english_memory_app/ultilities/custom_page_route.dart';
import 'package:english_memory_app/values/app_assets.dart';
import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:english_memory_app/values/share_keys.dart';
import 'package:english_memory_app/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<EnglishToday> words = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String quote = Quotes().getRandom().content!;

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByNoun(noun);
    return EnglishToday(
        noun: noun,
        quote: quote?.content,
        id: quote?.id,
        author: quote?.author);
  }

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 0.9);
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: appBar(),
      body: main(),
      floatingActionButton: buttonExchange(),
      drawer: drawer(),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: Container(
        color: AppColors.lightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16),
              child: Text(
                "Your mind",
                style: AppStyle.h3.copyWith(color: AppColors.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(
                label: "Favorite",
                opTap: () {
                  Navigator.of(context)
                      .push(SlideRightRoute(page: const FavoritesScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(
                label: "Your control",
                opTap: () {
                  Navigator.of(context)
                      .push(SlideRightRoute(page: const ControlScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(
                label: "Log out",
                opTap: () {
                  Navigator.of(context).pushReplacement(
                      SlideRightRoute(page: const LandingScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buttonExchange() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        setState(() {
          getEnglishToday();
          quote = Quotes().getRandom().content!;
        });
      },
      child: Image.asset(AppAssets.exchange),
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
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Image.asset(AppAssets.menu),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(SlideLeftRoute(page: SearchScreen(listWords: words)));
          },
          child: Image.asset(
            AppAssets.search,
            width: 35,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget main() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: size.height * 1 / 10,
            alignment: Alignment.centerLeft,
            child: Text(
              '"$quote"',
              style: AppStyle.h5
                  .copyWith(fontSize: 12, color: AppColors.textColor),
            ),
          ),
          SizedBox(
            height: size.height * 2 / 3,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              controller: _pageController,
              itemCount: words.length > 5 ? 6 : words.length,
              itemBuilder: (context, index) {
                String firstLetter =
                    words[index].noun != null ? words[index].noun! : "";
                firstLetter = firstLetter.substring(0, 1).toUpperCase();

                String leftLetter =
                    words[index].noun != null ? words[index].noun! : "";
                leftLetter = leftLetter.substring(1, leftLetter.length);

                String quoteDefault =
                    '"Think of all the beauty still left around you and be happy"';

                String quote = words[index].quote != null
                    ? '"${words[index].quote!}"'
                    : quoteDefault;

                String authorDefault = "Eric Duong";

                String author = words[index].author != null
                    ? '"${words[index].author!}"'
                    : authorDefault;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: AppColors.primaryColor,
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        // setState(() {
                        //   words[index].isFavorite = !words[index].isFavorite;
                        // });
                        // ignore: avoid_print
                        print("Detail: ${words[index].noun}");
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      splashColor: Colors.transparent,
                      child: cardWidget(
                        index,
                        firstLetter: firstLetter,
                        leftLetter: leftLetter,
                        quote: quote,
                        author: author,
                        // favoriteColor:
                        //     words[index].isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _currentIndex >= 5
              ? buildShowMore()
              : SizedBox(
                  height: size.height * 1 / 20,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return buildIndicator(index == _currentIndex, size);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget cardWidget(
    int index, {
    required String firstLetter,
    required String leftLetter,
    required String quote,
    required String author,
    // required Color favoriteColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   alignment: Alignment.centerRight,
          //   child: Image.asset(
          //     AppAssets.heart,
          //     color: favoriteColor,
          //   ),
          // ),
          LikeButton(
            onTap: (isLiked) async {
              setState(() {
                words[index].isFavorite = !words[index].isFavorite;
              });
              return words[index].isFavorite;
            },
            size: 42,
            isLiked: words[index].isFavorite,
            mainAxisAlignment: MainAxisAlignment.end,
            circleColor: const CircleColor(
                start: Color(0xff00ddff), end: Color(0xff0099cc)),
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
                  size: 42,
                ),
              );
            },
          ),
          cardTitle(firstLetter: firstLetter, leftLetter: leftLetter),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: AutoSizeText(
              quote,
              style: AppStyle.h4
                  .copyWith(color: AppColors.textColor, letterSpacing: 1),
              maxLines: 7,
              overflow: TextOverflow.fade,
              maxFontSize: 26,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            alignment: Alignment.bottomRight,
            child: Text(
              "- $author",
              style: GoogleFonts.sen(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardTitle({required String firstLetter, required String leftLetter}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      text: TextSpan(
        text: firstLetter,
        style: GoogleFonts.sen(
          fontSize: 89,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        children: [
          TextSpan(
            text: leftLetter,
            style: GoogleFonts.sen(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              shadows: [],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, offset: Offset(2, 3), blurRadius: 3),
        ],
      ),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Material(
        color: AppColors.primaryColor,
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(SlideLeftRoute(page: AllWordsScreen(words: words)));
          },
          splashColor: Colors.black38,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text("Show more", style: AppStyle.h5),
          ),
        ),
      ),
    );
  }
}
