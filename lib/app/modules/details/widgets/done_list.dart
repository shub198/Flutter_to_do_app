import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extension.dart';
import '../../home/widgets/controller.dart';

class DoneList extends StatelessWidget {
  DoneList({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
            () => homeCtrl.doneTodos.isNotEmpty
                ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 2.0.wp,horizontal: 5.0.wp),
                  child: Text('Completed(${homeCtrl.doneTodos.length})',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                  ),
                ),
                ...homeCtrl.doneTodos.map((element) =>
                    Dismissible(
                      key: ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                      background: Container(
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:  EdgeInsets.only(right: 5.0.wp),
                          child: const Icon(Icons.delete,color: Colors.white,),
                        ),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 3.0.wp,horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            const SizedBox(width: 20,height: 20,
                          child: Icon(Icons.done, color: Colors.blue,),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 4.0.wp),
                          child: Text(element['title'],
                          overflow: TextOverflow.ellipsis,
                            style: const TextStyle(decoration: TextDecoration.lineThrough,),
                          ),
                        )
                                          ],
                                        ),
                      ),
                    )
                ).toList()
              ],
            )
                : Container()
    );
  }
}
