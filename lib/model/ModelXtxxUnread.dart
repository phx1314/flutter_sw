class ModelXtxxUnread {
  bool Result;
  int Total;

  ModelXtxxUnread({this.Result, this.Total});

  ModelXtxxUnread.fromJson(Map<String, dynamic> json) {    
    this.Result = json['Result'];
    this.Total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.Result;
    data['Total'] = this.Total;
    return data;
  }

}
