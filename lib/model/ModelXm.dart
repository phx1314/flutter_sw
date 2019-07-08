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
  String FlowSummary;


  RowsListBean(
      {
      this.ProjName,
      this.Id,
      this.FlowSummary,
       });

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.ProjName = json['ProjName'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.Id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjName'] = this.ProjName;
    data['Id'] = this.Id;
    return data;
  }
}
