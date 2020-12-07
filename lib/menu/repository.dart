import 'package:http/http.dart' as http;
import 'menu.dart';
import 'dart:convert';

class Repository {
  final _baseUrl = 'http://resturant.themepixelbd.com/index.php';

  // bool noMoredata = false;
  // bool noMoredataOnce = false;

  Future<List<Menu>> fetchNotes(int id) async {
    var map = Map<String, dynamic>();
    map['action'] = "GET_ALL_MENU";
    map['pageno'] = id.toString();
    final response = await http.post(_baseUrl, body: map);
    print("value...........$id");
    print("response${response.body.toString()}");

    if (response.body.toString().contains("error")) {
      // noMoredata = true;
      // noMoredataOnce = true;
      print("index2error");
      // setState(() {
      //   noMoredata = true;
      //   noMoredataOnce = true;
      //   print("index2error");
      // });
    }
    var notesJson;
    var notes = List<Menu>();

    if (response.statusCode == 200) {
      notesJson = json.decode(response.body);

      // setState(() {
      //   notesJson = json.decode(response.body);
      // });

      for (var noteJson in notesJson) {
        notes.add(Menu.fromJson(noteJson));
      }
    }

    print(id);
    return notes;
  }
}
