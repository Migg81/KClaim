class Trip {
  Trip(
      {this.id,
      this.date,
      this.tripName,
      });
  int id;
  String date;
  String tripName;


  //  factory Trip.fromJson(Map<String, dynamic> json) {
  //   return Trip(
  //     id: json['userId'],
  //     date: json['Travel_Date'],
  //     tripName: json['Trip_Name'],
  //   );
  // }

  Trip.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['Trip_Id'];
    date = jsonMap['Travel_Date'];
    tripName = jsonMap['Trip_Name'];
  }
   
}



class Beer {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String image_url;

  Beer.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['id'],
    name = jsonMap['name'],
    tagline = jsonMap['tagline'],
    description = jsonMap['description'],
    image_url = jsonMap['image_url']; 
}