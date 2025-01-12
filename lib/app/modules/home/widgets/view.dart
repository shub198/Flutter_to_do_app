import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_todo_list/app/core/utils/extension.dart';
import 'package:getx_todo_list/app/data/modles/task.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_card.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo_list/app/modules/home/widgets/controller.dart';
import 'package:getx_todo_list/app/modules/home/widgets/task_card.dart';
import 'package:getx_todo_list/app/modules/report/view.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Obx(
          () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(4.0.wp),
                    child: Text('My List',style: TextStyle(fontSize: 24.0.sp,fontWeight: FontWeight.bold),),
                  ),
                  Obx(()=> GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks.map((element) =>
                        LongPressDraggable(
                          data: element,
                          onDragStarted: ()=> controller.changeDeleting(true),
                          onDraggableCanceled: (_, __)=> controller.changeDeleting(false),
                          onDragEnd: (_)=> controller.changeDeleting(false),
                          feedback: Opacity(opacity: 0.8,
                            child:TaskCard(task: element,) ,
                          ),
                            child: TaskCard(task: element)
                        )
                        ).toList(),
                        AddCard()
                      ],
                    ),
                  )
                ],
              ),
          ),
            ReportPage(),
          ]
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __,___){
          return Obx (
                ()=> FloatingActionButton(
              onPressed: () {
                if(controller.tasks.isNotEmpty){
                  Get.to(() => AddDialog(),transition: Transition.downToUp);
                }else{
                  EasyLoading.showInfo('Please create your type');
                }
              },
              child:  Icon(controller.deleting.value ? Icons.delete : Icons.add,color: Colors.white,),
              shape: const CircleBorder(),
              backgroundColor: controller.deleting.value ? Colors.red : Colors.blueAccent,// Ensures the button is circular
            ),
          );
        },
        onAccept: (Task task){
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
            () => BottomNavigationBar(
            onTap: (int index){
              controller.changeTabIndex(index);
            },
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items:  [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                )
              ),
              BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding:  EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(Icons.data_usage),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}