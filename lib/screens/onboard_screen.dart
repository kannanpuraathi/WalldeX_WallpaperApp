import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walldex_app/model/onboard_model.dart';
import 'package:walldex_app/screens/home_screen.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

_storeonboardinfo() async {
  int? initScreen = 0;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  if (kDebugMode) {
    print('initScreen $initScreen');
  }
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/onboard1.jpg',
      desc:
          "think it. want it. get it.",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    if (kDebugMode) {
      print("Shared pref called");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? initScreen = await prefs.getInt('initScreen');
    await prefs.setInt('initScreen', 1);
    if (kDebugMode) {
      print('initScreen ${initScreen}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: PageView.builder(
          itemCount: screens.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  color: index % 2 == 0 ? Colors.black : Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'WalldeX',
                        style: GoogleFonts.majorMonoDisplay(
                          fontSize: 50,
                          fontWeight: FontWeight.normal,
                          color: index % 2 == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        'think it. want it. get it.',
                        style: GoogleFonts.majorMonoDisplay(
                            fontSize: 18, fontWeight: FontWeight.normal,color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 50.0)),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: InkWell(
                    onTap: () async {
                      if (kDebugMode) {
                        print('next $index');
                      }
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20,),
                      decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "explore",
                            style: GoogleFonts.majorMonoDisplay(
                                fontSize: 13, fontWeight: FontWeight.normal,color: Theme.of(context).primaryColor),
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Made with 🤍 by kannan shibu",
                            style: GoogleFonts.majorMonoDisplay(
                                fontSize: 13, fontWeight: FontWeight.normal,color: Theme.of(context).primaryColor),
                          ),

                          // Icon(
                          //   Icons.arrow_forward_sharp,
                          //   color: index % 2 == 0 ? Colors.white : Colors.black,
                          // )
                        ]),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
