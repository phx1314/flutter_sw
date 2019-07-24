class ModelFileNum {
  String refTable;
  int fileNumber;

  ModelFileNum({this.refTable, this.fileNumber});

  ModelFileNum.fromJson(Map<String, dynamic> json) {    
    this.refTable = json['refTable'];
    this.fileNumber = json['fileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refTable'] = this.refTable;
    data['fileNumber'] = this.fileNumber;
    return data;
  }

}
