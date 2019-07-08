class ModelSearch {
  bool isGroup=false;
  List<ListListBean> list=new List();

  ModelSearch( );

  ModelSearch.fromJson(Map<String, dynamic> json) {
    this.isGroup = json['isGroup'];
    this.list = (json['list'] as List) != null
        ? (json['list'] as List).map((i) => ListListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isGroup'] = this.isGroup;
    data['list'] =
        this.list != null ? this.list.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class ListListBean {
  String Contract = "like";
  String Key;
  String Value;
  String filedType = "Int";

  ListListBean();

  ListListBean.fromJson(Map<String, dynamic> json) {
    this.Contract = json['Contract'];
    this.Key = json['Key'];
    this.Value = json['Value'];
    this.filedType = json['filedType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Contract'] = this.Contract;
    data['Key'] = this.Key;
    data['Value'] = this.Value;
    data['filedType'] = this.filedType;
    return data;
  }
}
