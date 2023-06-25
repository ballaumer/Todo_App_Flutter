import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/colors.dart';
import '../controllers/add_update_tasks_controller.dart';
import '../controllers/auth_controller.dart';
import '../utils/navigator.dart';
import '../utils/textstyle.dart';
import 'add_or_update_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backGroundColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navi.navigateTo(context, AddOrUpdateUi());
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/backgroung.jpg",
                width: double.infinity,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.sort_rounded,
                              color: Colors.white, size: 30),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Your\nThings",
                            style: textStyles(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            "${DateFormat('MMMM d, yyyy').format(DateTime.now())} / ${DateFormat('h:mm a').format(DateTime.now())}",
                            style: textStyles(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 261,
                          color: Colors.black.withOpacity(0.4),
                          child: Stack(

                            children: [
                              Consumer<GoogleAuthController>(
                                builder:(context, pro, child) => Align(
                                    alignment:Alignment.topRight,
                                    child: InkWell(
                                      onTap: (){
                                        pro.signOut(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20,top:40),
                                        child: Icon(Icons.logout,color: Colors.white),
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "26",
                                          style: textStyles(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          "Personal",
                                          style: textStyles(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "27",
                                          style: textStyles(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          "Business",
                                          style: textStyles(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          Consumer<AddorUpdateTasksController>(
              builder: (context, provider, child) => provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: provider.taskList.isEmpty
                          ? Center(
                              child: Text(
                              "No Tasks Found",
                              style: textStyles(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ))
                          : ListView.builder(
                              itemCount: provider.taskList.length,
                              itemBuilder: (context, index) {
                                return   Dismissible(
                                  key: ValueKey(index),
                                  onDismissed: (direction) => provider.deleteTask(index: index, context: context),
                                  background: Center(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: AppColors.lightRed,
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.darkRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          provider.getParticularTask(id: index);
                                          Navigator.push(context, MaterialPageRoute(builder:(context)=>AddOrUpdateUi(index: index))).then((value) {
                                            provider.clearAll();
                                            provider.notifyListeners();
                                          });
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 30,
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.workspace_premium,
                                                color: AppColors.backGroundColor,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            provider.taskList[index]['taskName'],
                                            style: textStyles(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                            provider.taskList[index]['taskDesc'],
                                            style: textStyles(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          trailing: Text(
                                            "${DateFormat('h:mm a').format(DateTime.parse(provider.taskList[index]["dateTime"]))}\n${DateFormat('MMMM d, yyyy').format(DateTime.parse(provider.taskList[index]["dateTime"]))}",
                                            style: textStyles(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.grey),
                                          ),
                                          dense: true,
                                        ),
                                      ),
                                      const Divider(
                                        endIndent: 20,
                                        color: Colors.grey,
                                        indent: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                    )),
        ],
      ),
    );
  }
}
