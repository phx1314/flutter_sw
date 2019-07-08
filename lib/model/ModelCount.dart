class ModelCount {
  int Total;
  bool Result;
  List<DatasListBean> Datas;

  static ModelCount fromMap(Map<String, dynamic> map) {
    ModelCount temp = new ModelCount();
    temp.Total = map['Total'];
    temp.Result = map['Result'];
    temp.Datas = DatasListBean.fromMapList(map['Datas']);
    return temp;
  }

  static List<ModelCount> fromMapList(dynamic mapList) {
    List<ModelCount> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DatasListBean {
  String MailReadEmpName;
  String CreationTime;
  String MailTitle;
  String CreatorEmpName;
  int Id;
  int MailReadEmpId;
  int MailReadIsDelete;
  int MailIsBBC;

  static DatasListBean fromMap(Map<String, dynamic> map) {
    DatasListBean datasListBean = new DatasListBean();
    datasListBean.MailReadEmpName = map['MailReadEmpName'];
    datasListBean.CreationTime = map['CreationTime'];
    datasListBean.MailTitle = map['MailTitle'];
    datasListBean.CreatorEmpName = map['CreatorEmpName'];
    datasListBean.Id = map['Id'];
    datasListBean.MailReadEmpId = map['MailReadEmpId'];
    datasListBean.MailReadIsDelete = map['MailReadIsDelete'];
    datasListBean.MailIsBBC = map['MailIsBBC'];
    return datasListBean;
  }

  static List<DatasListBean> fromMapList(dynamic mapList) {
    List<DatasListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
