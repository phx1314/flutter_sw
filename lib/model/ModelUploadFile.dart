class ModelUploadFile {
  String RefTable;
  String Method;
  String type;

  ModelUploadFile({this.RefTable, this.Method, this.type});

  ModelUploadFile.fromJson(Map<String, dynamic> json) {    
    this.RefTable = json['RefTable'];
    this.Method = json['Method'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefTable'] = this.RefTable;
    data['Method'] = this.Method;
    data['type'] = this.type;
    return data;
  }

}
