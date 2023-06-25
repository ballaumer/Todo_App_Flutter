import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/helper/api_response.dart';

import '../helper/global_functions.dart';

class TasksServices{

  // add tasks service
  Future<ApiResponse> addTasks({required String date,  required String name, required String desc}) async {
    Map<String, dynamic> object = {
      'taskName': name,
      'taskDesc': desc,
      'dateTime': date,
    };
    try {
      CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection("tasks");

      String documentId = fetchCurrentUserUid();
      await collectionRef.doc(documentId).set({
        'data': FieldValue.arrayUnion([object]),
      }, SetOptions(merge: true)); //

      print('Data added successfully!');
     return ApiResponse(data: true);
    } catch (error) {
      print('Error adding data: $error');
      return ApiResponse(data: false);
    }
  }


  // get  for particular user tasks
  Future<List<dynamic>> getTasks() async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection("tasks");

    try {
      String docId = fetchCurrentUserUid();
      DocumentSnapshot docSnapshot = await collectionRef.doc(docId).get();

      if (docSnapshot.exists) {
        dynamic data = docSnapshot.data();
        List<dynamic> arrayField = data['data'] ?? [];

        return arrayField;
      } else {
        print('Document does not exist.');
        return [];
      }
    } catch (error) {
      print('Error retrieving array field: $error');
      return [];
    }
  }



  // update particular tasks for a particular user
  Future<ApiResponse> updateTask({
    required int index,
    required String newName,
    required String newDesc,
    required String dateTime

  }) async {
    try {
      CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection("tasks");

      String documentId= fetchCurrentUserUid();
      // Get the document reference for the specific user
      DocumentReference<Map<String, dynamic>> docRef =
      collectionRef.doc(documentId);

      // Retrieve the existing list of tasks from the document
      DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef.get();
      List<dynamic> tasks = snapshot.data()?['data'];

      // Check if the index is valid
      if (index >= 0 && index < tasks.length) {
        // Modify the object with the desired changes
        Map<String, dynamic> updatedObject = {
          'taskName': newName,
          'taskDesc': newDesc,
          'dateTime': dateTime,
        };

        // Update the object in the list
        tasks[index] = updatedObject;

        // Update the list of tasks in the document
        await docRef.set({'data': tasks}, SetOptions(merge: true));

        print('Data updated successfully!');
        return ApiResponse(data: true);
      } else {
        print('Invalid index!');
        return ApiResponse(data: false);
      }
    } catch (error) {
      print('Error updating data: $error');
      return ApiResponse(data: false);
    }
  }



  // delete task for particular user
  Future<ApiResponse> deleteTask({required int taskIndex}) async {
    try {
      CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection("tasks");

      String userId = fetchCurrentUserUid();

      // Get the reference to the user's document
      DocumentReference<Map<String, dynamic>> userDocRef = collectionRef.doc(userId);

      // Fetch the document snapshot
      DocumentSnapshot<Map<String, dynamic>> userDocSnapshot = await userDocRef.get();

      // Check if the user document exists
      if (userDocSnapshot.exists) {
        // Get the data field (assuming it's an array) from the user document
        List<dynamic> tasks = userDocSnapshot.data()!['data'];

        // Check if the task index is valid
        if (taskIndex >= 0 && taskIndex < tasks.length) {
          // Remove the task from the array using the index
          tasks.removeAt(taskIndex);

          // Update the user document with the modified data
          await userDocRef.update({'data': tasks});

          print('Task deleted successfully!');
          return ApiResponse(data: true);
        } else {
          print('Invalid task index!');
          return ApiResponse(data: false);
        }
      } else {
        print('User document not found!');
        return ApiResponse(data: false);
      }
    } catch (error) {
      print('Error deleting task: $error');
      return ApiResponse(data: false);
    }
  }

}