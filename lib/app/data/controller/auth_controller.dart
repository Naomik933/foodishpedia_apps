import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodishpedia_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? _userCredential;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController searchFriendsController,
      titleController,
      descriptionsController,
      bahanController,
      tutorialController;

  @override
  void onInit() {
    super.onInit();
    searchFriendsController = TextEditingController();
    titleController = TextEditingController();
    descriptionsController = TextEditingController();
    bahanController = TextEditingController();
    tutorialController = TextEditingController();
    // dueDateController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchFriendsController.dispose();
    titleController.dispose();
    descriptionsController.dispose();
    bahanController.dispose();
    tutorialController.dispose();
    // dueDateController.dispose();
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print(googleUser!.email);
    // Once signed in, return the UserCredential
    await auth
        .signInWithCredential(credential)
        // .then((value) => Get.offAllNamed(Routes.HOME));
        .then((value) => _userCredential = value);

    // firebase
    CollectionReference users = firestore.collection('users');

    final cekUsers = await users.doc(googleUser.email).get();
    if (!cekUsers.exists) {
      users.doc(googleUser.email).set({
        'uid': _userCredential!.user!.uid,
        'name': googleUser.displayName,
        'email': googleUser.email,
        'photo': googleUser.photoUrl,
        'createdAt': _userCredential!.user!.metadata.creationTime.toString(),
        'lastLoginAt':
            _userCredential!.user!.metadata.lastSignInTime.toString(),
      }).then((value) async {
        String temp = '';
        try {
          for (var i = 0; i < googleUser.displayName!.length; i++) {
            temp = temp + googleUser.displayName![i];
            await users.doc(googleUser.email).set({
              'list_cari': FieldValue.arrayUnion([temp.toUpperCase()])
            }, SetOptions(merge: true));
          }
        } catch (e) {
          print(e);
        }
      });
    } else {
      users.doc(googleUser.email).update({
        'lastLoginAt':
            _userCredential!.user!.metadata.lastSignInTime.toString(),
      });
    }
    Get.offAllNamed(Routes.HOME);
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  var kataCari = [].obs;
  var hasilPencarian = [].obs;
  void searchFriends(String keyword) async {
    CollectionReference resep = firestore.collection('task');

    if (keyword.isNotEmpty) {
      final hasilQuery = await resep
          .where('list_cari', arrayContains: keyword.toUpperCase())
          .get();

      if (hasilQuery.docs.isNotEmpty) {
        for (var i = 0; i < hasilQuery.docs.length; i++) {
          kataCari.add(hasilQuery.docs[i].data() as Map<String, dynamic>);
        }
      }

      if (kataCari.isNotEmpty) {
        hasilPencarian.value = [];
        kataCari.forEach((element) {
          print(element);
          hasilPencarian.add(element);
        });
        kataCari.clear();
      }
    } else {
      kataCari.value = [];
      hasilPencarian.value = [];
    }
    kataCari.refresh();
    hasilPencarian.refresh();
  }

  void addFriends(String _resepFavorit) async {
    CollectionReference favorit = firestore.collection('favorit');
    final cekFavorit = await favorit.doc(auth.currentUser!.email).get();
    // cek data ada atau tidak
    if (cekFavorit.data() == null) {
      await favorit.doc(auth.currentUser!.email).set({
        'emailMe': auth.currentUser!.email,
        'resepFavorit': [_resepFavorit],
      }).whenComplete(() async {
        Get.snackbar("Favorit", "Favorit berhasil di tambah");
      });
    } else {
      await favorit.doc(auth.currentUser!.email).set({
        'resepFavorit': FieldValue.arrayUnion([_resepFavorit]),
      }, SetOptions(merge: true)).whenComplete(() async {
        Get.snackbar("Favorit", "Favorit berhasil di tambah");
      });
    }
    kataCari.clear();
    hasilPencarian.clear();
    searchFriendsController.clear();
    Get.back();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamFavorit() {
    return firestore
        .collection('favorit')
        .doc(auth.currentUser!.email)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUsers(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTask(String taskId) {
    return firestore.collection('task').doc(taskId).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRekomendasi() async {
    CollectionReference favoritCollec = firestore.collection('favorit');
    final cekFavorit = await favoritCollec.doc(auth.currentUser!.email).get();
    var listFavorit =
        (cekFavorit.data() as Map<String, dynamic>)['resepFavorit'] as List;
    QuerySnapshot<Map<String, dynamic>> hasil = await firestore
        .collection('task')
        .where('title', whereNotIn: listFavorit)
        .get();
    return hasil;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFavorit() async {
    CollectionReference favoritCollec = firestore.collection('favorit');
    final cekFavorit = await favoritCollec.doc(auth.currentUser!.email).get();
    var listFavorit =
        (cekFavorit.data() as Map<String, dynamic>)['resepFavorit'] as List;
    QuerySnapshot<Map<String, dynamic>> hasil = await firestore
        .collection('task')
        .where('title', whereIn: listFavorit)
        .get();
    return hasil;
  }

  void saveUpdateTask(String titel, String description, String bahan,
      String tutorial, String docId, String type) async {
    print(titel);
    print(description);
    print(bahan);
    print(tutorial);
    print(docId);
    print(type);
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    CollectionReference taskColl = firestore.collection('task');
    CollectionReference usersColl = firestore.collection('users');
    var taskId = DateTime.now().toIso8601String();
    if (type == 'Tambahkan') {
      await taskColl.doc(taskId).set({
        'title': titel,
        'descriptions': description,
        'bahan': bahan,
        'tutorial': tutorial,
        'asign_to': [auth.currentUser!.email],
        'created_by': auth.currentUser!.email,
      }).whenComplete(() async {
        await usersColl.doc(auth.currentUser!.email).set({
          'task_id': FieldValue.arrayUnion([taskId])
        }, SetOptions(merge: true)).then((value) async {
          String temp = '';
          try {
            for (var i = 0; i < titel.length; i++) {
              temp = temp + titel[i];
              await taskColl.doc(taskId).set({
                'list_cari': FieldValue.arrayUnion([temp.toUpperCase()])
              }, SetOptions(merge: true));
            }
          } catch (e) {
            print(e);
          }
        });
        Get.back();
        Get.snackbar('Resep', 'Berhasil Di $type');
      }).catchError((error) {
        Get.snackbar('Resep', 'Gagal Di $type');
      });
    } else {
      await taskColl.doc(docId).update({
        'title': titel,
        'descriptions': description,
        'bahan': bahan,
        'tutorial': tutorial,
      }).whenComplete(() async {
        // await usersColl.doc(authCon.auth.currentUser!.email).set({
        //   'task_id': FieldValue.arrayUnion([taskId])
        // }, SetOptions(merge: true));
        Get.back();
        Get.snackbar('Resep', 'Berhasil Di $type');
      }).catchError((error) {
        Get.snackbar('Resep', 'Gagal Di $type');
      });
    }
  }

  void deleteTask(String taskId) async {
    CollectionReference taskColl = firestore.collection('task');
    CollectionReference usersColl = firestore.collection('users');

    await taskColl.doc(taskId).delete().whenComplete(() async {
      await usersColl.doc(auth.currentUser!.email).set({
        'task_id': FieldValue.arrayRemove([taskId])
      }, SetOptions(merge: true));
      Get.back();
      Get.snackbar('Resep', 'Berhasil di hapus');
    });
  }
}
