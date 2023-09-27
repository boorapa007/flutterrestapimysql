import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Profilelogin extends StatefulWidget {
  const Profilelogin({super.key});

  @override
  State<Profilelogin> createState() => _ProfileloginState();
}

class _ProfileloginState extends State<Profilelogin> {
  String loggedInUserName = "test"; // เปลี่ยนเป็นชื่อผู้ใช้ที่คุณต้องการ

  List<dynamic> users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Future<void> getUsers() async {
    const urlstr = "http://172.21.231.13/addressbook/select.php";

    final url = Uri.parse(urlstr);
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //Successful
      final json = response.body;
      final data = jsonDecode(json);
      debugPrint('Data: $data');
      setState(() {
        users = data;
      });
    } else {
      //Error
    }
  }

  Future delUser(username) async {
    var url = Uri.parse('http://172.21.231.13/addressbook/delete.php');
    var data = {};

    data['username'] = username;
    debugPrint('Delete: $username');
    var response = await http.post(
      url,
      body: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      debugPrint('Print Result: $result');
      if (result == "Success") {
        debugPrint('Delete Success');
        getUsers();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.home,
          color: Colors.purple,
        ),
      ),
      body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'บัญชีผู้ใช้',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Row(
      children: [
        IconButton(
  icon: Icon(Icons.edit),
  onPressed: () {
    // ใช้ Navigator สำหรับการนำทางไปยังหน้า /edit
    Navigator.pushNamed(context, '/edituser2');
  },
),
        Text(
          '$loggedInUserName',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  ],
)



    );
  }
}
