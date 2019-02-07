// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart';



// class pillButton extends StatefulWidget {
//   @override
//   _pillButtonState createState() => _pillButtonState();
// }

// class _pillButtonState extends State<pillButton> {
//   @override
//   Widget build(BuildContext context) {
//     return new DecoratedBox(
//                   decoration: new BoxDecoration(
//                       border: new Border.all(color: Colors.red.shade900),
//                       borderRadius: new BorderRadius.circular(30.0),
//                       color: Colors.red.shade900),
//                   child: _
//                 );
//   }
// }
// //  child: _createPillButton(
// //                     'FOLLOW',
// //                     '${widget.tripId}',
// //                     textColor: Colors.white70,
// //                   ),

// Widget cretePillButton()
// new DecoratedBox(
//                   decoration: new BoxDecoration(
//                       border: new Border.all(color: Colors.red.shade900),
//                       borderRadius: new BorderRadius.circular(30.0),
//                       color: Colors.red.shade900),
//                   child: _
//                 ),


// Widget _createPillButton(
//     String text,
//     String tripId, {
//     Color backgroundColor = Colors.red,
//     Color textColor = Colors.white70,
//   }) {
//     return new ClipRRect(
//       borderRadius: new BorderRadius.circular(40.0),
//       child: new MaterialButton(
//         minWidth: 140.0,
//         color: backgroundColor,
//         textColor: textColor,
//         onPressed: () async {
//           //final file = await _localFile;
//           if (text == 'EMAIL ME') {
//             // Write the file
//             await _pepairingCSVData(tripId);
//             await _uploadCSVToFireStore();
//           } else if (text == 'FOLLOW') {
//             //_uploadCSVToFireStore(file);
//           }
//         },
//         child: new Text(text),
//       ),
//     );
//   }