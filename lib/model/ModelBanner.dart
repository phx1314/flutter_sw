class ModelBanner {
  int total;
  List<RowsListBean> rows;

  ModelBanner({this.total, this.rows});

  ModelBanner.fromJson(Map<String, dynamic> json) {    
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
  String NewsTitle;
  String CreationTime;
  String CreatorEmpName;
  String NewsImage;
  int Id;
  int CreatorEmpId;

  RowsListBean({this.NewsTitle, this.CreationTime, this.CreatorEmpName, this.NewsImage, this.Id, this.CreatorEmpId});

  RowsListBean.fromJson(Map<String, dynamic> json) {    
    this.NewsTitle = json['NewsTitle'];
    this.CreationTime = json['CreationTime'];
    this.CreatorEmpName = json['CreatorEmpName'];
    this.NewsImage = json['NewsImage'];
    this.Id = json['Id'];
    this.CreatorEmpId = json['CreatorEmpId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NewsTitle'] = this.NewsTitle;
    data['CreationTime'] = this.CreationTime;
    data['CreatorEmpName'] = this.CreatorEmpName;
    data['NewsImage'] = this.NewsImage;
    data['Id'] = this.Id;
    data['CreatorEmpId'] = this.CreatorEmpId;
    return data;
  }
}
