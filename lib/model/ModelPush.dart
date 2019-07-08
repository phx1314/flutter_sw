class ModelPush {
  String Content;
  String Id;
  String RefID;
  String RefTable;
  String Title;
  String flowMultiSignID;
  String flowNodeId;

  ModelPush({this.Content, this.Id, this.RefID, this.RefTable, this.Title, this.flowMultiSignID, this.flowNodeId});

  ModelPush.fromJson(Map<String, dynamic> json) {    
    this.Content = json['Content'];
    this.Id = json['Id'];
    this.RefID = json['RefID'];
    this.RefTable = json['RefTable'];
    this.Title = json['Title'];
    this.flowMultiSignID = json['flowMultiSignID'];
    this.flowNodeId = json['flowNodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Content'] = this.Content;
    data['Id'] = this.Id;
    data['RefID'] = this.RefID;
    data['RefTable'] = this.RefTable;
    data['Title'] = this.Title;
    data['flowMultiSignID'] = this.flowMultiSignID;
    data['flowNodeId'] = this.flowNodeId;
    return data;
  }

}
