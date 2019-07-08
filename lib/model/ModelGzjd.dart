class ModelGzjd {
  int total;
  List<RowsListBean> rows;

  ModelGzjd({this.total, this.rows});

  ModelGzjd.fromJson(Map<String, dynamic> json) {    
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
  String ExeActionDate;
  String ExeNote;
  String ExeEmpName;
  String ExeArgEmpName;
  String NewExeActionDate;
  String ActionName;
  String FlowNodeName;
  int Id;
  int FlowID;
  int FlowNodeID;
  int ExeActionID;
  int ExeArgEmpId;
  int ExeEmpId;
  int rowNumber;

  RowsListBean({this.ExeActionDate, this.ExeNote, this.ExeEmpName, this.ExeArgEmpName, this.NewExeActionDate, this.ActionName, this.FlowNodeName, this.Id, this.FlowID, this.FlowNodeID, this.ExeActionID, this.ExeArgEmpId, this.ExeEmpId, this.rowNumber});

  RowsListBean.fromJson(Map<String, dynamic> json) {    
    this.ExeActionDate = json['ExeActionDate'];
    this.ExeNote = json['ExeNote'];
    this.ExeEmpName = json['ExeEmpName'];
    this.ExeArgEmpName = json['ExeArgEmpName'];
    this.NewExeActionDate = json['NewExeActionDate'];
    this.ActionName = json['ActionName'];
    this.FlowNodeName = json['FlowNodeName'];
    this.Id = json['Id'];
    this.FlowID = json['FlowID'];
    this.FlowNodeID = json['FlowNodeID'];
    this.ExeActionID = json['ExeActionID'];
    this.ExeArgEmpId = json['ExeArgEmpId'];
    this.ExeEmpId = json['ExeEmpId'];
    this.rowNumber = json['row_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExeActionDate'] = this.ExeActionDate;
    data['ExeNote'] = this.ExeNote;
    data['ExeEmpName'] = this.ExeEmpName;
    data['ExeArgEmpName'] = this.ExeArgEmpName;
    data['NewExeActionDate'] = this.NewExeActionDate;
    data['ActionName'] = this.ActionName;
    data['FlowNodeName'] = this.FlowNodeName;
    data['Id'] = this.Id;
    data['FlowID'] = this.FlowID;
    data['FlowNodeID'] = this.FlowNodeID;
    data['ExeActionID'] = this.ExeActionID;
    data['ExeArgEmpId'] = this.ExeArgEmpId;
    data['ExeEmpId'] = this.ExeEmpId;
    data['row_number'] = this.rowNumber;
    return data;
  }
}
