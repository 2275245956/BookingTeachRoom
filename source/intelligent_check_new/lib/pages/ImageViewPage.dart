import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {
  List<String> imgList = new List();
  final bool isLocal;
  PhotoViewPage(this.imgList,this.isLocal);

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState(imgList);
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  List<String> assetNames = [];
  String theme="red";
  _PhotoViewPageState(this.assetNames);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "图片预览",
          style: TextStyle(color: Colors.black, fontSize: 19),
        ),
        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: new Container(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left,
                color: GetConfig.getColor(theme)/*GetConfig.getColor(theme)*/,
                size: 32),
          ),
        ),
      ),
      body: assetNames == null
          ? Center(
              child: Text("暂无图片...",style: TextStyle(color: Color.fromRGBO(209, 209, 209, 1),fontSize: 25),),
            )
          : _scrollView(context),
    );
  }

  Widget _scrollView(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width,
              mainAxisSpacing:1,
              crossAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.center,
                    padding: _edgeInsetsForIndex(index),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PhotoPreview(
                            initialIndex: index,
                            photoList: assetNames ?? new List(),
                            isLocal: this.widget.isLocal,
                          );
                        }));
                      },
                      child: this.widget.isLocal?Image(image: AssetImage('assets/images/template.jpg')):Image.network(
                        assetNames[index] ?? "",
                        height: 250.0,
                        width: 250.0,
                        fit: BoxFit.cover,
                      ),
                    ));
              },
              childCount: assetNames == null ? 0 : assetNames.length,
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }
}

//PhotoPreview 点击小图后的效果
class PhotoPreview extends StatefulWidget {
  final int initialIndex;
  final List<String> photoList;
  final bool isLocal;
  final PageController pageController;

  PhotoPreview({this.initialIndex, this.photoList,this.isLocal})
      : pageController = PageController(initialPage: initialIndex);

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  int currentIndex;
  String  theme="red";

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  //图片切换
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "图片预览",
          style: TextStyle(color: Colors.black, fontSize: 19),
        ),

        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: new Container(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left,
                color:   GetConfig.getColor(theme) /*GetConfig.getColor(theme)*/,
                size: 32),
          ),
        ),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: onPageChanged,
          itemCount: widget.photoList.length,
          pageController: widget.pageController,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: this.widget.isLocal?AssetImage('assets/images/template.jpg'):NetworkImage(widget.photoList[index]),
              minScale: PhotoViewComputedScale.contained * 0.6,
              maxScale: PhotoViewComputedScale.covered * 1.1,
              initialScale: PhotoViewComputedScale.contained,
            );
          },
        ),
      )
    );


  }
}
