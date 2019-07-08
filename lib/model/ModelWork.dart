import 'ModelMenuConfig.dart';

class ModelWork {
  List<ModelWorkBean> rows;

  ModelWork({this.rows});

  ModelWork.fromJson(Map<String, dynamic> json) {
    this.rows = (json['rows'] as List) != null
        ? (json['rows'] as List).map((i) => ModelWorkBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rows'] =
        this.rows != null ? this.rows.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class ModelWorkBean {
  String orderCode;
  String text;
  String MenuNameEng;
  ModelMenuConfig mModelMenuConfig;
  String attributes;
  String iconCls;
  String MenuImageUrl;
  String MenuMobileConfig;
  bool isMust;
  bool isSecond;
  int id;
  int parentID;
  List<ModelWorkBean> children;

  ModelWorkBean(
      {this.orderCode,
      this.text,
      this.MenuNameEng,
      this.attributes,
      this.iconCls,
      this.MenuImageUrl,
      this.MenuMobileConfig,
      this.isMust,
      this.isSecond,
      this.id,
      this.parentID,
      this.children});

  ModelWorkBean.fromJson(Map<String, dynamic> json) {
    this.orderCode = json['orderCode'];
    this.text = json['text'];
    this.MenuNameEng = json['MenuNameEng'];
    this.attributes = json['attributes'];
    this.iconCls = json['iconCls'];
    this.MenuImageUrl = json['MenuImageUrl'];
    this.MenuMobileConfig = json['MenuMobileConfig'];
    this.isMust = json['isMust'];
    this.isSecond = json['isSecond'];
    this.id = json['id'];
    this.parentID = json['parentID'];
    this.children = (json['children'] as List) != null
        ? (json['children'] as List)
            .map((i) => ModelWorkBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderCode'] = this.orderCode;
    data['text'] = this.text;
    data['MenuNameEng'] = this.MenuNameEng;
    data['attributes'] = this.attributes;
    data['iconCls'] = this.iconCls;
    data['MenuImageUrl'] = this.MenuImageUrl;
    data['MenuMobileConfig'] = this.MenuMobileConfig;
    data['isMust'] = this.isMust;
    data['isSecond'] = this.isSecond;
    data['id'] = this.id;
    data['parentID'] = this.parentID;
    data['children'] = this.children != null
        ? this.children.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

