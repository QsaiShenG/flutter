import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homework4/main.dart';
import 'package:homework4/page/edit_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:date_format/date_format.dart';

String filename,filedata,dir; //传出到edit_page的
List<bool> _checkboxSelected=new List<bool>();//单选框表
List<String> notefilePaths=new List<String>();//文件路径列表
List<String> noteFileNames=new List<String>();//文件名列表
List<String> noteTimes=new List<String>();//文件最后修改日期表


class NoteBook extends StatefulWidget{
  @override
  _NoteBook createState() {
    return new _NoteBook();
  }
}
class _NoteBook extends State<NoteBook>{
   @override
   void initState() {

    // TODO: implement initState
    super.initState();
    filedata=null;
    filename=null;
    dir=null;
    noteFileNames.clear();
    notefilePaths.clear();
    noteTimes.clear();
    Future.delayed(Duration(milliseconds: 300),(){
      setState(() {
        _getLocalNoteFiles();
      });
    });
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notebook"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              filedata=null;
              filename=null;
              dir=null;
              noteFileNames.clear();
              notefilePaths.clear();
              noteTimes.clear();
              await _getLocalNoteFiles();
              setState(() {

              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              setState(() {
                deleteNote();
                for(int i=0;i<_checkboxSelected.length;i++){//解决未知BUG
                  _checkboxSelected[i]=false;
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()async{//warning 使用构造1
              print(noteFileNames.length);
              await getLocalPath();
              print("路径为："+dir);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage.builderAdd(dir)));
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));//跳转到主页
            },
          )

        ],
      ),
      body: ListView.builder (
        itemCount: noteFileNames.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: CircleAvatar(
              child: Text(noteFileNames[index][0]),
              backgroundColor: index%2==0?Colors.red:Colors.blue,
            ),
            subtitle: Text(noteTimes[index]),
            title: Text((noteFileNames[index])),
            trailing: Checkbox(
              value: _checkboxSelected[index],
              onChanged: (value){
                setState(() {
                  _checkboxSelected[index]=value;
                });
              },
            ),
            onTap: (){
              readFile(index);
              getLocalPath();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage.builderEdit(noteFileNames[index], filedata, dir)));
            },
          );
        },
      )
    );
  }



}

/*
得到文件列表
 */
void _getLocalNoteFiles() async{
  Directory dir=await _getLocalDataDir();
  try{
    var dirList=dir.list();
     await for(FileSystemEntity f in dirList){
       notefilePaths.add(f.path);
       noteFileNames.add(getTitle(f.path));
       _checkboxSelected.add(false);
        noteTimes.add(formatDate(new File(f.path).lastModifiedSync(), [yyyy,'-',mm,'-',dd,' ',hh,':',mm]));
    }
  }catch(e){
    print(e.toString());
  }
}
//
Future<Directory> _getLocalDataDir()async{
  String dir=(await getApplicationDocumentsDirectory()).path;
  Directory directory=Directory(dir+'/noteDir');
  try{
    bool exists= await directory.exists();
    if(!exists){
      await directory.create();
    }
    return directory;
  }catch(e){
    print(e);
  }
}
// void createNote()async{
//   dir=(await getApplicationDocumentsDirectory()).path;
//   File file=File('$dir/noteDir/$file.txt');
//   file.writeAsStringSync(content);//warning,创建新文件后写入数据;
//   if(file.create()==true) print("新文件创建成功");
//   print("新文件路径："+file.path);
//
// }
void deleteNote(){//删除文件路径列表和名字列表
  int i;
  String str;
  for(i=0;i<_checkboxSelected.length;i++){
    if(_checkboxSelected[i]==true){
      str=notefilePaths[i];
      File(str).delete();
      notefilePaths.removeRange(i, i+1);
      noteFileNames.removeRange(i, i+1);
      noteTimes.removeRange(i, i+1);
    }
  }
}
Future<void> readFile(int i)async{//获取文件数据
  File file= new File(notefilePaths[i]);
  print(file.path);
  print("获取文件路径为:"+notefilePaths[i]);
  filedata=await file.readAsStringSync();
  print(filedata);
}

String getTitle(String str){//从路径中得到文件名字
  int index1,index2;
  for(int i=0;i<str.length;i++){
   if(str[i]=='/') index1=i;
   if(str[i]=='.') index2=i;
  }
  return str.substring(index1+1,index2);
}

Future<String> getLocalPath()async{
  dir=(await getApplicationDocumentsDirectory()).path;
}



