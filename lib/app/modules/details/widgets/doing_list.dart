import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extension.dart';
import 'package:getx_todo_list/app/modules/home/widgets/controller.dart';

class DoingList extends StatelessWidget {
  DoingList({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
            ? Column(
          children: [
            Image.asset('assets/images/addnotes.png',
            fit: BoxFit.cover,
            width: 60.0.wp,
            ),

          ],
        ):
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos.map((element) =>
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 3.0.wp,horizontal: 9.0.wp),
                  child: Row(
                    children: [
                      SizedBox(width: 20,height: 20,
                      child: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                        value: element['done'],
                        onChanged: (value){
                          homeCtrl.doneTodo(element['title']);
                        }
                      ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.0.wp),
                        child: Text(element['title'],
                            overflow: TextOverflow.ellipsis,),
                      ),

                    ],
                  ),
                )
                ).toList(),
                if(homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  )
              ],
            ),
    );
  }
}
