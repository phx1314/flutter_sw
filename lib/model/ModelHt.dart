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
  String ProjName;
  String ProjNumber;
  int Id;
  String FlowSummary;

  RowsListBean(
      {
      this.FlowSummary,
      this.Id,
      this.ProjName,
      this.ProjNumber,
       });

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.ProjNumber = json['ProjNumber'];
    this.ProjName = json['ProjName'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.Id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjNumber'] = this.ProjNumber;
    data['ProjName'] = this.ProjName;
    data['Id'] = this.Id;
    return data;
  }
}
