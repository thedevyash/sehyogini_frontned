import 'dart:convert';

import 'package:get/get.dart';
import 'package:sehyogini_frontned/models/jobs.dart';
import 'package:sehyogini_frontned/models/posts.dart';
import 'package:http/http.dart' as http;
import 'package:sehyogini_frontned/utils/url.dart';

class GetJobsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<JobModel> myModelTech = <JobModel>[].obs;
  RxList<JobModel> myModelFree = <JobModel>[].obs;
  RxList<JobModel> myModelCraft = <JobModel>[].obs;
  RxList<JobModel> myModelPhil = <JobModel>[].obs;
  RxList<JobModel> myModelCare = <JobModel>[].obs;
  @override
  onInit() {
    super.onInit();
    getJob();
  }

  Future<bool> getJob() async {
    isLoading(true);
    update();

    try {
      final response = await http.get(
        Uri.parse(URL.getJobs),
        headers: {"Content-Type": "application/json", 'Accept': '*/*'},
      );

      // print("get posts called");

      // print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // print(data);
        myModelTech.value = (data["technology"] as List)
            .map((i) => JobModel.fromJson(i))
            .toList();
        myModelCraft.value = (data["craftsmanship"] as List)
            .map((i) => JobModel.fromJson(i))
            .toList();
        myModelPhil.value = (data["philanthropy"] as List)
            .map((i) => JobModel.fromJson(i))
            .toList();
        myModelCare.value = (data["caregiving"] as List)
            .map((i) => JobModel.fromJson(i))
            .toList();
        myModelFree.value = (data["freelance"] as List)
            .map((i) => JobModel.fromJson(i))
            .toList();

        return true;
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
      update();
      return false;
    }
  }
}
