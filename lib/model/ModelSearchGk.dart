class ModelSearchGk {
  bool isGroup;
  List<ListListBean> list;

  ModelSearchGk({this.isGroup, this.list});

  ModelSearchGk.fromJson(Map<String, dynamic> json) {    
    this.isGroup = json['isGroup'];
    this.list = (json['list'] as List)!=null?(json['list'] as List).map((i) => ListListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isGroup'] = this.isGroup;
    data['list'] = this.list != null?this.list.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class ListListBean {
  String Key;
  String Contract;
  String Value;

  ListListBean({this.Key, this.Contract, this.Value});

  ListListBean.fromJson(Map<String, dynamic> json) {    
    this.Key = json['Key'];
    this.Contract = json['Contract'];
    this.Value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.Key;
    data['Contract'] = this.Contract;
    data['Value'] = this.Value;
    return data;
  }
}
