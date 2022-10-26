import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(secondTest());
}

class secondTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "secondTesting",
      home: SecondTesting(),
    );
  }
}

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
   required this.channel,
   required this.feeds,
  });

  Channel channel;
  List<Feed> feeds;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    channel: Channel.fromJson(json["channel"]),
    feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "channel": channel.toJson(),
    "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
  };
}

class Channel {
  Channel({
   required this.id,
   required this.name,
   required this.description,
   required this.latitude,
   required this.longitude,
   required this.field1,
   required this.field2,
   required this.field3,
   required this.field4,
   required this.field5,
   required this.field6,
   required this.field7,
   required this.field8,
   required this.createdAt,
   required this.updatedAt,
   required this.lastEntryId,
  });

  int id;
  String name;
  String description;
  String latitude;
  String longitude;
  String field1;
  String field2;
  String field3;
  String field4;
  String field5;
  String field6;
  String field7;
  String field8;
  DateTime createdAt;
  DateTime updatedAt;
  int lastEntryId;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    field1: json["field1"],
    field2: json["field2"],
    field3: json["field3"],
    field4: json["field4"],
    field5: json["field5"],
    field6: json["field6"],
    field7: json["field7"],
    field8: json["field8"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    lastEntryId: json["last_entry_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "field1": field1,
    "field2": field2,
    "field3": field3,
    "field4": field4,
    "field5": field5,
    "field6": field6,
    "field7": field7,
    "field8": field8,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "last_entry_id": lastEntryId,
  };
}

class Feed {
  Feed({
   required this.createdAt,
   required this.entryId,
   required this.field1,
  });

  DateTime createdAt;
  int entryId;
  String field1;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
    createdAt: DateTime.parse(json["created_at"]),
    entryId: json["entry_id"],
    field1: json["field1"] == null ? null : json["field1"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "entry_id": entryId,
    "field1": field1 == null ? null : field1,
  };
}

class SecondTesting extends StatelessWidget {
  const SecondTesting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Testing 2'),
    );

  }
}

