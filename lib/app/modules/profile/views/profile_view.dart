import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:foodishpedia_app/app/utils/widget/header.dart';
import 'package:foodishpedia_app/app/utils/widget/myFavorit.dart';
import 'package:foodishpedia_app/app/utils/widget/resepYouMayKnow.dart';
import 'package:foodishpedia_app/app/utils/widget/profileWid.dart';
import 'package:foodishpedia_app/app/utils/widget/sideBar.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final authConn = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _drawerKey,
          drawer: const SizedBox(width: 150, child: SideBar()),
          backgroundColor: AppColors.primaryBg,
          body: SafeArea(
            child: Row(
              children: [
                !context.isPhone
                    ? const Expanded(
                        flex: 2,
                        child: SideBar(),
                      )
                    : const SizedBox(),
                Expanded(
                  flex: 15,
                  child: Column(children: [
                    !context.isPhone
                        ? const header()
                        : Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _drawerKey.currentState!.openDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 40,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'FoodishPedia',
                                      style: TextStyle(
                                          height: 1.5,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.primaryText),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "Sign Out",
                                      content: const Text(
                                          "Are you sure want to sign out"),
                                      cancel: ElevatedButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel')),
                                      confirm: ElevatedButton(
                                          onPressed: () => authConn.logout(),
                                          child: const Text('Sign Out')),
                                    );
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Sign Out',
                                        style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Ionicons.log_out_outline,
                                        color: AppColors.primaryText,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    // content / isi page / screen
                    Expanded(
                      child: Container(
                        padding: !context.isPhone
                            ? const EdgeInsets.all(50)
                            : const EdgeInsets.all(20),
                        margin: !context.isPhone
                            ? const EdgeInsets.all(10)
                            : const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: !context.isPhone
                              ? BorderRadius.circular(50)
                              : BorderRadius.circular(30),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileWid(),
                              // const Text(
                              //   'My Favorite',
                              //   style: TextStyle(
                              //     color: Colors.grey,
                              //     fontSize: 25,
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              SizedBox(
                                height: 300,
                                child: MyFavorit(),
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
