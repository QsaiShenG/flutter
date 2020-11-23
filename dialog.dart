import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialog0 extends StatefulWidget{

  @override
  _Dialog0 createState() {
    return _Dialog0();
  }
}
class _Dialog0 extends State<Dialog0>{
  var picker0;
  var nowDate= new DateTime.now();
  var nowTime=new TimeOfDay.now();
  var timeOfIOS= new DateTime.now();
  Future<bool> _AlertDialog() async {
   await showDialog(
      context:context,
      builder: (BuildContext context){
        return  AlertDialog(
          title: Text("确定要删除文件？"),
          actions: <Widget>[
            FlatButton(
              child: Text("否"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("是"),
              onPressed: () {
                Navigator.of(context).pop(true);
                print("文件已删除");
              },
            )
          ],
        );
      }
    );
  }

  Future<bool> _SimpleDialog() async {
    int i=await showDialog(
      context: context,
      builder: (BuildContext context){
        return new SimpleDialog(
          title: Text("请选择语言"),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: ()=>Navigator.pop(context,1),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text("中文简体"),
              ),
            ),
            SimpleDialogOption(
              onPressed: ()=>Navigator.pop(context,2),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text("美国英语"),
              ),
            )
          ],

        );
      }
    );
    if(i!=null){
      print("选择了:${i==1?"中文简体":"美国英语"}");
    }
  }

  Future<void> _showDialogWithList()async {
    int index=await showDialog(
      context: context,
      builder: (BuildContext context){
        var child=Column(
          children: <Widget>[
            ListTile(
              title: Text("请选择"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    title: Text("$index"),
                    onTap: ()=>Navigator.of(context).pop(index),
                  );
                },
              ),
            )
          ],
        );
        return Dialog(child: child,);
      }
    );
    if(index!=null){
      print("你点击了$index");
    }
  }
  Future<DateTime> DatePicker()async{

    var picker=await showDatePicker(
      context: context,
      firstDate: nowDate.subtract(Duration(days: 15)),
      initialDate: nowDate,
      lastDate: nowDate.add(
          Duration(days: 30,)
      ),
    );
    setState(() {
      if(picker!=null) nowDate=picker;
    });
  }
  Future<TimeOfDay> TimePicker()async{
    var picker= await showTimePicker(
      context: context,
      initialTime: nowTime,

    );
    setState(() {
      if(picker!=null) nowTime=picker;
    });
  }

  Future<DateTime> DateOfIOS()async{
    var date=DateTime.now();
    var picker=await showCupertinoModalPopup(
      context: context,
      builder: (ctx){
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(Duration(days: 30)),
            maximumYear: date.year+1,
            onDateTimeChanged: (picker){
              setState(() {
                if(picker!=null) nowDate=picker;
              });
            },
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("DialogDemo"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("AlertDialog()Demo"),
            leading: Icon(Icons.insert_drive_file),
            onTap: ()=>_AlertDialog(),
          ),

          ListTile(
            title: Text("SimpleDialog()Demo"),
            leading: Icon(Icons.insert_drive_file),
            onTap: ()=>_SimpleDialog(),
          ),
          ListTile(
            title: Text("showDialog()With ListView.builder()"),
            leading: Icon(Icons.insert_drive_file),
            onTap: ()=>_showDialogWithList(),
          ),
          ListTile(
            title: InkWell(
              child: Text(formatDate(nowDate, [yyyy,'-',mm,'-',dd])),
              onTap: ()=>DatePicker(),
          ),
            leading: Icon(Icons.timer),
          ),
          ListTile(
            title: InkWell(
              child: Text(nowTime.format(context)),
              onTap: ()=>TimePicker(),
            ),
            leading: Icon(Icons.timer),

          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Row(
              children: <Widget>[
                InkWell(
                  child: Text(
                    formatDate(nowDate, [yyyy,'-',mm,'-',dd]),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  onTap: ()=>DatePicker(),
                ),
                Icon(Icons.arrow_drop_down),
                InkWell(
                  child: Text(
                    nowTime.format(context),
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 20,
                    ),
                  ),
                  onTap: ()=>TimePicker(),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

          ListTile(
            title: InkWell(
              child: Text(nowDate.toString()),
              onTap: ()=>DateOfIOS(),
            ),
            leading: Icon(Icons.timer),
          ),
        ],
      ),
    );
  }
}
