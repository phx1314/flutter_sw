class ModelUserDetail {
  String IDs;
  String permission;
  String EmpHead;
  ModelBean model;

  ModelUserDetail({this.IDs, this.permission, this.EmpHead, this.model});

  ModelUserDetail.fromJson(Map<String, dynamic> json) {    
    this.IDs = json['IDs'];
    this.permission = json['permission'];
    this.EmpHead = json['EmpHead'];
    this.model = ModelBean.fromJson(json['model']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDs'] = this.IDs;
    data['permission'] = this.permission;
    data['EmpHead'] = this.EmpHead;
    data['model'] = this.model.toJson();
    return data;
  }

}

class ModelBean {
  String EmpGUId;
  String EmpName;
  String EmpLogin;
  String EmpPassword;
  String SalaryPassword;
  String EmpDepName;
  String EmpBirthDate;
  String EmpTitle;
  String EmpTel;
  String EmpComputer;
  String EmpIPAddress;
  String EmpDisk;
  String EmpThemesName;
  String EmpMenuType;
  String EmpSignUrl;
  String EmpMacAddress;
  String EmpTelNX;
  String EmpTelWX;
  String EmpFJNum;
  String EmpOaMail;
  String EmpComMail;
  String EmpZWAddress;
  String EmpWGAddress;
  String EmpNote;
  String EmpPort;
  String EmpHead;
  String EmpMEID;
  String WxAppOpenId;
  bool EmpIsDeleted;
  bool EmpIsAgent;
  bool EmpIsBind;
  double PayManageCoeff;
  double PaySkillCoeff;
  int EmpID;
  int EmpDepID;
  int DepOrder;
  int EmpOrder;
  int EmpPageSize;
  int EmpIsSub;

  ModelBean({this.EmpGUId, this.EmpName, this.EmpLogin, this.EmpPassword, this.SalaryPassword, this.EmpDepName, this.EmpBirthDate, this.EmpTitle, this.EmpTel, this.EmpComputer, this.EmpIPAddress, this.EmpDisk, this.EmpThemesName, this.EmpMenuType, this.EmpSignUrl, this.EmpMacAddress, this.EmpTelNX, this.EmpTelWX, this.EmpFJNum, this.EmpOaMail, this.EmpComMail, this.EmpZWAddress, this.EmpWGAddress, this.EmpNote, this.EmpPort, this.EmpHead, this.EmpMEID, this.WxAppOpenId, this.EmpIsDeleted, this.EmpIsAgent, this.EmpIsBind, this.PayManageCoeff, this.PaySkillCoeff, this.EmpID, this.EmpDepID, this.DepOrder, this.EmpOrder, this.EmpPageSize, this.EmpIsSub});

  ModelBean.fromJson(Map<String, dynamic> json) {    
    this.EmpGUId = json['EmpGUId'];
    this.EmpName = json['EmpName'];
    this.EmpLogin = json['EmpLogin'];
    this.EmpPassword = json['EmpPassword'];
    this.SalaryPassword = json['SalaryPassword'];
    this.EmpDepName = json['EmpDepName'];
    this.EmpBirthDate = json['EmpBirthDate'];
    this.EmpTitle = json['EmpTitle'];
    this.EmpTel = json['EmpTel'];
    this.EmpComputer = json['EmpComputer'];
    this.EmpIPAddress = json['EmpIPAddress'];
    this.EmpDisk = json['EmpDisk'];
    this.EmpThemesName = json['EmpThemesName'];
    this.EmpMenuType = json['EmpMenuType'];
    this.EmpSignUrl = json['EmpSignUrl'];
    this.EmpMacAddress = json['EmpMacAddress'];
    this.EmpTelNX = json['EmpTelNX'];
    this.EmpTelWX = json['EmpTelWX'];
    this.EmpFJNum = json['EmpFJNum'];
    this.EmpOaMail = json['EmpOaMail'];
    this.EmpComMail = json['EmpComMail'];
    this.EmpZWAddress = json['EmpZWAddress'];
    this.EmpWGAddress = json['EmpWGAddress'];
    this.EmpNote = json['EmpNote'];
    this.EmpPort = json['EmpPort'];
    this.EmpHead = json['EmpHead'];
    this.EmpMEID = json['EmpMEID'];
    this.WxAppOpenId = json['WxAppOpenId'];
    this.EmpIsDeleted = json['EmpIsDeleted'];
    this.EmpIsAgent = json['EmpIsAgent'];
    this.EmpIsBind = json['EmpIsBind'];
    this.PayManageCoeff = json['PayManageCoeff'];
    this.PaySkillCoeff = json['PaySkillCoeff'];
    this.EmpID = json['EmpID'];
    this.EmpDepID = json['EmpDepID'];
    this.DepOrder = json['DepOrder'];
    this.EmpOrder = json['EmpOrder'];
    this.EmpPageSize = json['EmpPageSize'];
    this.EmpIsSub = json['EmpIsSub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpGUId'] = this.EmpGUId;
    data['EmpName'] = this.EmpName;
    data['EmpLogin'] = this.EmpLogin;
    data['EmpPassword'] = this.EmpPassword;
    data['SalaryPassword'] = this.SalaryPassword;
    data['EmpDepName'] = this.EmpDepName;
    data['EmpBirthDate'] = this.EmpBirthDate;
    data['EmpTitle'] = this.EmpTitle;
    data['EmpTel'] = this.EmpTel;
    data['EmpComputer'] = this.EmpComputer;
    data['EmpIPAddress'] = this.EmpIPAddress;
    data['EmpDisk'] = this.EmpDisk;
    data['EmpThemesName'] = this.EmpThemesName;
    data['EmpMenuType'] = this.EmpMenuType;
    data['EmpSignUrl'] = this.EmpSignUrl;
    data['EmpMacAddress'] = this.EmpMacAddress;
    data['EmpTelNX'] = this.EmpTelNX;
    data['EmpTelWX'] = this.EmpTelWX;
    data['EmpFJNum'] = this.EmpFJNum;
    data['EmpOaMail'] = this.EmpOaMail;
    data['EmpComMail'] = this.EmpComMail;
    data['EmpZWAddress'] = this.EmpZWAddress;
    data['EmpWGAddress'] = this.EmpWGAddress;
    data['EmpNote'] = this.EmpNote;
    data['EmpPort'] = this.EmpPort;
    data['EmpHead'] = this.EmpHead;
    data['EmpMEID'] = this.EmpMEID;
    data['WxAppOpenId'] = this.WxAppOpenId;
    data['EmpIsDeleted'] = this.EmpIsDeleted;
    data['EmpIsAgent'] = this.EmpIsAgent;
    data['EmpIsBind'] = this.EmpIsBind;
    data['PayManageCoeff'] = this.PayManageCoeff;
    data['PaySkillCoeff'] = this.PaySkillCoeff;
    data['EmpID'] = this.EmpID;
    data['EmpDepID'] = this.EmpDepID;
    data['DepOrder'] = this.DepOrder;
    data['EmpOrder'] = this.EmpOrder;
    data['EmpPageSize'] = this.EmpPageSize;
    data['EmpIsSub'] = this.EmpIsSub;
    return data;
  }
}
