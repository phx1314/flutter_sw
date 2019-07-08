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
  ModelMenuConfig mModelMenuConfig;
  String ConNumber;
  String ConName;
  String refTable_file;
  String CustName;
  String ConDate;
  String ConFulfilTypeName;
  String ConIsFeeFinished;
  String FlowName;
  String FlowStatusName;
  String FlowTurnedEmpIDs;
  String FlowFinishControls;
  String CreatorEmpName;
  String FlowSummary;
  String state;
  String Title;
  String CreationTime;
  List children;
  double ConFee;
  double FeeFact;
  double FeeInvoice;
  double ConBalanceFee;
  double SumConFee;
  double NoFee;
  var rowNumber;
  var Id;
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
      {this.ConNumber,
      this.FlowSummary,
      this.ConName,
      this.CustName,
      this.ConDate,
      this.ConFulfilTypeName,
      this.ConIsFeeFinished,
      this.FlowName,
      this.FlowStatusName,
      this.FlowTurnedEmpIDs,
      this.FlowFinishControls,
      this.CreatorEmpName,
      this.state,
      this.children,
      this.ConFee,
      this.CreationTime,
      this.FeeFact,
      this.Title,
      this.FeeInvoice,
      this.ConBalanceFee,
      this.SumConFee,
      this.NoFee,
      this.rowNumber,
      this.IsSave,
      this.Id = 0,
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
    this.ConNumber = json['ConNumber'];
    this.ConName = json['ConName'];
    this.CustName = json['CustName'];
    this.IsSave = json['IsSave'];
    this.ConDate = json['ConDate'];
    this.ConFulfilTypeName = json['ConFulfilTypeName'];
    this.ConIsFeeFinished = json['ConIsFeeFinished'];
    this.FlowName = json['FlowName'];
    this.FlowStatusName = json['FlowStatusName'];
    this.FlowTurnedEmpIDs = json['FlowTurnedEmpIDs'];
    this.CreationTime = json['CreationTime'];
    this.FlowFinishControls = json['FlowFinishControls'];
    this.CreatorEmpName = json['CreatorEmpName'];
    this.FlowRefTable = json['FlowRefTable'];
    this.state = json['state'];
    this.children = json['children'];
    this.Title = json['Title'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.ConFee = json['ConFee'];
    this.FeeFact = json['FeeFact'];
    this.FeeInvoice = json['FeeInvoice'];
    this.ConBalanceFee = json['ConBalanceFee'];
    this.SumConFee = json['SumConFee'];
    this.NoFee = json['NoFee'];
    this.rowNumber = json['row_number'];
    this.Id ??= json['Id'];
    this.Id ??= json['FlowRefID'];
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
    data['ConNumber'] = this.ConNumber;
    data['ConName'] = this.ConName;
    data['CustName'] = this.CustName;
    data['IsSave'] = this.IsSave;
    data['ConDate'] = this.ConDate;
    data['ConFulfilTypeName'] = this.ConFulfilTypeName;
    data['ConIsFeeFinished'] = this.ConIsFeeFinished;
    data['FlowName'] = this.FlowName;
    data['FlowStatusName'] = this.FlowStatusName;
    data['FlowTurnedEmpIDs'] = this.FlowTurnedEmpIDs;
    data['FlowFinishControls'] = this.FlowFinishControls;
    data['CreatorEmpName'] = this.CreatorEmpName;
    data['state'] = this.state;
    data['FlowRefTable'] = this.FlowRefTable;
    data['_summary'] = this.FlowSummary;
    data['FlowSummary'] = this.FlowSummary;
    data['ConFee'] = this.ConFee;
    data['CreationTime'] = this.CreationTime;
    data['FeeFact'] = this.FeeFact;
    data['FeeInvoice'] = this.FeeInvoice;
    data['ConBalanceFee'] = this.ConBalanceFee;
    data['SumConFee'] = this.SumConFee;
    data['Title'] = this.Title;
    data['NoFee'] = this.NoFee;
    data['row_number'] = this.rowNumber;
    data['Id'] = this.Id;
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
