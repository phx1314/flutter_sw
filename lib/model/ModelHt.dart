class ModelHt {
  int total;
  List<RowsListBean> rows;

  ModelHt({this.total, this.rows});

  ModelHt.fromJson(Map<String, dynamic> json) {
    this.total = json['total'];
    this.rows = (json['rows'] as List) != null
        ? (json['rows'] as List).map((i) => RowsListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['rows'] =
        this.rows != null ? this.rows.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class RowsListBean {
  String ConNumber;
  String ConName;
  String ConDate;
  String ConNote;
  String CreateTime;
  String DeleteTime;
  String ConTypeName;
  String ConEmpName;
  String ConRespEmpName;
  String ConAddressShow;
  String CustName;
  double ConFee;
  double CostFee;
  double YSK;
  double KSK;
  double KPE;
  int Id;
  int ProjId;
  int ConType;
  int ConEmpID;
  int ConRespEmpID;
  int ConAddress;
  int IsFinish;
  int CreateBy;
  int DeleteBy;
  int CustId;
  int rowNumber;
  String FlowSummary;

  RowsListBean(
      {this.ConNumber,
      this.FlowSummary,
      this.ConName,
      this.ConDate,
      this.ConNote,
      this.CreateTime,
      this.DeleteTime,
      this.ConTypeName,
      this.ConEmpName,
      this.ConRespEmpName,
      this.ConAddressShow,
      this.CustName,
      this.ConFee,
      this.CostFee,
      this.YSK,
      this.KSK,
      this.KPE,
      this.Id,
      this.ProjId,
      this.ConType,
      this.ConEmpID,
      this.ConRespEmpID,
      this.ConAddress,
      this.IsFinish,
      this.CreateBy,
      this.DeleteBy,
      this.CustId,
      this.rowNumber});

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.ConNumber = json['ConNumber'];
    this.ConName = json['ConName'];
    this.ConDate = json['ConDate'];
    this.ConNote = json['ConNote'];
    this.CreateTime = json['CreateTime'];
    this.DeleteTime = json['DeleteTime'];
    this.ConTypeName = json['ConTypeName'];
    this.ConEmpName = json['ConEmpName'];
    this.ConRespEmpName = json['ConRespEmpName'];
    this.ConAddressShow = json['ConAddressShow'];
    this.CustName = json['CustName'];
    this.ConFee = json['ConFee'];
    this.CostFee = json['CostFee'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.YSK = json['YSK'];
    this.KSK = json['KSK'];
    this.KPE = json['KPE'];
    this.Id = json['Id'];
    this.ProjId = json['ProjId'];
    this.ConType = json['ConType'];
    this.ConEmpID = json['ConEmpID'];
    this.ConRespEmpID = json['ConRespEmpID'];
    this.ConAddress = json['ConAddress'];
    this.IsFinish = json['IsFinish'];
    this.CreateBy = json['CreateBy'];
    this.DeleteBy = json['DeleteBy'];
    this.CustId = json['CustId'];
    this.rowNumber = json['row_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ConNumber'] = this.ConNumber;
    data['ConName'] = this.ConName;
    data['ConDate'] = this.ConDate;
    data['ConNote'] = this.ConNote;
    data['CreateTime'] = this.CreateTime;
    data['DeleteTime'] = this.DeleteTime;
    data['ConTypeName'] = this.ConTypeName;
    data['ConEmpName'] = this.ConEmpName;
    data['ConRespEmpName'] = this.ConRespEmpName;
    data['ConAddressShow'] = this.ConAddressShow;
    data['CustName'] = this.CustName;
    data['ConFee'] = this.ConFee;
    data['CostFee'] = this.CostFee;
    data['YSK'] = this.YSK;
    data['KSK'] = this.KSK;
    data['KPE'] = this.KPE;
    data['Id'] = this.Id;
    data['ProjId'] = this.ProjId;
    data['ConType'] = this.ConType;
    data['ConEmpID'] = this.ConEmpID;
    data['ConRespEmpID'] = this.ConRespEmpID;
    data['ConAddress'] = this.ConAddress;
    data['IsFinish'] = this.IsFinish;
    data['CreateBy'] = this.CreateBy;
    data['DeleteBy'] = this.DeleteBy;
    data['CustId'] = this.CustId;
    data['row_number'] = this.rowNumber;
    return data;
  }
}
