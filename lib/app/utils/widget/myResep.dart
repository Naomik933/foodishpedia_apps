import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/routes/app_pages.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:foodishpedia_app/app/utils/widget/prosesResep.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MyResep extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // stream users for get task list
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: authCon.streamUsers(authCon.auth.currentUser!.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // get task id
                  var taskId = (snapshot.data!.data()
                      as Map<String, dynamic>)['task_id'] as List;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: taskId.length,
                    clipBehavior: Clip.antiAlias,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: authCon.streamTask(taskId[index]),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            // data task
                            var dataTask = snapshot2.data!.data();
                            // data user photo
                            var dataUserList = (snapshot2.data!.data()
                                as Map<String, dynamic>)['asign_to'] as List;
                            return GestureDetector(
                              onDoubleTap: () {
                                Get.toNamed(Routes.DETAIL);
                              },
                              onLongPress: () {
                                Get.defaultDialog(
                                    title: dataTask['title'],
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                            onPressed: () {
                                              Get.back();
                                              authCon.titleController.text =
                                                  dataTask['title'];
                                              authCon.descriptionsController
                                                      .text =
                                                  dataTask['descriptions'];
                                              authCon.bahanController.text =
                                                  dataTask['bahan'];
                                              authCon.tutorialController.text =
                                                  dataTask['tutorial'];
                                              addEditTask(
                                                  context: context,
                                                  type: 'Ganti',
                                                  docId: taskId[index]);
                                            },
                                            icon: const Icon(Ionicons.pencil),
                                            label: const Text('Ganti')),
                                        TextButton.icon(
                                            onPressed: () {
                                              authCon.deleteTask(taskId[index]);
                                            },
                                            icon: const Icon(Ionicons.trash),
                                            label: const Text('Hapus')),
                                      ],
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                height: 145,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.cardBg,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/icons/icon.png'),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(12),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 0, 20),
                                                  child: Text(
                                                    dataTask!['title'],
                                                    style: const TextStyle(
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    dataTask['descriptions'],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            );
                          });
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
