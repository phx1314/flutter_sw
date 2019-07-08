class ModelVersion {
  String message;
  int code;
  DataBean data;

  ModelVersion({this.message, this.code, this.data});

  ModelVersion.fromJson(Map<String, dynamic> json) {    
    this.message = json['message'];
    this.code = json['code'];
    this.data = DataBean.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['data'] = this.data.toJson();
    return data;
  }

}

class DataBean {
  String buildBuildVersion;
  String forceUpdateVersion;
  String forceUpdateVersionNo;
  String downloadURL;
  String buildVersionNo;
  String buildVersion;
  String buildShortcutUrl;
  String buildUpdateDescription;
  bool buildHaveNewVersion;

  DataBean({this.buildBuildVersion, this.forceUpdateVersion, this.forceUpdateVersionNo, this.downloadURL, this.buildVersionNo, this.buildVersion, this.buildShortcutUrl, this.buildUpdateDescription, this.buildHaveNewVersion});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.buildBuildVersion = json['buildBuildVersion'];
    this.forceUpdateVersion = json['forceUpdateVersion'];
    this.forceUpdateVersionNo = json['forceUpdateVersionNo'];
    this.downloadURL = json['downloadURL'];
    this.buildVersionNo = json['buildVersionNo'];
    this.buildVersion = json['buildVersion'];
    this.buildShortcutUrl = json['buildShortcutUrl'];
    this.buildUpdateDescription = json['buildUpdateDescription'];
    this.buildHaveNewVersion = json['buildHaveNewVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buildBuildVersion'] = this.buildBuildVersion;
    data['forceUpdateVersion'] = this.forceUpdateVersion;
    data['forceUpdateVersionNo'] = this.forceUpdateVersionNo;
    data['downloadURL'] = this.downloadURL;
    data['buildVersionNo'] = this.buildVersionNo;
    data['buildVersion'] = this.buildVersion;
    data['buildShortcutUrl'] = this.buildShortcutUrl;
    data['buildUpdateDescription'] = this.buildUpdateDescription;
    data['buildHaveNewVersion'] = this.buildHaveNewVersion;
    return data;
  }
}
