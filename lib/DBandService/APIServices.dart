import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kclaim/Model/Trip.dart';

Future<List<Trip>> getTripsforUser(userId) async {
  var tt =
      'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/users/$userId/trips';

  try {
    final response = await http.get(tt);

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
  } catch (e) {}
}

Stream<List<Trip>> getTripData() {
  return Stream.fromFuture(getTripsforUser(1));
}



Future<String> createPost(Trip post, userId) async {
  try {
    final response = await http.post(
        'https://hlm4mxc8wk.execute-api.ap-southeast-2.amazonaws.com/dev/users/$userId/trips',
        body:
            jsonEncode({'Trip_Name': post.tripName, 'Travel_Date': post.date}));
  //  // var result = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     getTripData();
  //   }
  } catch (e) {
    var tt = e;
  }

  return "Success";
}

class Trip_Name {}
// "Trip_Name":"Australia","Travel_Date"
