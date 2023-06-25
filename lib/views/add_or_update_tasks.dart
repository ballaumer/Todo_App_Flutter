import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/colors.dart';
import 'package:date_field/date_field.dart';
import 'package:todo/utils/navigator.dart';

import '../controllers/add_update_tasks_controller.dart';
import '../utils/textfield.dart';
import '../utils/textstyle.dart';

class AddOrUpdateUi extends StatefulWidget {
  AddOrUpdateUi({super.key, this.index});

  int? index;

  @override
  State<AddOrUpdateUi> createState() => _AddOrUpdateUiState();
}

class _AddOrUpdateUiState extends State<AddOrUpdateUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AddorUpdateTasksController>(
            builder: (context, provider, child) => Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navi.navigateBack(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.secondaryColor,
                          size: 25,
                        ),
                      ),
                      Text(
                        widget.index != null
                            ? "UPDATE EXISTING THING"
                            : "Add new thing",
                        style: textStyles(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      ),
                      Icon(
                        Icons.tune_rounded,
                        color: AppColors.secondaryColor,
                        size: 25,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: AppColors.backGroundColor,
                      child: Icon(
                        Icons.design_services_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  textFormField(
                      hintText: "Name of the task",
                      controller: provider.taskNameController),
                  SizedBox(
                    height: 10,
                  ),
                  textFormField(
                      hintText: "Description",
                      controller: provider.taskDescController),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimeFormField(
                    initialValue: provider.dateTime,
                    initialDate: provider.dateTime,
                    decoration: InputDecoration(
                      hintStyle: textStyles(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: UnderlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      hintText: 'Set Date&Time',
                    ),
                    mode: DateTimeFieldPickerMode.dateAndTime,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (DateTime value) {
                      print(value);
                      provider.dateTime = value;
                      provider.notifyListeners();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                   if(provider.taskNameController.text.isEmpty || provider.taskDescController.text.isEmpty||provider.dateTime == null){
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text('Please fill all fields'),
                       ),
                     );
                   }else{
                     if (widget.index != null) {
                       provider.updateTask(
                           index: widget.index!, context: context);
                     } else {
                       provider.addTasks(context);
                     }
                   }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                              widget.index != null
                                  ? "UPDATE YOUR THING"
                                  : "ADD YOUR THING",
                              style: textStyles(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
