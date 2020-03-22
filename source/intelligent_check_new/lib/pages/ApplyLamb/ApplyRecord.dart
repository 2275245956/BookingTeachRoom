import 'package:flutter/material.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intelligent_check_new/model/InspectionRecordModel.dart';
import 'package:intelligent_check_new/pages/ApplyLamb/ApplySearchPage.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ApplyRecordListScreen extends StatefulWidget {
  ApplyRecordListScreen();

  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<ApplyRecordListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 当前页码
  int pageIndex = 0;

  // 是否有下一页
  bool hasNext = false;

  // 分页所需控件
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  bool isAnimating = false;

  String theme = "red";
  InspectionRecordFilter inspectionRecordFilter = new InspectionRecordFilter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: AppBar(
          title: Text(
            "申请记录",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
              child: Container(
                child: Image.asset(
                  "assets/images/search_red.png",
                  width: 22,
                ),
                padding: EdgeInsets.only(right: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return ApplySearchPage(false);
                }));
              },
            )
          ],
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(theme), size: 32),
            ),
          ),
        ),
        body: ModalProgressHUD(
          child: _getWidget(),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }

  Widget _getWidget() {
    return buildInnerListHeaderDropdownMenu();
  }

  searchData() {
    loadData();
  }

  ScrollController scrollController = new ScrollController();
  GlobalKey globalKey2 = new GlobalKey();

  Widget buildInnerListHeaderDropdownMenu() {
    return new DefaultDropdownMenuController(
        onSelected: ({int menuIndex, int index, int subIndex, dynamic data}) {
          if (menuIndex == 0) {
            setState(() {
              var id = data["id"];
              if (id == -1) {
              } else {}
            });
          }
        },
        child: new Stack(
          children: <Widget>[
            new CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  new SliverList(
                      key: globalKey2,
                      delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return new Container(
                          color: Colors.black26,
                        );
                      }, childCount: 1)),
                  new SliverPersistentHeader(
                    delegate: new DropdownSliverChildBuilderDelegate(
                        builder: (BuildContext context) {
                      return new Container(
                          color: Colors.white,
                          child: buildDropdownHeader(onTap: this._onTapHead));
                    }),
                    pinned: true,
                    floating: true,
                  ),
                  new SliverList(
                      delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
//                            return new Container(
//                              color: Theme.of(context).scaffoldBackgroundColor,
//                              child: new Image.asset(
//                                "images/body.jpg",
//                                fit: BoxFit.fill,
//                              ),
//                            );
                  }, childCount: 10)),
                ]),
            new Padding(
                padding: new EdgeInsets.only(top: 46.0),
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                        child: new Stack(
                      children: <Widget>[
                        Center(
                            child: EasyRefresh(
                          key: _easyRefreshKey,
                          behavior: ScrollOverBehavior(),
                          refreshHeader: ClassicsHeader(
                            key: _headerKey,
                            bgColor: Colors.transparent,
                            textColor: Colors.black87,
                            moreInfoColor: Colors.black54,
                            showMore: true,
                          ),
                          refreshFooter: ClassicsFooter(
                            key: _footerKey,
                            bgColor: Colors.transparent,
                            textColor: Colors.black87,
                            moreInfoColor: Colors.black54,
                            showMore: true,
                          ),
                          child: ListView.builder(
                            //ListView的Item
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    GetConfig.popUpMsg("点击");
                                  },
                                  child: Container(
                                    child: Card(
                                      elevation: 0.2,
                                      margin: EdgeInsets.only(
                                          top: 5, left: 16, right: 16),
                                      child: new Container(
                                          height: 110.0,
//                                          margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 8,
                                                height: 110,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(4),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  4)),
                                                  color: getPointColor("2"),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Text(
                                                      (index + 1).toString() +
                                                          "." +
                                                          "实验名称",
                                                      style: new TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                        ),
                                                        Text(
                                                          "教室名称及编号:1111111",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 36),
                                                        ),
                                                        Text(
                                                          getStatusName("2"),
                                                          style: TextStyle(
                                                              color:
                                                                  getPointColor(
                                                                      "3"),
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              90,
                                                          child: Text(
                                                            "最大人数",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        new Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color: GetConfig
                                                              .getColor(theme),
                                                          size: 28,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                        ),
                                                        Text(
                                                          "时间:",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "测试",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
//                                          margin: EdgeInsets.only(left: 10,right: 10),
                                  ));
                            },
                          ),
                          onRefresh: () async {
                            await new Future.delayed(const Duration(seconds: 1),
                                () {
                              setState(() {
                                pageIndex = 0;
                                // initData = [];
                              });
                              loadData();
                            });
                          },
                          loadMore: () async {
                            await new Future.delayed(const Duration(seconds: 1),
                                () {
                              if (hasNext) {
                                setState(() {
                                  pageIndex = pageIndex + 1;
                                });
                                loadData();
                              }
                            });
                          },
                        )),
                        buildDropdownMenu()
                      ],
                    ))
                  ],
                )),
          ],
        ));
  }

  void _onTapHead(int index) {
    RenderObject renderObject = globalKey2.currentContext.findRenderObject();
    DropdownMenuController controller =
        DefaultDropdownMenuController.of(globalKey2.currentContext);
    scrollController
        .animateTo(scrollController.offset + renderObject.semanticBounds.height,
            duration: new Duration(milliseconds: 150), curve: Curves.ease)
        .whenComplete(() {
      controller.show(index);
    });
  }

  String titleAll = '所有';

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return new DropdownHeader(
      onTap: onTap,
      titles: [titleAll],
    );
  }

  static const int TYPE_INDEX = 0;
  static const List<Map<String, dynamic>> TITLE_ALL_CONTENT = [
    {"title": "全部", "id": -1},
    {"title": "审核中", "id": 1},
    {"title": "审核通过", "id": 2},
    {"title": "审核驳回", "id": 3},
    {"title": "申请取消", "id": 4},
    {"title": "申请超时", "id": 5},
  ];

  DropdownMenu buildDropdownMenu() {
    return new DropdownMenu(
        maxMenuHeight: kDropdownMenuItemHeight * 10,
        menus: [
          new DropdownMenuBuilder(
              builder: (BuildContext context) {
                return new DropdownListMenu(
                  selectedIndex: TYPE_INDEX,
                  data: TITLE_ALL_CONTENT,
                  itemBuilder:
                      (BuildContext context, dynamic data, bool selected) {
                    return new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              defaultGetItemLabel(data),
                              style: selected
                                  ? new TextStyle(
                                      fontSize: 14.0,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400)
                                  : new TextStyle(fontSize: 14.0),
                            ),
                            new Expanded(
                                child: new Align(
                              alignment: Alignment.centerRight,
                              child: selected
                                  ? new Icon(
                                      Icons.check,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : null,
                            )),
                          ],
                        ));
                  },
                );
              },
              height: kDropdownMenuItemHeight * TITLE_ALL_CONTENT.length),
        ]);
  }

  loadData() async {}

  getPointColor(String statusName) {
    if (statusName == "1") {
      return Colors.blueGrey;
    } else if (statusName == "2") {
      return Colors.green;
    } else if (statusName == "3") {
      return Colors.red;
    } else if (statusName == "4") {
      return Colors.orange;
    } else if (statusName == "5") {
      return Colors.grey;
    }
  }

  getStatusName(String statusName) {
    if (statusName == "1") {
      return "审核中";
    } else if (statusName == "2") {
      return "审核通过";
    } else if (statusName == "3") {
      return "审核驳回";
    } else if (statusName == "4") {
      return "申请取消";
    } else if (statusName == "5") {
      return "申请超时";
    }
  }
}
