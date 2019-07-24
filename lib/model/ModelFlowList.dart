import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelWork.dart';

class ModelFlowList {
  int total;
  List<RowsListBean> rows;

  ModelFlowList({this.total, this.rows});

  ModelFlowList.fromJson(Map<String, dynamic> json) {
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
  String text;
  String MenuNameEng;
  bool isChecked = false;
  ModelMenuConfig mModelMenuConfig;
  String refTable_file;
  String FlowName;
  String FlowStatusName;
  String CreatorEmpName;
  String FlowSummary;
  String Title;
  String CreationTime;
  List children;
  var Id;
  var FormId;
  var KeyID;
  var FatherID;
  var ConFulfilType;
  var FlowIDD;
  var FlowID;
  var FlowStatusID;
  var FlowNodeOrder;
  var FlowNodeTypeID;
  var FlowMultiSignStatus;
  var CreateEmpId;
  var CreatorEmpId;
  bool isExpand;
  String FlowRefTable;
  List<RowsListBean> rows;
  bool IsNew;
  List<Widget> mWidgets_son;
  var IsSave;
  int FlowNodeID;
  int FlowMultiSignID;
  String action;
  String MenuMobileConfig;

  RowsListBean(
      {this.FlowSummary,
      this.FlowName,
      this.FlowStatusName,
      this.CreatorEmpName,
      this.children,
      this.isChecked = false,
      this.CreationTime,
      this.Title,
      this.IsSave,
      this.Id = 0,
      this.FormId = 0,
      this.KeyID,
      this.FatherID,
      this.ConFulfilType,
      this.FlowIDD,
      this.FlowID,
      this.FlowStatusID,
      this.FlowNodeOrder,
      this.FlowNodeTypeID,
      this.FlowMultiSignStatus,
      this.CreateEmpId,
      this.CreatorEmpId});

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.IsSave = json['IsSave'];
    this.FlowName = json['FlowName'];
    this.FlowStatusName = json['FlowStatusName'];
    this.CreationTime = json['CreationTime'];
    this.CreatorEmpName = json['CreatorEmpName'];
    this.FlowRefTable = json['FlowRefTable'];
    this.children = json['children'];
    this.Title = json['Title'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.Id ??= json['Id'];
    this.Id ??= json['FlowRefID'];
    this.FormId = json['FormId'];
    this.KeyID = json['KeyID'];
    this.FatherID = json['FatherID'];
    this.ConFulfilType = json['ConFulfilType'];
    this.FlowIDD = json['FlowIDD'];
    this.FlowID = json['FlowID'];
    this.FlowStatusID = json['FlowStatusID'];
    this.FlowNodeOrder = json['FlowNodeOrder'];
    this.FlowNodeTypeID = json['FlowNodeTypeID'];
    this.FlowMultiSignStatus = json['FlowMultiSignStatus'];
    this.CreateEmpId = json['CreateEmpId'];
    this.CreatorEmpId = json['CreatorEmpId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSave'] = this.IsSave;
    data['FlowName'] = this.FlowName;
    data['FlowStatusName'] = this.FlowStatusName;
    data['CreatorEmpName'] = this.CreatorEmpName;
    data['FlowRefTable'] = this.FlowRefTable;
    data['_summary'] = this.FlowSummary;
    data['FlowSummary'] = this.FlowSummary;
    data['CreationTime'] = this.CreationTime;
    data['Title'] = this.Title;
    data['Id'] = this.Id;
    data['FormId'] = this.FormId;
    data['FlowRefID'] = this.Id;
    data['KeyID'] = this.KeyID;
    data['FatherID'] = this.FatherID;
    data['ConFulfilType'] = this.ConFulfilType;
    data['FlowIDD'] = this.FlowIDD;
    data['FlowID'] = this.FlowID;
    data['FlowStatusID'] = this.FlowStatusID;
    data['FlowNodeOrder'] = this.FlowNodeOrder;
    data['FlowNodeTypeID'] = this.FlowNodeTypeID;
    data['FlowMultiSignStatus'] = this.FlowMultiSignStatus;
    data['CreateEmpId'] = this.CreateEmpId;
    data['CreatorEmpId'] = this.CreatorEmpId;
    return data;
  }
}
