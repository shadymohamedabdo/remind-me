import 'package:firstapp/reminde%20_me/database.dart';
import 'package:firstapp/reminde%20_me/firstapp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class addtask extends StatefulWidget {
  const addtask({Key? key}) : super(key: key);
  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();

  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add your task'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title)
              ),
              controller: title,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              onTap: (){
                showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now()
                ).then((value) {
                  time.text = value!.format(context).toString();
                  print(value!.format(context));
                });
              },
              decoration: InputDecoration(
                  labelText: 'time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer)
              ),
              controller: time,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              onTap: (){
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.parse('2024-05-03'),
                ).then((value) {
                  date.text = DateFormat.yMMMd().format(value!);
                });
              },
              decoration: InputDecoration(
                  labelText: 'date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.watch_later)
              ),
              controller: date,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 30,
              color: Colors.green,
              child: MaterialButton(onPressed: ()async{
                int response = await sqlDb.insertData("INSERT INTO `tasks`('time','title' , 'date') VALUES ('${time.text}', '${title.text}' , '${date.text}' )");
                if (response>0){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Remind_me()), (route) => false);
                }
              },
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 20,
                      color: Colors.grey[200]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
