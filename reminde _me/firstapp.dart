import 'package:firstapp/reminde%20_me/edittask.dart';
import 'package:flutter/material.dart';
import 'database.dart';
class Remind_me extends StatefulWidget {
  const Remind_me({Key? key}) : super(key: key);
  @override
  State<Remind_me> createState() => _firstappState();
}
class _firstappState extends State<Remind_me> {
  bool isloading = true;
  SqlDb sqlDb = SqlDb();
  List tasks = [];
  Future readData ()async{
    List<Map> response = await sqlDb.readData(" SELECT id,title,time,date FROM tasks ORDER BY date ASC ");
    tasks.addAll(response);
    isloading = false;
    if (this.mounted){
      setState(() {
      });
    }
  }
  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remembre'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('addtask');
        },
        child: Icon(Icons.add),
      ),
      body:
      isloading == true? Center(child: Text('loading',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),)) :
     ListView.builder(
       physics: BouncingScrollPhysics(),
         shrinkWrap: true,
         itemCount: tasks.length,
         itemBuilder: (context,i){
           return
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Card(
               child:
              ListTile(
                       leading:
                         ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.orange,
                               ),
                               onPressed: (){},
                               child: Text(
                                       '${tasks[i]['time']}',
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontWeight: FontWeight.bold,
                               ),
                             ),),
                       title:
                       FittedBox(
                         child: Column(
                           children: [
                             Text(
                               '${tasks[i]['title']}',
                               style: TextStyle(
                                 fontWeight: FontWeight.w900,
                                 fontSize: 30,
                               ),
                             ),
                             SizedBox(
                               height: 15,
                             ),
                             Text(
                               '${tasks[i]['date']}',
                               style: TextStyle(
                                   color: Colors.blue,
                                   fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                       ),
                       trailing:
                         FittedBox(
                           child:   Row(
                             children: [
                               IconButton(onPressed: ()async{
                                 int response = await sqlDb.deleteData(
                                     'DELETE FROM `tasks` WHERE id = ${tasks[i]['id']}'
                                 );
                                 if (response>0){
                                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Remind_me()), (route) => false);
                                 }
                                 setState(() {
                                 });
                               },
                                 icon: Icon(Icons.delete),
                                 color: Colors.red,),
                               IconButton(onPressed: (){
                                 setState(() {
                                 });
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=> edittask(
                                   title: tasks[i]['title'],
                                   time: tasks[i]['time'],
                                   date: tasks[i]['date'],
                                   id: tasks[i]['id'],
                                 )),);

                               },
                                 icon: Icon(Icons.edit),
                                 color: Colors.black,),
                             ],
                           ) ,
                         )
                     ),
             ),
           );

         }
     )
    );
  }
}
