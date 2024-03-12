import 'package:get/get.dart';

class bottomController extends GetxController {
  RxInt currentindex = 0.obs;
  void setvalue(int index) {
    currentindex.value = index;
    update();
  }
}
