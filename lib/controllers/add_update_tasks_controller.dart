import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/tasks_services.dart';
import '../utils/navigator.dart';

class AddorUpdateTasksController extends ChangeNotifier {

   // Instance of service class
  TasksServices tasksServices = TasksServices();

  // text-field controller
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescController = TextEditingController();

  //date-time variable
  DateTime ?dateTime ;

  // list of tasks variable
  List taskList = [];

  // state manage variable
  bool isLoading = false;

  // state manage function
  loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  // add task function
  addTasks(context) async {
    loading();
    await tasksServices
        .addTasks(
            date: dateTime.toString(),
            name: taskNameController.text,
            desc: taskDescController.text)
        .then((value) {
      if (value.data == true) {
        clearAll();
        getTasks();
        Navi.navigateBack(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong'),
          ),
        );
      }
    });
    loading();
  }


  // get tasks for particular user
  getTasks()async{
    loading();
    await tasksServices.getTasks().then((value) {
      print(value);
      print("sdsd");
      taskList = value;
    });
    loading();
  }

// get-particular task
  getParticularTask({required int id}){
    taskNameController.text = taskList[id]["taskName"];
    taskDescController.text = taskList[id]["taskDesc"];
    dateTime = DateTime.parse(taskList[id]["dateTime"]);
  }

  // update a particular task

  updateTask({required int index, required BuildContext context})async{
    loading();
    await tasksServices.updateTask(index: index, newName: taskNameController.text, newDesc: taskDescController.text, dateTime: dateTime.toString())      .then((value) {
      if (value.data == true) {
        clearAll();
        getTasks();
        Navi.navigateBack(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong'),
          ),
        );
      }
    });
    loading();
  }


  // delete a particular task
  deleteTask({required int index, required BuildContext context})async{
    loading();
    await tasksServices.deleteTask(taskIndex:index).then((value) {
      if (value.data == true) {
        clearAll();
        getTasks();
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Something Went Wrong'),
        //   ),
        // );
      }
    });
    loading();
  }




  // clear controllers functions
  void clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
    dateTime = null;
  }



  AddorUpdateTasksController(){
    getTasks();
  }
}
