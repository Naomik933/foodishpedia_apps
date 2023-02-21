import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/routes/app_pages.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MyFavorit extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'My Favorites',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: authCon.getFavorit(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // get task id dari database user
                      // var myResep = (snapshot.data!.data()
                      //     as Map<String, dynamic>)['task_id'] as List;
                      var data = snapshot.data!.docs;

                      return context.isPhone
                          ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                var hasil = data[index].data();
                                return Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: const Image(
                                        image:
                                            AssetImage('assets/icons/icon.png'),
                                        height: 120,
                                        width: 220,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      hasil['title'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    // Text(
                                    //   data['descriptions'],
                                    //   style:
                                    //       const TextStyle(color: Colors.grey),
                                    // ),
                                  ],
                                );
                              },
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                // get data task
                                var hasil = data[index].data();

                                return Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: const Image(
                                        image:
                                            AssetImage('assets/icons/icon.png'),
                                        height: 130,
                                        width: 220,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      hasil['title'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    // Text(
                                    //   data['descriptions'],
                                    //   style:
                                    //       const TextStyle(color: Colors.grey),
                                    // ),
                                  ],
                                );
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
