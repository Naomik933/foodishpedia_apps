import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:foodishpedia_app/app/routes/app_pages.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        height: Get.height,
        color: AppColors.primaryBg,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //logo
              Container(
                height: 150,
                padding: const EdgeInsets.only(top: 30),
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: const Image(
                  image: AssetImage('assets/icons/icon.png'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                child: Center(
                  child: InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          decoration: Get.currentRoute == '/home'
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey,
                                )
                              : const BoxDecoration(),
                          child: Icon(
                            Get.currentRoute == '/home'
                                ? Ionicons.home
                                : Ionicons.home_outline,
                            color: AppColors.primaryText,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Home',
                          style: TextStyle(
                              color: AppColors.primaryText, fontSize: 16),
                        ),
                      ],
                    ),
                    onTap: () => Get.toNamed(Routes.HOME),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Center(
                    child: InkWell(
                  child: Column(children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: Get.currentRoute == '/resep'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey,
                            )
                          : const BoxDecoration(),
                      child: Icon(
                        Get.currentRoute == '/resep'
                            ? Ionicons.book
                            : Ionicons.book_outline,
                        color: AppColors.primaryText,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Resep',
                      style:
                          TextStyle(color: AppColors.primaryText, fontSize: 16),
                    ),
                  ]),
                  onTap: () => Get.toNamed(Routes.RESEP),
                )),
              ),
              SizedBox(
                height: 100,
                child: Center(
                    child: InkWell(
                  child: Column(children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: Get.currentRoute == '/favorit'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey,
                            )
                          : const BoxDecoration(),
                      child: Icon(
                        Get.currentRoute == '/favorit'
                            ? Ionicons.heart
                            : Ionicons.heart_outline,
                        color: AppColors.primaryText,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Favorite',
                      style:
                          TextStyle(color: AppColors.primaryText, fontSize: 16),
                    ),
                  ]),
                  onTap: () => Get.toNamed(Routes.FAVORIT),
                )),
              ),
              SizedBox(
                height: 100,
                child: Center(
                    child: InkWell(
                  child: Column(children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: Get.currentRoute == '/profile'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.grey,
                            )
                          : const BoxDecoration(),
                      child: Icon(
                        Get.currentRoute == '/profile'
                            ? Ionicons.person
                            : Ionicons.person_outline,
                        color: AppColors.primaryText,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Profile',
                      style:
                          TextStyle(color: AppColors.primaryText, fontSize: 16),
                    ),
                  ]),
                  onTap: () => Get.toNamed(Routes.PROFILE),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
