import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/ApplySearchResult.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/widget/search/hotSug.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentApplySearchPage extends StatefulWidget{
  bool isHandle;
  StudentApplySearchPage(this.isHandle);

  @override
  State<StatefulWidget> createState() => new _ApplySearchPage();
}

class _ApplySearchPage extends State<StudentApplySearchPage>{

  final TextEditingController _controller = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  List<String> hotWords = List();
  List<_SearchKey> searchKeyCount = List();
  List<String> orderKeyword = List();

  bool _isNotSearching = true;

  String theme="red";

  initConfig() async{
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        this.theme = preferences.getString("theme")??KColorConstant.DEFAULT_COLOR;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 243, 245, 1),
      appBar: AppBar(
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor:  Color(0xFFFFFFFF),
        leading:new Container(
          child: GestureDetector(
            onTap: () {
              _focusNode.unfocus();
              Navigator.pop(context);
            },
            child:Icon(Icons.keyboard_arrow_left, color: Color.fromRGBO(209, 6, 24, 1), size: 32),
          ),
        ),
        title:new  Container(
            height: 30,

            padding: EdgeInsets.only(bottom: 5),
            decoration: new BoxDecoration(
              color: Colors.grey[100],
              borderRadius: new BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0,left: 10.0,top: 5),
                  child: Image.asset("assets/images/search_"+theme+".png",width: 14,color: Colors.black26),
                ),
                new Container(
                  width: MediaQuery.of(context).size.width-160,
                  child:TextField(
                    controller: _controller,
                    autofocus: true,
                    focusNode: _focusNode,
                    style: TextStyle(fontSize: 14.0, color: Color(0xFF999999)),
                    decoration: new InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: (){
                              _controller.text="";
                              setState(() {
                                _isNotSearching = true;
                              });
                            },
                            child:Container(
                              padding: EdgeInsets.only(top:6),
                              child: new Icon(Icons.delete_forever,color: GetConfig.getColor(theme),size: 18,),
                            )
                        ),
                        border: InputBorder.none,
                        hintText: "请输入搜索内容",
                        contentPadding: EdgeInsets.only(top: 6)
                    ),
                    onChanged: (val){
                    },

                  ),
//                  )
                )
              ],
            )
        ),
        actions: <Widget>[
          Align(
              child:Padding(padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      search(this._controller.text);
                    });
                  },
                  child:Text("搜索",style: TextStyle(color:GetConfig.getColor(theme),fontSize: 14.0,fontWeight: FontWeight.w500),),
                ),
              )
          )
        ],
      ),
//      ),
      body:ListView(
        children: <Widget>[
          Offstage(
              offstage: !_isNotSearching,
              child:Container(
                color: Colors.white,
                child:HotSugWidget(title:"搜索历史",hotWords:hotWords,searchData: searchByHistory,deleteBtnClick:deleteSearchHistory,),
              )
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  void initState() {
    super.initState();
    initData();
    initConfig();
  }

  void initData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> data = prefs.getStringList("hotWordsHistory");
      if(data != null && data.length > 0){
        hotWords = data;
      }else{
        hotWords =[];
      }
    });
  }

  search(keyword) async{
    if(keyword != null && keyword.isNotEmpty){

      // 添加搜索历史
      if(hotWords.contains(keyword)){

      }else{
        setState(() {
          hotWords.add(keyword);
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList("hotWordsHistory", hotWords);
      }

      // 页面跳转，查询并显示结果
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) {
            return new ApplySearchResultPage(keyword,this.widget.isHandle);
          })
      );
    }
  }

  searchByHistory(String text){
    // 页面跳转，查询并显示结果
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) {
          return new ApplySearchResultPage(text,this.widget.isHandle);
        })
    );
  }

  deleteSearchHistory() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("hotWordsHistory");
    initData();
  }
}

class _SearchKey {
  String keyword;
  int count;

  _SearchKey();

  _SearchKey.fromJson(jsonRes) {
    keyword = jsonRes['keyword'];
    count = jsonRes['count'];
  }

  @override
  String toString() {
    return '{"keyword":"$keyword","count": $count}';
  }
}