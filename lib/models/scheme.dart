class schemeModel {
  String? schemeName;
  String? schemeDescription;
  String? url;
  String? benefits;
  String? icon;
  String? ministryName;

  schemeModel(
      {this.schemeName,
      this.schemeDescription,
      this.url,
      this.benefits,
      this.icon,
      this.ministryName});

  schemeModel.fromJson(Map<String, dynamic> json) {
    schemeName = json['scheme_name'];
    schemeDescription = json['scheme_description'];
    url = json['url'];
    benefits = json['benefits'];
    icon = json['icon'];
    ministryName = json['ministry_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_name'] = this.schemeName;
    data['scheme_desription'] = this.schemeDescription;
    data['url'] = this.url;
    data['benefits'] = this.benefits;
    data['icon'] = this.icon;
    data['ministry_name'] = this.ministryName;
    return data;
  }
}
