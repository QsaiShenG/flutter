import 'package:flutter/material.dart';
import 'package:homework4/SwitchAndCheckbox.dart';
import 'package:homework4/dialog.dart';
import 'package:homework4/friendviewmodel.dart';
import 'package:homework4/gridview_widget.dart';
import 'package:homework4/listview0.dart';
import 'package:homework4/logtest.dart';
import 'package:homework4/page/drawertest.dart';
import 'package:homework4/scaffold_route.dart';
import 'package:homework4/snackbar_widget.dart';
import 'dialogdemo.dart';
import 'text_widget.dart';
import 'image_widget.dart';
import 'icon_widget.dart';
import 'horizontal_listview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale("zh","CH"),
          const Locale("en","US"),
        ],

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WidgetList(title: 'Widgets demo')
    );

  }
}
class WidgetList extends StatelessWidget {

  final String title;

  WidgetList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body:WillPopScope(
        onWillPop: ()async=>showDialog(
          context: context,
           builder: await (context)=>AlertDialog(
            title: Text("are you sure?"),
            actions: <Widget>[
              RaisedButton(
                child: Text("yes"),
                onPressed: (){Navigator.of(context).pop(true);},
              ),
              RaisedButton(
                child: Text("no"),
                onPressed: (){Navigator.of(context).pop(false);},
              ),
            ],
          )
        ),
        child:Scaffold(
    body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.text_format),
            title: Text('Text Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => TextWidgetDemo(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.image),
            title: Text('Image Widget'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ImageWidgetDemo(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.block),
            title: Text('Icon, IconButton and RaisedButton Widget'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>IconWidgetDemo(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.list),
            title: Text('ListView Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => HorizontalListviewDemo(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('SnackBar Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SnackbarWidget(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('SwitchAndCheckbox Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SwitchAndCheckbox(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('logtest Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => logtest(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('listview Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ListView0(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('ScaffoldRoute Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ScaffoldRoute(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('DrawerTest Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DrawerTest(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('GridView'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => GridViewBuiderDemo(),
              ));
            },
          ),

          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('dialog Widget'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DialogDemo(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('therealdialog'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Dialog0(),
              ));
            },
          ),
        ],
      ),
        )
        ,
      )
    );
  }

}
class _state extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate()");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble()");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose()");
  }
}
