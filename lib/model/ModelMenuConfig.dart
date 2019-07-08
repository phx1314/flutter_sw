import 'ModelDx.dart';

class ModelMenuConfig {
  FlowBean flow;
  GridBean grid;
  List<SearchListBean> search;
  List<UploadersListBean> uploaders;

  ModelMenuConfig({this.flow, this.grid, this.uploaders, this.search});

  ModelMenuConfig.fromJson(Map<String, dynamic> json) {
    this.flow = FlowBean.fromJson(json['flow']);
    this.grid = GridBean.fromJson(json['grid']);
    this.uploaders = (json['uploaders'] as List) != null
        ? (json['uploaders'] as List)
            .map((i) => UploadersListBean.fromJson(i))
            .toList()
        : null;
    try {
      this.search = (json['search'] as List) != null
          ? (json['search'] as List)
              .map((i) => SearchListBean.fromJson(i))
              .toList()
          : null;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flow'] = this.flow.toJson();
    data['grid'] = this.grid.toJson();
    data['uploaders'] = this.uploaders != null
        ? this.uploaders.map((i) => i.toJson()).toList()
        : null;
    data['search'] = this.search != null
        ? this.search.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class FlowBean {
  String processor;
  String refTable;
  bool isShowSave;

  FlowBean({this.processor, this.refTable, this.isShowSave});

  FlowBean.fromJson(Map<String, dynamic> json) {
    this.processor = json['processor'];
    this.refTable = json['refTable'];
    this.isShowSave = json['isShowSave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processor'] = this.processor;
    data['refTable'] = this.refTable;
    data['isShowSave'] = this.isShowSave;
    return data;
  }
}

class GridBean {
  String listPage;
  int rows;
  List<String> addUrl;
  var delUrl;
  List<String> editUrl;
  List<String> url;
  List queryParams;

  GridBean(
      {this.listPage,
      this.rows,
      this.queryParams,
      this.addUrl,
      this.delUrl,
      this.editUrl,
      this.url});

  GridBean.fromJson(Map<String, dynamic> json) {
    this.listPage = json['listPage'];
    this.rows = json['rows'];
    this.queryParams = (json['queryParams'] as List) != null
        ? (json['queryParams'] as List)
        : null;

    List<dynamic> addUrlList = json['addUrl'];
    this.addUrl = new List();
    this.addUrl.addAll(addUrlList.map((o) => o.toString()));
    this.delUrl = json['delUrl'] is List
        ? (json['delUrl'] as List) != null ? (json['delUrl'] as List) : null
        : json['delUrl'];

    List<dynamic> editUrlList = json['editUrl'];
    this.editUrl = new List();
    this.editUrl.addAll(editUrlList.map((o) => o.toString()));

    List<dynamic> urlList = json['url'];
    this.url = new List();
    this.url.addAll(urlList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listPage'] = this.listPage;
    data['rows'] = this.rows;
    data['queryParams'] = this.queryParams != null
        ? this.queryParams.map((i) => i.toJson()).toList()
        : null;
    data['addUrl'] = this.addUrl;
    data['delUrl'] = this.delUrl;
    data['editUrl'] = this.editUrl;
    data['url'] = this.url;
    return data;
  }
}

class UploadersListBean {
  String uploaderName;
  String refTable;

  UploadersListBean({this.uploaderName, this.refTable});

  UploadersListBean.fromJson(Map<String, dynamic> json) {
    this.uploaderName = json['uploaderName'];
    this.refTable = json['refTable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploaderName'] = this.uploaderName;
    data['refTable'] = this.refTable;
    return data;
  }
}

class SearchListBean {
  String type;
  String baseorder;
  String text;
  String multiselect;
  String sqlstring;
  String sqlkey;
  String value;

  String ids;
  List<ModelDx> mModelDxs;

  SearchListBean(
      {this.type,
      this.baseorder,
      this.text,
      this.multiselect,
      this.sqlstring,
      this.sqlkey});

  SearchListBean.fromJson(Map<String, dynamic> json) {
    this.type = json['type'];
    this.baseorder = json['baseorder'];
    this.text = json['text'];
    this.multiselect = json['multiselect'];
    this.sqlstring = json['sqlstring'];
    this.sqlkey = json['sqlkey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['baseorder'] = this.baseorder;
    data['text'] = this.text;
    data['multiselect'] = this.multiselect;
    data['sqlstring'] = this.sqlstring;
    data['sqlkey'] = this.sqlkey;
    return data;
  }
}
