import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:kclaim/Model/Trip.dart';
import 'package:kclaim/Model/TripExpense.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

Future<List<Trip>> getTripsforUser(userId) async {
  var apiURL =
      'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/users/$userId/trips';

  try {
    final response = await http.get(apiURL);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final items1 = json.decode(response.body);

      var list = items1['data'] as List;
      List<Trip> itemsList = list.map((i) => Trip.fromJSON(i)).toList();

      return itemsList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (e) {
    throw Exception('Network timeout');
  }
}

Stream<List<Trip>> getTrips(userId) {
  return Stream.fromFuture(getTripsforUser(userId));
}

Future<List<TripExpense>> getTripDocs(userId, tripId) async {
  try {
    var apiURL =
        'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/user/$userId/trips/$tripId/tripdocuments';

    final response = await http.get(apiURL);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final items1 = json.decode(response.body);

      var list = items1['data'] as List;
      List<TripExpense> itemsList =
          list.map((i) => TripExpense.fromMap(i)).toList();

      return itemsList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (e) {
    throw Exception('Network timeout');
  }
}

Stream<List<TripExpense>> getTripDocsStream(userId, tripId) {
  return Stream.fromFuture(getTripDocs(userId, tripId));
}

Future<String> addTripforUser(Trip post, userId) async {
  try {
    final response = await http.post(
        'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/users/$userId/trips',
        body:
            jsonEncode({'Trip_Name': post.tripName, 'Travel_Date': post.date}));
    // var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return "Success";
    }
  } catch (e) {
    return "Network timeout";
  }

  return "Success";
}

Future<String> addTripDoc(TripExpense traveldoc, userId) async {
  try {
    var postURL =
        'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/user/$userId/trips/${traveldoc.tripId}/tripdocuments';

    final response = await http.post(postURL,
        body: jsonEncode({
          'Amount': traveldoc.amount,
          'Date': traveldoc.date,
          'Description': traveldoc.description,
          'Device_Physical_Path': traveldoc.devicePhysicalPath,
          'Expense_Category': traveldoc.expenseCategory,
          'File_Path': traveldoc.filePath,
          'Payment_Method': traveldoc.paymnetMethod,
          'Receipt_Number': traveldoc.receiptNo,
          'Trip_Id': traveldoc.tripId
        }));

    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "Network timeout";
    }
  } catch (e) {
    return "Network timeout";
  }
}

Future<String> deleteTripDoc(
  int documentId,int tripId, int userId
) async {
  try {
    var postURL =
        'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/user/$userId/trips/$tripId/tripdocuments/$documentId';

    final response = await http.delete(postURL);
        // body: jsonEncode({
        //   'Amount': traveldoc.amount,
        //   'Date': traveldoc.date,
        //   'Description': traveldoc.description,
        //   'Device_Physical_Path': traveldoc.devicePhysicalPath,
        //   'Expense_Category': traveldoc.expenseCategory,
        //   'File_Path': traveldoc.filePath,
        //   'Payment_Method': traveldoc.paymnetMethod,
        //   'Receipt_Number': traveldoc.receiptNo,
        //   'Trip_Id': traveldoc.tripId
        // }));

    if (response.statusCode == 200) {
      return "Success";
    }
  } catch (e) {
    return "Network timeout";
  }
  return "Success";
}

Future<String> uploadTripRealtedFile(File uploadImageFile) async {
  try {
    var uploadURL =
        'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/user/trips/tripdocuments/image';


     var stream = new http.ByteStream(DelegatingStream.typed(uploadImageFile.openRead()));
      var length = await uploadImageFile.length();

      var uri = Uri.parse(uploadURL);

     var request = new http.MultipartRequest("PUT", uri);
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(uploadImageFile.path));
          //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      if (response.statusCode == 200) {
        return "Success";
      } else {
        return "Network timeout";
      }
    // Dio dio = new Dio();
    // FormData formdata = new FormData(); // just like JS
    // formdata.add("image",
    //     new UploadFileInfo(uploadImageFile, basename(uploadImageFile.path)));
    // dio
    //     .put(uploadURL,
    //         data: formdata,
    //         options: Options(
    //             method: 'PUT',
    //             responseType: ResponseType.json // or ResponseType.JSON
    //             ))
    //     .then((response) {
    //   if (response.statusCode == 200) {
    //     return "Success";
    //   } else {
    //     return "Network timeout";
    //   }
    // }).catchError((error) {
    //   return "Network timeout";
    // });
  } catch (e) {
    return "Network timeout";
  }
}
