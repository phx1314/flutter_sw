class ModelXm {
  int total;
  List<RowsListBean> rows;

  ModelXm({this.total, this.rows});

  ModelXm.fromJson(Map<String, dynamic> json) {
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
  var ProjName;

  var Id;

  var ProjId;
  var CustName;
  var DatePlanFinish;
  var LinkMan;
  var LinkManTel;
  var ProjScaleName;
  var ContractInfo;

  var ProjNumber;
  var ProjMarketName;
  String FlowSummary;

  RowsListBean({
    this.ProjName,
    this.Id,
    this.FlowSummary,
    this.ProjNumber,
    this.ProjMarketName,
  });

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.ProjName = json['ProjName'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.Id = json['Id'];
    this.ProjNumber = json['ProjNumber'];
    this.ProjMarketName = json['ProjMarketName'];

    this.ProjId = json['ProjId']??'';
    this.CustName = json['CustName']??'';
    this.DatePlanFinish = json['DatePlanFinish']??'';
    this.LinkMan = json['LinkMan']??'';
    this.LinkManTel = json['LinkManTel']??'';
    this.ProjScaleName = json['ProjScaleName']??'';
    this.ContractInfo = json['ContractInfo']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjName'] = this.ProjName??'';
    data['Id'] = this.Id??'';
    data['ProjNumber'] = this.ProjNumber??'';
    data['ProjMarketName'] = this.ProjMarketName??'';

    data['ProjId'] = this.ProjId??'';
    data['CustName'] = this.CustName??'';
    data['DatePlanFinish'] = this.DatePlanFinish??'';
    data['LinkMan'] = this.LinkMan??'';
    data['LinkManTel'] = this.LinkManTel??'';
    data['ProjScaleName'] = this.ProjScaleName??'';
//    data['ContractInfo'] = this.ContractInfo??'';
    return data;
  }
}
