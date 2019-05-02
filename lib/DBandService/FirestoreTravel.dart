// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kclaim/Model/traveldoc.dart';

// abstract class TravelDocDatabase {
//   //Future<void> createCounter();
//   //Future<void> setCounter(Counter counter);
//   Future<void> deleteTraveldoc(TravelDoc counter);
//   List<TravelDoc> traveldocs();
// }

// class FireStoreDatabase implements TravelDocDatabase {
//   FireStoreDatabase(this.rootPath);
//   String rootPath;
//   Future<void> deleteTraveldoc(TravelDoc traveldoc) async {
//     _documentReference(traveldoc).delete();
//   }


//   List<TravelDoc> traveldocs() {

// final FirebaseDatabase _database = FirebaseDatabase.instance;

//     Query _todoQuery = _database
//     .reference()
//     .child("todo")
//     .orderByChild("userId")
//     .equalTo(widget.userId);
//     // return _FirestoreStream<List<TravelDoc>>(
//     //   apiPath: rootPath,
//     //   parser: FirestoreCountersParser(),
//     // ).stream;
// // templist = collectionSnapshot.documents; // <--- ERROR

// // list = templist.map((DocumentSnapshot docSnapshot){
// //   return docSnapshot.data;
// // }).toList();
//  List<TravelDoc> doc=Firestore.instance.document(rootPath).snapshots().map((documentSnapshot){
//   return TravelDoc(
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
//     }).toList() as List<TravelDoc>;

// return doc;
// // var tt= new FirestoreCountersParser();
//     // CollectionReference collectionReference =
//     //     Firestore.instance.collection(rootPath);
//     // List<TravelDoc> snapshots = collectionReference.snapshots().map((s)=>s.documents.map((documentSnapshot){
//     //    return TravelDoc(
//     //       id: documentSnapshot.documentID,
//     //       amount: documentSnapshot['Amount'],
//     //       currency: documentSnapshot['Currency'],
//     //       date: documentSnapshot['Date'],
//     //       description: documentSnapshot['Description'],
//     //       devicePhysicalPath: documentSnapshot['DevicePhysicalPath'],
//     //       expenseCategory: documentSnapshot['ExpenseCategory'],
//     //       filePath: documentSnapshot['FilePath'],
//     //       receiptNo: documentSnapshot['Receipt No'],
//     //       paymnetMethod: documentSnapshot['Paymnet Method']);
//     // }).toList()
//     // );
//      //snapshots.map((snapshot) => tt.parse(snapshot)).toList() ;

// //final List<TodoItem> todos = collectionReference.documents.map(TodoStorage.fromDocument).toList(growable: false);
//     //new FirestoreCountersParser().parse(querySnapshot)
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
//     stream = snapshots.map((snapshot) => parser.parse(snapshot)) as T ;
//   }

//   T stream;
// }
