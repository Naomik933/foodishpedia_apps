import 'package:flutter/material.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:foodishpedia_app/app/utils/widget/header.dart';
import 'package:foodishpedia_app/app/utils/widget/myFavorit.dart';
import 'package:foodishpedia_app/app/utils/widget/resepYouMayKnow.dart';
import 'package:foodishpedia_app/app/utils/widget/sideBar.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../controllers/favorit_controller.dart';

class FavoritView extends GetView<FavoritController> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final authCon = Get.find<AuthController>();

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
                                    'Favorite',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.primaryText),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  radius: 25,
                                  foregroundImage: NetworkImage(
                                      authCon.auth.currentUser!.photoURL!),
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
                      child: !context.isPhone
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rekomendasi',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.grey),
                                ),
                                ResepYouMayKnow(),
                                const SizedBox(
                                  height: 100,
                                ),
                                MyFavorit(),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rekomendasi',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.grey),
                                ),
                                ResepYouMayKnow(),
                                MyFavorit(),
                              ],
                            ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
