class ModelYjDetail {
  ModelBean model;
  String SendEmp;
  String SendEmpID;

  ModelYjDetail({this.model, this.SendEmp, this.SendEmpID, this.AttachData});

  ModelYjDetail.fromJson(Map<String, dynamic> json) {
    this.model = ModelBean.fromJson(json['model']);
    this.SendEmp = json['SendEmp'];
    this.SendEmpID = json['SendEmpID'];
    this.AttachData = (json['AttachData'] as List) != null
        ? (json['AttachData'] as List)
            .map((i) => AttachDataListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model.toJson();
    data['SendEmp'] = this.SendEmp;
    data['SendEmpID'] = this.SendEmpID;
    data['AttachData'] = this.AttachData != null
        ? this.AttachData.map((i) => i.toJson()).toList()
        : null;
    return data;
  }

  List<AttachDataListBean> AttachData;
}

class AttachDataListBean {
  String FileName;
  String RealName;
  String Size;
  String LastModifiedTime;
  String UploadTime;
  String EmpID;
  String EmpName;

  AttachDataListBean(
      {this.FileName,
      this.RealName,
      this.Size,
      this.LastModifiedTime,
      this.UploadTime,
      this.EmpID,
      this.EmpName});

  AttachDataListBean.fromJson(Map<String, dynamic> json) {
    this.FileName = json['FileName'];
    this.RealName = json['RealName'];
    this.Size = json['Size'];
    this.LastModifiedTime = json['LastModifiedTime'];
    this.UploadTime = json['UploadTime'];
    this.EmpID = json['EmpID'];
    this.EmpName = json['EmpName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.FileName;
    data['RealName'] = this.RealName;
    data['Size'] = this.Size;
    data['LastModifiedTime'] = this.LastModifiedTime;
    data['UploadTime'] = this.UploadTime;
    data['EmpID'] = this.EmpID;
    data['EmpName'] = this.EmpName;
    return data;
  }
}

class ModelBean {
  String MailDate;
  String MailTitle;
  String MailNote;
  String DeletionTime;
  String LastModificationTime;
  String LastModifierEmpName;
  String CreationTime;
  String CreatorEmpName;
  String AgenEmpName;
  String CreatorDepName;
  String DeleterEmpName;
  bool MailIsDelete;
  int Id;
  int MailFlag;
  int MailIsBBC;
  int LastModifierEmpId;
  int CreatorEmpId;
  int AgenEmpId;
  int CreatorDepId;
  int DeleterEmpId;
  int HasAttachs;
  String SendEmp;
  String SendEmpID;

  ModelBean(
      {this.MailDate,
      this.MailTitle,
      this.MailNote,
      this.DeletionTime,
      this.LastModificationTime,
      this.LastModifierEmpName,
      this.CreationTime,
      this.CreatorEmpName,
      this.AgenEmpName,
      this.CreatorDepName,
      this.DeleterEmpName,
      this.MailIsDelete,
      this.Id,
      this.MailFlag,
      this.MailIsBBC,
      this.LastModifierEmpId,
      this.CreatorEmpId,
      this.AgenEmpId,
      this.CreatorDepId,
      this.DeleterEmpId,
      this.HasAttachs});

  ModelBean.fromJson(Map<String, dynamic> json) {
    this.MailDate = json['MailDate'];
    this.MailTitle = json['MailTitle'];
    this.MailNote = json['MailNote'];
    this.DeletionTime = json['DeletionTime'];
    this.LastModificationTime = json['LastModificationTime'];
    this.LastModifierEmpName = json['LastModifierEmpName'];
    this.CreationTime = json['CreationTime'];
    this.CreatorEmpName = json['CreatorEmpName'];
    this.AgenEmpName = json['AgenEmpName'];
    this.CreatorDepName = json['CreatorDepName'];
    this.DeleterEmpName = json['DeleterEmpName'];
    this.MailIsDelete = json['MailIsDelete'];
    this.Id = json['Id'];
    this.MailFlag = json['MailFlag'];
    this.MailIsBBC = json['MailIsBBC'];
    this.LastModifierEmpId = json['LastModifierEmpId'];
    this.CreatorEmpId = json['CreatorEmpId'];
    this.AgenEmpId = json['AgenEmpId'];
    this.CreatorDepId = json['CreatorDepId'];
    this.DeleterEmpId = json['DeleterEmpId'];
    this.HasAttachs = json['HasAttachs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MailDate'] = this.MailDate;
    data['MailTitle'] = this.MailTitle;
    data['MailNote'] = this.MailNote;
    data['DeletionTime'] = this.DeletionTime;
    data['LastModificationTime'] = this.LastModificationTime;
    data['LastModifierEmpName'] = this.LastModifierEmpName;
    data['CreationTime'] = this.CreationTime;
    data['CreatorEmpName'] = this.CreatorEmpName;
    data['AgenEmpName'] = this.AgenEmpName;
    data['CreatorDepName'] = this.CreatorDepName;
    data['DeleterEmpName'] = this.DeleterEmpName;
    data['MailIsDelete'] = this.MailIsDelete;
    data['Id'] = this.Id;
    data['MailFlag'] = this.MailFlag;
    data['MailIsBBC'] = this.MailIsBBC;
    data['LastModifierEmpId'] = this.LastModifierEmpId;
    data['CreatorEmpId'] = this.CreatorEmpId;
    data['AgenEmpId'] = this.AgenEmpId;
    data['CreatorDepId'] = this.CreatorDepId;
    data['DeleterEmpId'] = this.DeleterEmpId;
    data['HasAttachs'] = this.HasAttachs;
    return data;
  }
}
