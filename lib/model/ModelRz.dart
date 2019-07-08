class ModelRz {
  int total;
  List<RowsListBean> rows;

  ModelRz({this.total, this.rows});

  ModelRz.fromJson(Map<String, dynamic> json) {
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
  String EmpName;
  String BaseLogDate;
  String BaseLogIP;
  String BaseLogRefTable;
  String BaseLogRefHTML;
  int BaseLogID;
  int BaseLogEmpID;
  int BaseLogTypeID;
  int BaseLogRefID;
  int LogGrade;

  RowsListBean({this.EmpName, this.BaseLogDate, this.BaseLogIP, this.BaseLogRefTable, this.BaseLogRefHTML, this.BaseLogID, this.BaseLogEmpID, this.BaseLogTypeID, this.BaseLogRefID, this.LogGrade});

  RowsListBean.fromJson(Map<String, dynamic> json) {    
    this.EmpName = json['EmpName'];
    this.BaseLogDate = json['BaseLogDate'];
    this.BaseLogIP = json['BaseLogIP'];
    this.BaseLogRefTable = json['BaseLogRefTable'];
    this.BaseLogRefHTML = json['BaseLogRefHTML'];
    this.BaseLogID = json['BaseLogID'];
    this.BaseLogEmpID = json['BaseLogEmpID'];
    this.BaseLogTypeID = json['BaseLogTypeID'];
    this.BaseLogRefID = json['BaseLogRefID'];
    this.LogGrade = json['LogGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpName'] = this.EmpName;
    data['BaseLogDate'] = this.BaseLogDate;
    data['BaseLogIP'] = this.BaseLogIP;
    data['BaseLogRefTable'] = this.BaseLogRefTable;
    data['BaseLogRefHTML'] = this.BaseLogRefHTML;
    data['BaseLogID'] = this.BaseLogID;
    data['BaseLogEmpID'] = this.BaseLogEmpID;
    data['BaseLogTypeID'] = this.BaseLogTypeID;
    data['BaseLogRefID'] = this.BaseLogRefID;
    data['LogGrade'] = this.LogGrade;
    return data;
  }
}
