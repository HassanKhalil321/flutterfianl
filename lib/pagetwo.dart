import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: pagetwo(),
  ));
}

class pagetwo extends StatefulWidget {
  const pagetwo({Key? key}) : super(key: key);

  @override
  State<pagetwo> createState() => _pagetwoState();
}

class _pagetwoState extends State<pagetwo> {
  List<Map<String, dynamic>> _allUsers = [];

  Future<List<Map<String, dynamic>>> getData() async {
    var url = "https://innumerous-sockets.000webhostapp.com/php/f.php";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(red);
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Map<String, dynamic>> data = await getData();
    setState(() {
      _allUsers = data;
      _foundUsers = _allUsers;
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
        title: const Text('Search Listview'),
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
                  color: Colors.blue,
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
                  'No results found',
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
