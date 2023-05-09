import 'package:api_sample_project/api.dart';
import 'package:api_sample_project/models.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _users = [];
  bool _loanding = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  _fetchUsers() async {
    setState(() {
      _loanding = true;
    });
    List<User>? users = await ApiService().getUsers();
    if (users != null) {
      setState(() {
        _users = users;
        _loanding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: _loanding
              ? CircularProgressIndicator()
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: _fetchUsers, child: Text("Re Fetch")),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            User _user = _users[index];
                            return ListTile(
                              leading: Icon(Icons.person),
                              title: Text(_user.name),
                              subtitle: Text("${_user.email}, ${_user.phone}"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
