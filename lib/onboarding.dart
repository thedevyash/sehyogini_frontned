import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sehyogini_frontned/OnboardingScreens/signIn.dart';
import 'package:sehyogini_frontned/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  var tap = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: PageView(
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              setState(() {
                tap = value;
              });
            },
            controller: _controller,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/onboard.svg"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Join our vibrant community, share experiences, and grow together!",
                        style: GoogleFonts.poppins(
                            color: colors.purpAcc,
                            fontSize: 22,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/onboard.svg"),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Navigate seamlessly through features like mentorship, job board, and skill-building modules.",
                          style: GoogleFonts.poppins(
                              color: colors.purpAcc,
                              fontSize: 22,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )),
              ),
              Container(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/onboard.svg"),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Start your journey towards empowerment and success with our user-friendly platform.",
                          style: GoogleFonts.poppins(
                              color: colors.purpAcc,
                              fontSize: 22,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.white),
        constraints: BoxConstraints(minHeight: 80),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () => Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => SignInScreen())),
                child: Text(
                  "Skip",
                  style: GoogleFonts.poppins(
                      color: colors.purp,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
            SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                    dotColor: colors.purpAcc, activeDotColor: colors.purp)),
            IconButton(
                onPressed: tap < 2
                    ? () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.decelerate);

                        setState(() {
                          tap++;
                        });
                      }
                    : () {
                        tap = 0;
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => SignInScreen()));
                      },
                icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    ));
  }
}
