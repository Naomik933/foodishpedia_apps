import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodishpedia_app/app/data/controller/auth_controller.dart';
import 'package:foodishpedia_app/app/utils/style/AppColors.dart';
import 'package:get/get.dart';

addEditTask({BuildContext? context, String? type, String? docId}) {
  final authCon = Get.find<AuthController>();
  Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        margin: context!.isPhone
            ? EdgeInsets.zero
            : const EdgeInsets.only(left: 150, right: 150),
        // height: Get.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Form(
            key: authCon.formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(
                  '$type Resep',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nama Resep',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: authCon.titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  maxLength: 60,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    hintText: 'deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: authCon.descriptionsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Bahan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: authCon.bahanController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Tutorial',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: authCon.tutorialController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can not be empty';
                    }
                    return null;
                  },
                ),
                // DateTimePicker(
                //   firstDate: DateTime.now(),
                //   lastDate: DateTime(2100),
                //   dateLabelText: 'Due Date',
                //   decoration: InputDecoration(
                //     hintText: 'Due Date',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   controller: authCon.tutorialController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Can not be empty';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: Get.width, height: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      authCon.saveUpdateTask(
                        authCon.titleController.text,
                        authCon.descriptionsController.text,
                        authCon.bahanController.text,
                        authCon.tutorialController.text,
                        docId!,
                        type,
                      );
                    },
                    child: Text(type!),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    ),
  );
}
