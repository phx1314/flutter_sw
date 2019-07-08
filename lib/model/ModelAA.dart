class ModelAA {
  bool Result;
  int ProjectAmount;
  int OAAmount;
  int ExchRec;

  ModelAA({this.Result, this.ProjectAmount, this.OAAmount, this.ExchRec});

  ModelAA.fromJson(Map<String, dynamic> json) {    
    this.Result = json['Result'];
    this.ProjectAmount = json['ProjectAmount'];
    this.OAAmount = json['OAAmount'];
    this.ExchRec = json['ExchRec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.Result;
    data['ProjectAmount'] = this.ProjectAmount;
    data['OAAmount'] = this.OAAmount;
    data['ExchRec'] = this.ExchRec;
    return data;
  }

}
