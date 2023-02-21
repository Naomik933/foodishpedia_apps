import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:get/get.dart';

class ProfileWid extends StatelessWidget {
  final authConn = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: !context.isPhone
          ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 150,
                      foregroundImage:
                          NetworkImage(authConn.auth.currentUser!.photoURL!),
                    ),
                  ),
                ),
                // SizedBox(width: 20,),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authConn.auth.currentUser!.displayName!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        authConn.auth.currentUser!.email!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 100,
                      foregroundImage:
                          NetworkImage(authConn.auth.currentUser!.photoURL!),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    authConn.auth.currentUser!.displayName!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    authConn.auth.currentUser!.email!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
