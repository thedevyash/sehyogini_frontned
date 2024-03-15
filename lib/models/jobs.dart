class JobModel {
  String? jobtitle;
  String? company;
  String? jobcategory;
  List<String>? applications;
  String? description;
  Map? details;
  String? sId;

  JobModel(
      {this.jobtitle,
      this.company,
      this.jobcategory,
      this.applications,
      this.description,
      this.details,
      this.sId});

  JobModel.fromJson(Map<String, dynamic> json) {
    jobtitle = json['jobtitle'];
    company = json['company'];
    jobcategory = json['jobcategory'];
    applications = json['applications'].cast<String>();
    description = json['description'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobtitle'] = this.jobtitle;
    data['company'] = this.company;
    data['jobcategory'] = this.jobcategory;
    data['applications'] = this.applications;
    data['description'] = this.description;
    data['details'] = this.details;
    data['_id'] = this.sId;
    return data;
  }
}
