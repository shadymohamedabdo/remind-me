import 'package:firstapp/reminde%20_me/database.dart';
import 'package:firstapp/reminde%20_me/firstapp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class edittask extends StatefulWidget {
  final id;
  final title;
  final time;
  final date;
  const edittask({Key? key, this.id, this.title, this.time, this.date}) : super(key: key);
  @override
  State<edittask> createState() => _addtaskState();
}

class _addtaskState extends State<edittask> {

  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();

  SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    title.text = widget.title;
    time.text = widget.time;
    date.text = widget.date;

    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'edit your task'
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
                int response = await sqlDb.updateData('''
                  UPDATE `tasks` SET 
                  title = "${title.text}" ,
                  time = "${time.text}" ,
                  date = "${date.text}" 
                  WHERE id = ${widget.id}
                ''');
                if (response>0){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Remind_me()), (route) => false);
                }
                setState(() {

                });
              },
                child: Text(
                    'Edit Task',
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
