
import 'package:flutter/material.dart';
import 'package:app/view/data_model.dart';
//import 'package:app/view/data_model.g.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
const String dataBoxName = "data";

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum DataFilter {ALL, COMPLETED, PROGRESS}

class _MyHomePageState extends State<MyHomePage> {
  Box<DataModel>? dataBox;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DataFilter filter = DataFilter.ALL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBox = Hive.box<DataModel>(dataBoxName);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text("Flutter Hive Demo"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if(value.compareTo("All") == 0){
                setState(() {
                  filter = DataFilter.ALL;
                });
              }else if (value.compareTo("Compeleted") == 0){
                setState(() {
                  filter = DataFilter.COMPLETED;
                });
              }else{
                setState(() {
                  filter = DataFilter.PROGRESS;
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return ["All", "Compeleted", "Progress"].map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: dataBox.listenable(),

              builder: (context, Box<DataModel> items, _){

                List<int> keys;

                if(filter == DataFilter.ALL){
                  keys = items.keys.cast<int>().toList();
                }else if(filter == DataFilter.COMPLETED){
                  keys = items.keys.cast<int>().where((key) => items.get(key).complete).toList();
                }else{
                  keys = items.keys.cast<int>().where((key) => !items.get(key).complete).toList();
                }

                return ListView.separated(
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: keys.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:(_, index){
                    final int key = keys[index];
                    final DataModel data = items.get(key);
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blueGrey[200],
                      child: ListTile(
                        title: Text(data.title, style: TextStyle(fontSize: 22,color: Colors.black),),
                        subtitle: Text(data.description,style: TextStyle(fontSize: 20,color:Colors.black38)),
                        leading: Text("$key", style: TextStyle(fontSize: 18,color: Colors.black),),
                        trailing: Icon(Icons.check, color: data.complete ? Colors.deepPurpleAccent : Colors.red,),
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          color: Colors.blueAccent[100],
                                          child: Text("Mark as complete",style: TextStyle(color: Colors.black87),),
                                          onPressed: () {
                                            DataModel mData = DataModel(
                                                title: data.title,
                                                description: data.description,
                                                complete: true
                                            );
                                            dataBox.put(key, mData);
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                              );
                            },

                          );
                        },
                      ),
                    );
                  },

                );
              },
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context){
              return Dialog(
                  backgroundColor: Colors.blueGrey[100],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          controller: titleController,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Description"),
                          controller: descriptionController,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.red,
                          child: Text("Add Data",style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            final String title = titleController.text;
                            final String description = descriptionController.text;
                            titleController.clear();
                            descriptionController.clear();
                            DataModel data = DataModel(title: title, description: description, complete: false);
                            dataBox.add(data);
                            Navigator.pop(context);

                          },
                        )
                      ],
                    ),
                  )
              );
            },

          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}}