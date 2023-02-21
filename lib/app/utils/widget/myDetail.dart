import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/routes/app_pages.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:foodishpedia_app/app/utils/widget/prosesResep.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MyDetail extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // stream users for get task list
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Pilihan Resep',
          //   style: TextStyle(
          //     color: Colors.grey,
          //     fontSize: 30,
          //   ),
          // ),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: authCon.streamUsers(authCon.auth.currentUser!.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // get task id
                var taskId = (snapshot.data!.data()
                    as Map<String, dynamic>)['task_id'] as List;
                return context.isPhone
                    ? ListView.builder(
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
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          dataTask!['title'],
                                          style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/icons/icon.png'),
                                            width: 300,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 80,
                                      ),
                                      const Text(
                                        'Resep : ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        dataTask['bahan'],
                                      ),
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      const Text(
                                        'Cara membuat : ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        dataTask['tutorial'],
                                      ),
                                      SizedBox(
                                        height: 150,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      )
                    : ListView.builder(
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
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          dataTask!['title'],
                                          style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/icons/icon.png'),
                                            width: 300,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      const Text(
                                        'Resep : ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        dataTask['bahan'],
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      const Text(
                                        'Cara membuat : ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        dataTask['tutorial'],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      );
              }),
        ],
      ),
    );
  }
}
