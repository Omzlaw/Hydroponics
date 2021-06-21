import 'package:firebase_database/firebase_database.dart';

class Firebase {
  DatabaseReference ref;

  setRef() {
    ref = FirebaseDatabase.instance.reference();
    ref.keepSynced(true);
  }

  refData() {
    return ref;
  }

  updateData(String key, String value) {
    ref = FirebaseDatabase.instance.reference();
    ref.update({'$key': '$value'});
  }
}
