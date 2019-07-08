class ModelSystemList {
  int total;
  List<RowsListBean> rows;

  ModelSystemList({this.total, this.rows});

  ModelSystemList.fromJson(Map<String, dynamic> json) {    
    this.total = json['total'];
    this.rows = (json['rows'] as List)!=null?(json['rows'] as List).map((i) => RowsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['rows'] = this.rows != null?this.rows.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class RowsListBean {
  String MessReadEmpName;
  String MessReadDate;
  String MessTitle;
  String MessLinkTitle;
  String MessLinkUrl;
  String MessDate;
  String MessEmpName;
  bool MessReadIsDeleted;
  bool MessIsDeleted;
  bool MessIsSystem;
  int Id;
  int MessReadEmpId;
  int MessEmpId;
  int MessDialogWidth;
  int MessDialogHeight;

  RowsListBean({this.MessReadEmpName, this.MessReadDate, this.MessTitle, this.MessLinkTitle, this.MessLinkUrl, this.MessDate, this.MessEmpName, this.MessReadIsDeleted, this.MessIsDeleted, this.MessIsSystem, this.Id, this.MessReadEmpId, this.MessEmpId, this.MessDialogWidth, this.MessDialogHeight});

  RowsListBean.fromJson(Map<String, dynamic> json) {    
    this.MessReadEmpName = json['MessReadEmpName'];
    this.MessReadDate = json['MessReadDate'];
    this.MessTitle = json['MessTitle'];
    this.MessLinkTitle = json['MessLinkTitle'];
    this.MessLinkUrl = json['MessLinkUrl'];
    this.MessDate = json['MessDate'];
    this.MessEmpName = json['MessEmpName'];
    this.MessReadIsDeleted = json['MessReadIsDeleted'];
    this.MessIsDeleted = json['MessIsDeleted'];
    this.MessIsSystem = json['MessIsSystem'];
    this.Id = json['Id'];
    this.MessReadEmpId = json['MessReadEmpId'];
    this.MessEmpId = json['MessEmpId'];
    this.MessDialogWidth = json['MessDialogWidth'];
    this.MessDialogHeight = json['MessDialogHeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MessReadEmpName'] = this.MessReadEmpName;
    data['MessReadDate'] = this.MessReadDate;
    data['MessTitle'] = this.MessTitle;
    data['MessLinkTitle'] = this.MessLinkTitle;
    data['MessLinkUrl'] = this.MessLinkUrl;
    data['MessDate'] = this.MessDate;
    data['MessEmpName'] = this.MessEmpName;
    data['MessReadIsDeleted'] = this.MessReadIsDeleted;
    data['MessIsDeleted'] = this.MessIsDeleted;
    data['MessIsSystem'] = this.MessIsSystem;
    data['Id'] = this.Id;
    data['MessReadEmpId'] = this.MessReadEmpId;
    data['MessEmpId'] = this.MessEmpId;
    data['MessDialogWidth'] = this.MessDialogWidth;
    data['MessDialogHeight'] = this.MessDialogHeight;
    return data;
  }
}
