import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setData(String path, Map<String, dynamic> data) async {
    await _db.doc(path).set(data, SetOptions(merge: true));
  }

  Future<DocumentSnapshot> getData(String path) async {
    return await _db.doc(path).get();
  }

  Stream<DocumentSnapshot> streamData(String path) {
    return _db.doc(path).snapshots();
  }

  Stream<QuerySnapshot> streamCollection(String path, {Query Function(Query)? query}) {
    if (query != null) {
      return query(_db.collection(path)).snapshots();
    }
    return _db.collection(path).snapshots();
  }

  Future<void> addDocument(String path, Map<String, dynamic> data) async {
    await _db.collection(path).add(data);
  }

  Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    await _db.doc(path).update(data);
  }
}
