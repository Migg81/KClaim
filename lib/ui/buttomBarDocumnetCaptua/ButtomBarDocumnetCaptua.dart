import 'dart:async';
import 'dart:io';
 
import 'package:flutter/material.dart';
 
//Image Plugin
import 'package:image_picker/image_picker.dart';

class ButtomBarDocumnetCaptua extends StatefulWidget {
  ButtomBarDocumnetCaptua({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ButtomBarDocumnetCaptua createState() => new _ButtomBarDocumnetCaptua();
}

class _ButtomBarDocumnetCaptua extends State<ButtomBarDocumnetCaptua> {

  File sampleImage;
 
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
 
    setState(() {
      sampleImage = tempImage;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new IconButton(
          icon: new Icon(Icons.camera_enhance),
          color: Colors.orange,
          tooltip: 'Choose camera',
          onPressed: (() {
            getImage();
            // Firestore.instance
            //   .runTransaction((Transaction transaction) async {
            // CollectionReference reference =
            //     Firestore.instance.document('users/User1').collection('Trips');

            // await reference.add({
            //   "Tripname": txtTripNameController.text,
            //   "TripStartDate": selectedDate,
            // });
            // txtTripNameController.clear();
            // });
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => TripScreen()),
            // );
          }),
        ),
         new IconButton(
          icon: new Icon(Icons.archive),
          color: Colors.orange,
          tooltip: 'Choose date',
          onPressed: (() {

            
          }),
          
        ),
        new IconButton(
          icon: new Icon(Icons.folder),
          color: Colors.orange,
          tooltip: 'Document',
          onPressed: (() {
            
          }),
        ),
      ],
    );
  }
}

// new SafeArea(
//         top: false,
//         bottom: false,
//         child: new Form(
//             key: _formKey,
//             autovalidate: true,
//             child: new ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               children: <Widget>[
//                 new TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.category),
//                     hintText: 'Enter your first and last name',
//                     labelText: 'Expence type',
//                   ),
//                 ),
//                 new TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.monetization_on),
//                     hintText: 'Enter your amount',
//                     labelText: 'Expence',
//                   ),
//                   keyboardType: TextInputType.datetime,
//                 ),
//                 new TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.phone),
//                     hintText: 'Enter a phone number',
//                     labelText: 'Phone',
//                   ),
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [
//                     WhitelistingTextInputFormatter.digitsOnly,
//                   ],
//                 ),
//                 new TextFormField(
//                   decoration: const InputDecoration(
//                     icon: const Icon(Icons.email),
//                     hintText: 'Enter a email address',
//                     labelText: 'Email',
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 new FormField(
//                   builder: (FormFieldState state) {
//                     return InputDecorator(
//                       decoration: InputDecoration(
//                         icon: const Icon(Icons.color_lens),
//                         labelText: 'Color',
//                       ),
//                       isEmpty: _color == '',
//                       child: new DropdownButtonHideUnderline(
//                         child: new DropdownButton(
//                           value: _color,
//                           isDense: true,
//                           onChanged: (String newValue) {
//                             setState(() {
//                               _color = newValue;
//                               state.didChange(newValue);
//                             });
//                           },
//                           items: _colors.map((String value) {
//                             return new DropdownMenuItem(
//                               value: value,
//                               child: new Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 new Container(
//                     padding: const EdgeInsets.only(left: 40.0, top: 20.0),
//                     child: new RaisedButton(
//                       child: const Text('Submit'),
//                       onPressed: null,
//                     )),
//               ],
//             )
//             ));
