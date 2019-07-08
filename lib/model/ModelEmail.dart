class ModelEmail {
  int total;
  List<RowsListBean> rows;

  ModelEmail({this.total, this.rows});

  ModelEmail.fromJson(Map<String, dynamic> json) {    
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
  String MailFlag;
  String MailDate;
  String MailTitle;
  String MailNote;
  String MailEmpName;
  String MailEmpId;
  bool MailIsRead;
  int Id;
  int MailID;
  int HasAttachs;

  RowsListBean({this.MailFlag, this.MailDate, this.MailTitle, this.MailNote, this.MailEmpName, this.MailEmpId, this.MailIsRead, this.Id, this.MailID, this.HasAttachs});

  RowsListBean.fromJson(Map<String, dynamic> json) {    
    this.MailFlag = json['MailFlag'];
    this.MailDate = json['MailDate'];
    this.MailTitle = json['MailTitle'];
    this.MailNote = json['MailNote'];
    this.MailEmpName = json['MailEmpName'];
    this.MailEmpId = json['MailEmpId'];
    this.MailIsRead = json['MailIsRead'];
    this.Id = json['Id'];
    this.MailID = json['MailID'];
    this.HasAttachs = json['HasAttachs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MailFlag'] = this.MailFlag;
    data['MailDate'] = this.MailDate;
    data['MailTitle'] = this.MailTitle;
    data['MailNote'] = this.MailNote;
    data['MailEmpName'] = this.MailEmpName;
    data['MailEmpId'] = this.MailEmpId;
    data['MailIsRead'] = this.MailIsRead;
    data['Id'] = this.Id;
    data['MailID'] = this.MailID;
    data['HasAttachs'] = this.HasAttachs;
    return data;
  }
}
