import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ResepYouMayKnow extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: authCon.getRekomendasi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.docs;
            return context.isPhone
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.antiAlias,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var hasil = data[index].data();
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image:
                                    const AssetImage('assets/icons/icon.png'),
                                height: Get.width * 0.4,
                                width: Get.width * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: -3,
                              left: 30,
                              child: Text(
                                hasil['title'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              right: -0.5,
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      authCon.addFriends(hasil['title']),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Icon(
                                    Ionicons.heart,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.antiAlias,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var hasil = data[index].data();
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image:
                                    const AssetImage('assets/icons/icon.png'),
                                height: Get.width * 0.1,
                                width: Get.width * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 30,
                              child: Text(
                                hasil['title'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 107,
                              right: 28,
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      authCon.addFriends(hasil['title']),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Icon(
                                    Ionicons.heart,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
