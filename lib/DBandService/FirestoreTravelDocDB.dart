// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kclaim/Model/traveldoc.dart';

// abstract class TravelDocDatabase {
//   //Future<void> createCounter();
//   //Future<void> setCounter(Counter counter);
//   Future<void> deleteTraveldoc(TravelDoc counter);
//   Stream<List<TravelDoc>> traveldocStream();
// }

// class FireStoreDatabase implements TravelDocDatabase {
//   FireStoreDatabase(this.rootPath);
//   String rootPath;
//   Future<void> deleteTraveldoc(TravelDoc traveldoc) async {
//     _documentReference(traveldoc).delete();
//   }

//   Stream<List<TravelDoc>> traveldocStream() {
//     return _FirestoreStream<List<TravelDoc>>(
//       apiPath: rootPath,
//       parser: FirestoreCountersParser(),
//     ).stream;
//   }

//   DocumentReference _documentReference(TravelDoc doc) {
//     return Firestore.instance.collection(rootPath).document('${doc.id}');
//   }
// }

// abstract class FirestoreNodeParser<T> {
//   T parse(QuerySnapshot querySnapshot);
// }

// class FirestoreCountersParser extends FirestoreNodeParser<List<TravelDoc>> {
//   List<TravelDoc> parse(QuerySnapshot querySnapshot) {
//     var doc = querySnapshot.documents.map((documentSnapshot) {
//       return TravelDoc(
//           id: documentSnapshot.documentID,
//           amount: documentSnapshot['Amount'],
//           currency: documentSnapshot['Currency'],
//           date: documentSnapshot['Date'],
//           description: documentSnapshot['Description'],
//           devicePhysicalPath: documentSnapshot['DevicePhysicalPath'],
//           expenseCategory: documentSnapshot['ExpenseCategory'],
//           filePath: documentSnapshot['FilePath'],
//           receiptNo: documentSnapshot['Receipt No'],
//           paymnetMethod: documentSnapshot['Paymnet Method']);
//     }).toList();
//     doc.sort((lhs, rhs) => rhs.id.compareTo(lhs.id));
//     return doc;
//   }
// }

// class _FirestoreStream<T> {
//   _FirestoreStream({String apiPath, FirestoreNodeParser<T> parser}) {
//     CollectionReference collectionReference =
//         Firestore.instance.collection(apiPath);
//     Stream<QuerySnapshot> snapshots = collectionReference.snapshots();
//     stream = snapshots.map((snapshot) => parser.parse(snapshot));
//   }

//   Stream<T> stream;
// }
