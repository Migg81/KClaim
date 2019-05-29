class Trip {
  Trip(
      {this.id,
      this.date,
      this.tripName,
      });
  int id;
  String date;
  String tripName;


  Trip.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['Trip_Id'];
    date = jsonMap['Travel_Date'];
    tripName = jsonMap['Trip_Name'];
  }
   
}
