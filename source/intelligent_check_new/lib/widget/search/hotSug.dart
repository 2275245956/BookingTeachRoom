import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';

class HotSugWidget extends StatelessWidget {
  final List hotWords;
  final ValueChanged<String> searchData;
  final Function deleteBtnClick;
  final title;
  String theme="red";
  HotSugWidget( {Key key,this.hotWords,this.title,this.searchData,this.deleteBtnClick}):super(key:key);


  @override
  Widget build(BuildContext context) { //Color.fromRGBO(240, 243, 245, 1)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child:Row(
            children: <Widget>[
              Expanded(
                  child:Text(title,
                    style: TextStyle(color: GetConfig.getColor(theme),fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                  flex: 9,),
              Expanded(
                child:GestureDetector(
                  child: Image.asset("assets/images/delete_red.png",color:GetConfig.getColor(theme),height: 20,),
                  onTap: ()=>deleteBtnClick()),

                flex: 1,),
             ],
          ),
          margin: EdgeInsets.only(bottom: 10),
        ),
        Divider(height: 1,),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: hotWords.map((i) => GestureDetector(
              onTap: ()=>searchData(i),
              child: Container(
                  decoration: BoxDecoration(
                  color: GetConfig.getColor(theme),
                  borderRadius: BorderRadius.circular(5)),
                  padding:EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  child: Text(
                    i,
                    style: TextStyle(color:Colors.white),
                  )
              ),
            )).toList(),
          ),
        )
      ],
    );
  }
}
