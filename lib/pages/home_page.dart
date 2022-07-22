import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/english_today.dart';
import 'package:flutter_demo/pages/all_work_page.dart';
import 'package:flutter_demo/pages/control_page.dart';
import 'package:flutter_demo/values/app_colors.dart';
import 'package:flutter_demo/values/app_styles.dart';
import 'package:flutter_demo/values/share_key.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_demo/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/pages/all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

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
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    setState(() {
      words = newList.map((e) => EnglishToday(noun: e)).toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          textAlign: TextAlign.right,
          style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: AppColors.textColor,
            size: 40,
          ),
        ),
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              height: size.height / 10,
              child: Text(
                '"It is amazing how complete is the delusion that beauty is goodness."',
                style: AppStyle.h5
                    .copyWith(fontSize: 12, color: AppColors.textColor),
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: size.height * 2 / 3,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length > 5 ? 6 : words.length,
                  itemBuilder: (context, index) {
                    String firstLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    firstLetter = firstLetter.substring(0, 1);

                    String leftLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    leftLetter = leftLetter.substring(1, leftLetter.length);

                    // ignore: avoid_unnecessary_containers
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        color: AppColors.primaryColor,
                        elevation: 4,
                        child: InkWell(
                          onDoubleTap: () {
                            setState(() {
                              words[index].isFavorite =
                                  !words[index].isFavorite;
                            });
                          },
                          splashColor: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: index >= 5
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => AllWordPageItem(words: words)));
                                    },
                                    child: Center(
                                      child: Text(
                                        'Show more...',
                                        style: AppStyle.h3.copyWith(
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              const BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 3),
                                                  blurRadius: 3)
                                            ]),
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          padding: const EdgeInsets.only(
                                              top: 16, right: 16),
                                          // ignore: dead_code
                                          child: Icon(
                                            words[index].isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: words[index].isFavorite
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                                text: firstLetter.toUpperCase(),
                                                style: GoogleFonts.sen(
                                                    fontSize: 89,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      const BoxShadow(
                                                          color: Colors.black38,
                                                          offset: Offset(3, 3),
                                                          blurRadius: 3)
                                                    ]),
                                                children: [
                                                  TextSpan(
                                                      text: leftLetter,
                                                      style: GoogleFonts.sen(
                                                          fontSize: 56,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          shadows: [
                                                            const BoxShadow(
                                                                color: Colors
                                                                    .black38,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 6)
                                                          ]))
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 24, left: 16, right: 16),
                                          child: Text(
                                            '"Think of all the beauty still left around you and be happy."',
                                            style: AppStyle.h4.copyWith(
                                                letterSpacing: 1,
                                                color: AppColors.textColor),
                                          ),
                                        )
                                      ]),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            _currentIndex >= 5
                ? buildShowMore()
                : SizedBox(
                    height: 24,
                    child: Container(
                      alignment: Alignment.center,
                      height: 8,
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildIndicator(index == _currentIndex, size);
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          // ignore: avoid_print
          setState(() {
            getEnglishToday();
          });
        },
        child: const Icon(Icons.refresh),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16),
              child: Text(
                'Your mind',
                style: AppStyle.h3.copyWith(color: AppColors.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(
                  label: 'Favorites',
                  onTap: () {
                    // print('Favorites');
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(
                  label: 'Your control',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ControlPage()));
                  }),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      curve: Curves.bounceInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            // ignore: prefer_const_constructors
            BoxShadow(
                color: Colors.black38,
                // ignore: prefer_const_constructors
                offset: Offset(2, 3),
                blurRadius: 3)
          ]),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: AppColors.primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AllWordPage(
                          words: words,
                        )));
          },
          splashColor: Colors.black38,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Show more',
              style: AppStyle.h5.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
