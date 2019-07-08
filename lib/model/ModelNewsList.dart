class ModelNewsList {
  int total;
  List<RowsListBean> rows;

  static ModelNewsList fromMap(Map<String, dynamic> map) {
    ModelNewsList temp = new ModelNewsList();
    temp.total = map['total'];
    temp.rows = RowsListBean.fromMapList(map['rows']);
    return temp;
  }

  static List<ModelNewsList> fromMapList(dynamic mapList) {
    List<ModelNewsList> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class RowsListBean {
  String NewsTypeName;
  String NewsTitle;
  String CreatorEmpName;
  String NewsDate;
  String NewsImage;
  int Id;
  int NewsTypeID;

  static RowsListBean fromMap(Map<String, dynamic> map) {
    RowsListBean rowsListBean = new RowsListBean();
    rowsListBean.NewsTypeName = map['NewsTypeName'];
    rowsListBean.NewsTitle = map['NewsTitle'];
    rowsListBean.CreatorEmpName = map['CreatorEmpName'];
    rowsListBean.NewsDate = map['NewsDate'];
    rowsListBean.NewsImage = map['NewsImage'];
    rowsListBean.Id = map['Id'];
    rowsListBean.NewsTypeID = map['NewsTypeID'];
    return rowsListBean;
  }

  static List<RowsListBean> fromMapList(dynamic mapList) {
    List<RowsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
