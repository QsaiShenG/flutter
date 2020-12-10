
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework4/notebook.dart';
String filename,filedata,dir,filenameCopy; //获取名字和数据
int m;
class EditPage extends StatefulWidget{

  EditPage(){}
  EditPage.builderAdd(String str3){
    filename="addname";
    filedata="adddata";
    dir=str3;
    m=0;
    print("filename.lengh"+filename.length.toString());
  }
  EditPage.builderEdit(String str1,String str2,String str3){
    filename=str1;
    filenameCopy=str1;
    filedata=str2;
    dir=str3;
    m=1;
  }
  @override
  _EditPage createState() =>_EditPage();
}

class _EditPage extends State<EditPage>{
  TextEditingController nameCon;
  TextEditingController conCon;

  @override
  void initState() {
    super.initState();
    setState(() {

      nameCon=new TextEditingController(text: filename);
      conCon=new TextEditingController(text: filedata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                save();
                Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("保存成功"),)
                );
              }
            );
          },
          )
        ],
        title:TextFormField(
          controller: nameCon,
          onChanged: (v){
            filenameCopy=v;
            //print("检测变化:"+setName);
          },
          decoration: InputDecoration(
            labelText: "文件名",
            icon: Icon(Icons.insert_drive_file),
          ),
        ),
      ),
      body:TextFormField(

        maxLines: 20,
        controller: conCon,
        style: TextStyle(
          fontSize: 25,
        ),
        onChanged: (v){
        filedata=v;
        //print("检测变化:"+setCon);
        },
        decoration: InputDecoration(
        labelText: "内容",
        icon: Icon(Icons.content_paste),
        ),
      )
    );


  }
}
String getTitle(String str){
  int index1=-1,index2=-1;
  for(int i=0;i<str.length;i++){
    if(str[i]=='/') index1=i;
    if(str[i]=='.') index2=i;
  }
  return str.substring(index1+1,index2);
}
Future<bool> save()async{

  File file=await new File('$dir/noteDir/$filename.txt');
  File fileCopy=await new File('$dir/noteDir/$filenameCopy.txt');
  if(filename!=filenameCopy&&m==1){
    file.delete();
    if(fileCopy.exists()==null) fileCopy.create();
    await fileCopy.writeAsString(filedata);
  }
  else{
    if(fileCopy.exists()==null) file.create();
    await fileCopy.writeAsString(filedata);
  }
  return true;
}
