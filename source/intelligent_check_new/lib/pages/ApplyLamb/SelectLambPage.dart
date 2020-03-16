import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/pages/ApplyLamb/SelectDatePage.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intelligent_check_new/constants/color.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class SelLambScreen extends StatefulWidget {
  @override
  _SelLambScreen createState() => _SelLambScreen();
}

class _SelLambScreen extends State<SelLambScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String theme = "red";
  bool isAnimating = false;
  TextEditingController lamDate=new  TextEditingController();
  @override
  void initState() {
    super.initState();
    // initConfig();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (theme.isEmpty) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        body: Text(""),
      );
    }
    //获取统计数据
//    StatisticsPage.queryAuthCompanyLeaves();
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 246, 249, 1),
      appBar: AppBar(
        title: Text(
          '实验室选择',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: GestureDetector(
          child: Icon(Icons.keyboard_arrow_left,color: GetConfig.getColor(theme),size: 28,),
          onTap: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  color:Colors.redAccent,
                  padding: EdgeInsets.only(left: 10),
                  child:Row(
                    children: <Widget>[
                      Text("实验时间",style: TextStyle(color: Colors.white,fontSize: 16),),
                      Expanded(child:  Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(

                                width:MediaQuery.of(context).size.width -50,
                                margin: EdgeInsets.only(left:10),
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 7,
                                              child: TextField(
                                                cursorColor: Colors.white,
                                                enabled: false,
                                               // keyboardType:
                                               // TextInputType.number,
                                               // autofocus: false,
                                                controller: lamDate,
                                                maxLines: null,
                                                decoration:
                                                InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical:
                                                      10.0,
                                                      horizontal:
                                                      10),
                                                  border:
                                                  InputBorder.none,
                                                  hintText: "选择实验时间",
                                                  filled: true,
                                                  fillColor:Colors.white,
                                                ),
                                                onEditingComplete: () {
                                                  //print(this._controller.text);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.date_range,
                                                color:Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        theme: DatePickerTheme(
                                            itemStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                            doneStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16)),
                                        onConfirm: (date) {
                                         lamDate .text = new DateFormat("yyyy-MM-dd").format(date);
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.zh);
                                  },
                                )),
                          ),
                        ],
                      ),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text("说明：选择时间加载当前日期下的空闲教室，点击教室可查看当年天的实验情况，申请实验！",style:TextStyle(color: Colors.red,fontSize: 12)),
                ),
                Container(child: GridView(
                  shrinkWrap: true,
                  //构造 GridView 的委托者，GridView.count 就相当于指定 gridDelegate 为 SliverGridDelegateWithFixedCrossAxisCount，
                  //GridView.extent 就相当于指定 gridDelegate 为 SliverGridDelegateWithMaxCrossAxisExtent，它们相当于对普通构造方法的一种封装
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //必传参数，Cross 轴（在 GridView 中通常是横轴，即每一行）子组件个数
                    crossAxisCount: 4,
                    //子组件宽高比，如 2 表示宽：高=2:1,如 0.5 表示宽：高=0.5:1=1:2，简单来说就是值大于 1 就会宽大于高，小于 1 就会宽小于高
                    childAspectRatio: 1,
                    //Cross 轴子组件的间隔，一行中第一个子组件左边不会添加间隔，最后一个子组件右边不会添加间隔，这一点很棒
                    crossAxisSpacing: 3,
                    //Main 轴（在 GridView 中通常是纵轴，即每一列）子组件间隔，也就是每一行之间的间隔，同样第一行的上边和最后一行的下边不会添加间隔
                    mainAxisSpacing: 3,
                  ),

                  cacheExtent: 0,

                  padding: EdgeInsets.all(5),

                  physics: new BouncingScrollPhysics(),
                  //Item 的顺序是否反转，若为 true 则反转，这个翻转只是行翻转，即第一行变成最后一行，但是每一行中的子组件还是从左往右摆放的
//      reverse: true,
                  //GirdView 的方向，为 Axis.vertical 表示纵向，为 Axis.horizontal 表示横向，横向的话 CrossAxis 和 MainAxis 表示的轴也会调换
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    GestureDetector(child: Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 2.0, color: Colors.red),
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("4-401"),
                    ),onTap:()=>Navigator.push(context, new MaterialPageRoute(builder: (context)=>SelectDatePage())),),
                    Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 2.0, color: Colors.red),
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("4-401"),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 2.0, color: Colors.red),
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("4-401"),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 2.0, color: Colors.red),
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("4-401"),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 2.0, color: Colors.red),
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("4-401"),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 2.0, color: Colors.red),
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),

                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text("4-401"),
                    ),
                  ],
                ),)
              ],
            )
        ),
        inAsyncCall: isAnimating,
        // demo of some additional parameters
        opacity: 0.7,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }

}