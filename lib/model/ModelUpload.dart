class ModelUpload {
  String message;
  bool success;
  int code;
  DataBean data;

  ModelUpload({this.message, this.success, this.code, this.data});

  ModelUpload.fromJson(Map<String, dynamic> json) {    
    this.message = json['message'];
    this.success = json['success'];
    this.code = json['code'];
    this.data = DataBean.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['code'] = this.code;
    data['data'] = this.data.toJson();
    return data;
  }

}

class DataBean {
  String fileId;
  String filePath;
  String fileType;
  String fileName;
  int fileSize;

  DataBean({this.fileId, this.filePath, this.fileType, this.fileName, this.fileSize});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.fileId = json['fileId'];
    this.filePath = json['filePath'];
    this.fileType = json['fileType'];
    this.fileName = json['fileName'];
    this.fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['filePath'] = this.filePath;
    data['fileType'] = this.fileType;
    data['fileName'] = this.fileName;
    data['fileSize'] = this.fileSize;
    return data;
  }
}
