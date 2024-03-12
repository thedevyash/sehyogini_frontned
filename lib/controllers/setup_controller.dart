import 'package:get/get.dart';
import 'package:sehyogini_frontned/Screens/homeScreen.dart';
import 'package:sehyogini_frontned/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString token = "".obs;
  RxBool isRecruiter = false.obs;
  late SharedPreferences _prefs;
  var route;

  @override
  void onInit() {
    setup();
    super.onInit();
  }

  setup() async {
    await SharedPreferences.getInstance().then((value) {
      _prefs = value;
      isLoggedIn.value = _prefs.getBool('isLoggedIn') ?? false;
      token.value = _prefs.getString('token') ?? "";
      isRecruiter.value = _prefs.getBool('isRecruiter') ?? false;
    });

    route = isLoggedIn.value ? const HomeScreen() : const OnboardingScreen();
  }
}
