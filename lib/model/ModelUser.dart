import 'package:flutter_std/az/az_common.dart';

class ModelUser {
  String SessionID;
  bool Result;
  UserInfoBean UserInfo;
  List<BaseDataListBean> BaseData;
  List<BaseDataSystemListBean> BaseDataSystem;
  List<BaseEmployeeListBean> BaseEmployee;

  String name;

  String password;

  ModelUser(
      {this.SessionID,
      this.Result,
      this.UserInfo,
      this.BaseData,
      this.BaseDataSystem,
      this.BaseEmployee});

  ModelUser.fromJson(Map<String, dynamic> json) {
    this.SessionID = json['SessionID'];
    this.Result = json['Result'];
    this.name = json['name'];
    this.password = json['password'];
    this.UserInfo = UserInfoBean.fromJson(json['UserInfo']);
    this.BaseData = (json['BaseData'] as List) != null
        ? (json['BaseData'] as List)
            .map((i) => BaseDataListBean.fromJson(i))
            .toList()
        : null;
    this.BaseDataSystem = (json['BaseDataSystem'] as List) != null
        ? (json['BaseDataSystem'] as List)
            .map((i) => BaseDataSystemListBean.fromJson(i))
            .toList()
        : null;
    this.BaseEmployee = (json['BaseEmployee'] as List) != null
        ? (json['BaseEmployee'] as List)
            .map((i) => BaseEmployeeListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SessionID'] = this.SessionID;
    data['Result'] = this.Result;
    data['password'] = this.password;
    data['name'] = this.name;
    data['UserInfo'] = this.UserInfo.toJson();
    data['BaseData'] = this.BaseData != null
        ? this.BaseData.map((i) => i.toJson()).toList()
        : null;
    data['BaseDataSystem'] = this.BaseDataSystem != null
        ? this.BaseDataSystem.map((i) => i.toJson()).toList()
        : null;
    data['BaseEmployee'] = this.BaseEmployee != null
        ? this.BaseEmployee.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class UserInfoBean {
  String EmpName;
  String EmpDepName;
  String EmpTel;
  String EmpJob;
  String EmpHead;
  String EmpNote;
  String EmpMEID;
  int EmpID;
  int EmpDepID;
  bool isLock = false;

  UserInfoBean(
      {this.EmpName,
      this.EmpDepName,
      this.EmpTel,
      this.EmpJob,
      this.EmpHead,
      this.EmpNote,
      this.EmpMEID,
      this.EmpID,
      this.isLock,
      this.EmpDepID});

  UserInfoBean.fromJson(Map<String, dynamic> json) {
    this.EmpName = json['EmpName'];
    this.EmpDepName = json['EmpDepName'];
    this.EmpTel = json['EmpTel'];
    this.isLock = json['isLock'];
    this.EmpJob = json['EmpJob'];
    this.EmpHead = json['EmpHead'];
    this.EmpNote = json['EmpNote'];
    this.EmpMEID = json['EmpMEID'];
    this.EmpID = json['EmpID'];
    this.EmpDepID = json['EmpDepID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpName'] = this.EmpName;
    data['EmpDepName'] = this.EmpDepName;
    data['EmpTel'] = this.EmpTel;
    data['EmpJob'] = this.EmpJob;
    data['EmpHead'] = this.EmpHead;
    data['EmpNote'] = this.EmpNote;
    data['isLock'] = this.isLock;
    data['EmpMEID'] = this.EmpMEID;
    data['EmpID'] = this.EmpID;
    data['EmpDepID'] = this.EmpDepID;
    return data;
  }
}

class BaseDataListBean {
  String BaseName;
  String BaseOrder;
  String BaseNameEng;
  int BaseID;

  BaseDataListBean(
      {this.BaseName, this.BaseOrder, this.BaseNameEng, this.BaseID});

  BaseDataListBean.fromJson(Map<String, dynamic> json) {
    this.BaseName = json['BaseName'];
    this.BaseOrder = json['BaseOrder'];
    this.BaseNameEng = json['BaseNameEng'];
    this.BaseID = json['BaseID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BaseName'] = this.BaseName;
    data['BaseOrder'] = this.BaseOrder;
    data['BaseNameEng'] = this.BaseNameEng;
    data['BaseID'] = this.BaseID;
    return data;
  }
}

class BaseDataSystemListBean {
  String BaseName;
  String BaseOrder;
  String BaseNameEng;
  int BaseID;

  BaseDataSystemListBean(
      {this.BaseName, this.BaseOrder, this.BaseNameEng, this.BaseID});

  BaseDataSystemListBean.fromJson(Map<String, dynamic> json) {
    this.BaseName = json['BaseName'];
    this.BaseOrder = json['BaseOrder'];
    this.BaseNameEng = json['BaseNameEng'];
    this.BaseID = json['BaseID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BaseName'] = this.BaseName;
    data['BaseOrder'] = this.BaseOrder;
    data['BaseNameEng'] = this.BaseNameEng;
    data['BaseID'] = this.BaseID;
    return data;
  }
}

class BaseEmployeeListBean extends ISuspensionBean {
  String EmpName;
  String EmpDepName;
  String EmpHead;
  String EmpTel;
  String EmpTelNX;
  String EmpTelWX;
  String EmpTitle;
  String EmpNote;
  int EmpID;
  int EmpOrder;
  int EmpDepID;
  String tagIndex;
  bool isChecked;

  BaseEmployeeListBean(
      {this.EmpName,
      this.EmpDepName,
      this.EmpHead,
      this.EmpTel,
      this.EmpTelNX,
      this.EmpTelWX,
      this.EmpTitle,
      this.EmpNote,
      this.EmpID,
      this.EmpOrder,
      this.EmpDepID});

  BaseEmployeeListBean.fromJson(Map<String, dynamic> json) {
    this.EmpName = json['EmpName'];
    this.EmpDepName = json['EmpDepName'];
    this.EmpHead = json['EmpHead'];
    this.EmpTel = json['EmpTel'];
    this.EmpTelNX = json['EmpTelNX'];
    this.EmpTelWX = json['EmpTelWX'];
    this.EmpTitle = json['EmpTitle'];
    this.EmpNote = json['EmpNote'];
    this.EmpID = json['EmpID'];
    this.EmpOrder = json['EmpOrder'];
    this.EmpDepID = json['EmpDepID'];
    this.isChecked = json['isChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmpName'] = this.EmpName;
    data['EmpDepName'] = this.EmpDepName;
    data['EmpHead'] = this.EmpHead;
    data['EmpTel'] = this.EmpTel;
    data['EmpTelNX'] = this.EmpTelNX;
    data['EmpTelWX'] = this.EmpTelWX;
    data['EmpTitle'] = this.EmpTitle;
    data['EmpNote'] = this.EmpNote;
    data['EmpID'] = this.EmpID;
    data['EmpOrder'] = this.EmpOrder;
    data['EmpDepID'] = this.EmpDepID;
    data['isChecked'] = this.isChecked;
    return data;
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}
