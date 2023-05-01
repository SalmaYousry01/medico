import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../DatabaseUtils/medicine_database.dart';
import '../../basenavigator.dart';
import '../../models/my_medicine.dart';
import 'medicine_navigator.dart';

class MedicineViewModel extends BaseViewModel<MedicineNavigator> {
  // var auth = FirebaseAuth.instance;

  Future<void> AddOrUpdateMedicineToDB(String dosage, String name,) async {
    // final credential = await auth.getRedirectResult();
    try {
      var col = await DatabaseUtilsmedicine.getmedicineCollection().get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId = DatabaseUtilsmedicine.getmedicineCollection().doc();
        Mymedicine medicine = Mymedicine(
          id: docId.id,
          name: name,
          dosage: dosage,

        );
        await DatabaseUtilsmedicine.AddmedicineToFirestore(medicine);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        Mymedicine? medicine = col.docs[0].data();
        await DatabaseUtilsmedicine.Updateemedicinetofirestore(medicine);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }

  void UpdateMedicineToDB(String id, String name,String dosage,) {
    // final credential = await auth.getRedirectResult();
    Mymedicine medicine = Mymedicine(
      id: id,
      name: name,
      dosage: dosage,


    );
    // id: credential.user?.uid ?? ""

    DatabaseUtilsmedicine.AddmedicineToFirestore(medicine).then((value) {
      print("Clinic updated");
    }).catchError((error) {});
  }
}
