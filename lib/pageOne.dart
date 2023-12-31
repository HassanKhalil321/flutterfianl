import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: pageone(),
  ));
}

class pageone extends StatefulWidget {
  const pageone({Key? key}) : super(key: key);

  @override
  State<pageone> createState() => _pageoneState();
}

class _pageoneState extends State<pageone> {
  List<Map<String, dynamic>> _allUsers = [];

  Future<List<Map<String, dynamic>>> getData() async {
    var url = "https://innumerous-sockets.000webhostapp.com/php/ff.php";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(red); // Return the fetched data
    }
    return []; // Return an empty list if data fetching fails
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the method to fetch data when the state initializes
  }

  void fetchData() async {
    List<Map<String, dynamic>> data =
    await getData(); // Fetch data asynchronously
    setState(() {
      _allUsers = data; // Update _allUsers with fetched data
      _foundUsers = _allUsers; // Initialize _foundUsers with all data
    });
  }

  Future<void> _launchUrl(String _url) async {
    if (!await canLaunch(_url)) {
      throw Exception('Could not launch $_url');
    } else {
      await launch(_url);
    }
  }

  List<Map<String, dynamic>> _foundUsers = [];

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers.where((user) {
        return user["Major"]
            .toString()
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Italy'),centerTitle: true ,backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(

                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(

                  key: ValueKey(_foundUsers[index]["Major"]),
                  color: Colors.purple,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        String _url = _foundUsers[index]["website"];
                        _launchUrl(_url);
                      },
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(
                              "${_foundUsers[index]["img"]}",
                            ),
                            width: 200,
                            height: 100,
                          ),
                          ListTile(
                            title: Text("${_foundUsers[index]["Major"]}"),
                            trailing: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("more info"),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.school_outlined,
                                        color: Colors.cyan,
                                      ),
                                      Text(
                                        " ${_foundUsers[index]["degree"]}",
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.cyan,
                                      ),
                                      Text(
                                        "${_foundUsers[index]["location"]}",
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.cyan,
                                      ),
                                      Text(
                                        "${_foundUsers[index]["duration"]}",
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  : const Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
