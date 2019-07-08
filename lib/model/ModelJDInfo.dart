class ModelJDInfo {
  String Message;
  String NodeName;
  String AllowEditControls;
  String SignControls;
  String UserName;
  String DepartmentName;
  String ActionUrl;
  String ProgressUrl;
  String DefaultNote;
  String FlowName;
  var FlowRefID;
  String Date;
  String LastNote;
  String SignDatas;
  String AgentEmpName;
  bool Result;
  bool IsFlowFinished;
  bool IsFinished;
  bool IsLastStep;
  bool IsNoteRequired;
  bool IsNew;
  bool IsAllowUndo;
  int UserID;
  int DepartmentID;
  int NextAction;
  int ChangeAction;
  int BackAction;
  int FinishAction;
  int RejectAction;
  int StepOrder;
  int DefaultChoosedStep;
  int FlowID;
  int FlowNodeID;
  int FlowMultiSignID;
  List<NextStepsListBean> NextSteps;

  ModelJDInfo({this.Message, this.NodeName, this.AllowEditControls, this.SignControls, this.UserName, this.DepartmentName, this.ActionUrl, this.ProgressUrl, this.DefaultNote, this.FlowName, this.FlowRefID, this.Date, this.LastNote, this.SignDatas, this.AgentEmpName, this.Result, this.IsFlowFinished, this.IsFinished, this.IsLastStep, this.IsNoteRequired, this.IsNew, this.IsAllowUndo, this.UserID, this.DepartmentID, this.NextAction, this.ChangeAction, this.BackAction, this.FinishAction, this.RejectAction, this.StepOrder, this.DefaultChoosedStep, this.FlowID, this.FlowNodeID, this.FlowMultiSignID, this.NextSteps});

  ModelJDInfo.fromJson(Map<String, dynamic> json) {    
    this.Message = json['Message'];
    this.NodeName = json['NodeName'];
    this.AllowEditControls = json['AllowEditControls'];
    this.SignControls = json['SignControls'];
    this.UserName = json['UserName'];
    this.DepartmentName = json['DepartmentName'];
    this.ActionUrl = json['ActionUrl'];
    this.ProgressUrl = json['ProgressUrl'];
    this.DefaultNote = json['DefaultNote'];
    this.FlowName = json['FlowName'];
    this.FlowRefID = json['FlowRefID'];
    this.Date = json['Date'];
    this.LastNote = json['LastNote'];
    this.SignDatas = json['SignDatas'];
    this.AgentEmpName = json['AgentEmpName'];
    this.Result = json['Result'];
    this.IsFlowFinished = json['IsFlowFinished'];
    this.IsFinished = json['IsFinished'];
    this.IsLastStep = json['IsLastStep'];
    this.IsNoteRequired = json['IsNoteRequired'];
    this.IsNew = json['IsNew'];
    this.IsAllowUndo = json['IsAllowUndo'];
    this.UserID = json['UserID'];
    this.DepartmentID = json['DepartmentID'];
    this.NextAction = json['NextAction'];
    this.ChangeAction = json['ChangeAction'];
    this.BackAction = json['BackAction'];
    this.FinishAction = json['FinishAction'];
    this.RejectAction = json['RejectAction'];
    this.StepOrder = json['StepOrder'];
    this.DefaultChoosedStep = json['DefaultChoosedStep'];
    this.FlowID = json['FlowID'];
    this.FlowNodeID = json['FlowNodeID'];
    this.FlowMultiSignID = json['FlowMultiSignID'];
    this.NextSteps = (json['NextSteps'] as List)!=null?(json['NextSteps'] as List).map((i) => NextStepsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.Message;
    data['NodeName'] = this.NodeName;
    data['AllowEditControls'] = this.AllowEditControls;
    data['SignControls'] = this.SignControls;
    data['UserName'] = this.UserName;
    data['DepartmentName'] = this.DepartmentName;
    data['ActionUrl'] = this.ActionUrl;
    data['ProgressUrl'] = this.ProgressUrl;
    data['DefaultNote'] = this.DefaultNote;
    data['FlowName'] = this.FlowName;
    data['FlowRefID'] = this.FlowRefID;
    data['Date'] = this.Date;
    data['LastNote'] = this.LastNote;
    data['SignDatas'] = this.SignDatas;
    data['AgentEmpName'] = this.AgentEmpName;
    data['Result'] = this.Result;
    data['IsFlowFinished'] = this.IsFlowFinished;
    data['IsFinished'] = this.IsFinished;
    data['IsLastStep'] = this.IsLastStep;
    data['IsNoteRequired'] = this.IsNoteRequired;
    data['IsNew'] = this.IsNew;
    data['IsAllowUndo'] = this.IsAllowUndo;
    data['UserID'] = this.UserID;
    data['DepartmentID'] = this.DepartmentID;
    data['NextAction'] = this.NextAction;
    data['ChangeAction'] = this.ChangeAction;
    data['BackAction'] = this.BackAction;
    data['FinishAction'] = this.FinishAction;
    data['RejectAction'] = this.RejectAction;
    data['StepOrder'] = this.StepOrder;
    data['DefaultChoosedStep'] = this.DefaultChoosedStep;
    data['FlowID'] = this.FlowID;
    data['FlowNodeID'] = this.FlowNodeID;
    data['FlowMultiSignID'] = this.FlowMultiSignID;
    data['NextSteps'] = this.NextSteps != null?this.NextSteps.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class NextStepsListBean {
  String NodeName;
  String Roles;
  String ChoosedUsers;
  String ChoosedUserNames;
  int NodeID;
  int NodeType;
  int Order;
  int DefaultChoosedUser;
  List<UsersListBean> Users;

  NextStepsListBean({this.NodeName, this.Roles, this.ChoosedUsers, this.ChoosedUserNames, this.NodeID, this.NodeType, this.Order, this.DefaultChoosedUser, this.Users});

  NextStepsListBean.fromJson(Map<String, dynamic> json) {    
    this.NodeName = json['NodeName'];
    this.Roles = json['Roles'];
    this.ChoosedUsers = json['ChoosedUsers'];
    this.ChoosedUserNames = json['ChoosedUserNames'];
    this.NodeID = json['NodeID'];
    this.NodeType = json['NodeType'];
    this.Order = json['Order'];
    this.DefaultChoosedUser = json['DefaultChoosedUser'];
    this.Users = (json['Users'] as List)!=null?(json['Users'] as List).map((i) => UsersListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NodeName'] = this.NodeName;
    data['Roles'] = this.Roles;
    data['ChoosedUsers'] = this.ChoosedUsers;
    data['ChoosedUserNames'] = this.ChoosedUserNames;
    data['NodeID'] = this.NodeID;
    data['NodeType'] = this.NodeType;
    data['Order'] = this.Order;
    data['DefaultChoosedUser'] = this.DefaultChoosedUser;
    data['Users'] = this.Users != null?this.Users.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class UsersListBean {
  String DepName;
  String Name;
  String Order;
  int ID;

  UsersListBean({this.DepName, this.Name, this.Order, this.ID});

  UsersListBean.fromJson(Map<String, dynamic> json) {    
    this.DepName = json['DepName'];
    this.Name = json['Name'];
    this.Order = json['Order'];
    this.ID = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepName'] = this.DepName;
    data['Name'] = this.Name;
    data['Order'] = this.Order;
    data['ID'] = this.ID;
    return data;
  }
}
