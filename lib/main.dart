import 'package:flutter/material.dart';
import './post.dart';

void main() => runApp(new Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}): super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PostState postState = new PostState();

  @override

  void initState(){
    super.initState();
    _getPosts();
  }

  _getPosts() async{
    if(!mounted) return;

    await postState.getFromApi();
    setState(() {
      
    });
  }

  Widget _getSuccessStateWidget() {
    return new ListView.builder(
      itemCount: postState.posts.length,
      itemBuilder: (context, index){
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(postState.posts[index].title,
            style: new TextStyle(fontWeight: FontWeight.bold)),
            new Text(postState.posts[index].body),
            new Divider(),
          ],
        );
      },
    );
  }

  Widget _getLoadingStateWidget() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget getCurrentStateWidget() {
    Widget currentStateWidget;
    if(!postState.error && !postState.loading) {
      currentStateWidget = _getSuccessStateWidget();
    }
    else {
      currentStateWidget = _getLoadingStateWidget();
    }
    return currentStateWidget;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Test"),
      ),
      body: getCurrentStateWidget()
    );
  }
}