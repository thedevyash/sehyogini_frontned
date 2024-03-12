import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sehyogini_frontned/controllers/bottom_bar.dart';
import 'package:sehyogini_frontned/onboarding.dart';
import 'package:sehyogini_frontned/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bottomController navbarController = Get.put(bottomController());

  _launchURL() async {
    final Uri url = Uri.parse('https://github.com/thedevyash');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
                  decoration: BoxDecoration(
                      color: colors.purp,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(20, 20),
                          bottomRight: Radius.circular(30))),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Version 1.0",
                          style: GoogleFonts.poppins(fontSize: 23)),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: _launchURL,
                        child: Text("Github",
                            style: GoogleFonts.poppins(
                                fontSize: 23, color: colors.purp)),
                      )
                    ],
                  ),
                )
              ]),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        body: TextButton(
            onPressed: () async {
              final SharedPreferences prefs = await _prefs;
              await prefs.setBool("isLoggedIn", false);
              Get.offAll(OnboardingScreen());
            },
            child: Text("logout")),
        bottomNavigationBar: Obx(() => CurvedNavigationBar(
                index: navbarController.currentindex.value,
                color: colors.purpLight,
                animationDuration: Duration(milliseconds: 250),
                backgroundColor: Colors.white,
                onTap: (value) => navbarController.setvalue(value),
                buttonBackgroundColor: colors.purpAcc,
                height: 60,
                items: [
                  Icon(
                    CupertinoIcons.house_alt_fill,
                    size: 30,
                  ),
                  Icon(
                    Icons.people,
                    size: 30,
                  ),
                  Icon(
                    CupertinoIcons.chat_bubble,
                    size: 30,
                  ),
                  Icon(
                    CupertinoIcons.square_list,
                    size: 30,
                  ),
                  Icon(
                    CupertinoIcons.settings_solid,
                    size: 30,
                  ),
                ])));
  }
}
