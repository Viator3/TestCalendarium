import 'package:calendarium/pages/todo_home_page.dart';
import 'package:flutter/material.dart';

import 'Bloc/DatabaseBloc.dart';
import 'ClientModel.dart';

import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.cake)),
                Tab(icon: Icon(Icons.playlist_add_check)),
              ],
            ),
            title: Text('Calendarium'),
          ),
          body: TabBarView(
            children: [
              MyHomePage(title: 'Flutter Demo Home Page'),
              Text('ToDo'),// TodoHomePage(),
            ],
          ),
        ),
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _addNameController = TextEditingController();
  var _addDateController = TextEditingController();
  var _addCheckController = TextEditingController();

  var _client = Client();

  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: [
            FlatButton(
              color: Colors.red,
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                _client.firstName = _addDateController.text;
                _client.lastName = _addNameController.text;
                _client.blocked = true;
                bloc.add(_client);
              },
              child: Text('Save'),
            ),
          ],
          title: Text('Categories Form'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _addNameController,
                  decoration: InputDecoration(
                    hintText: 'Write a name',
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: _addDateController,
                  decoration: InputDecoration(
                    hintText: 'Write a date',
                    labelText: 'Date',
                  ),
                ),
                TextField(
                  controller: _addCheckController,
                  decoration: InputDecoration(
                    hintText: 'Write a check',
                    labelText: 'Check',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Client> testClients = [
    Client(firstName: "2021-04-25", lastName: "Rahiche", blocked: false),
    Client(firstName: "2021-04-28", lastName: "oun", blocked: true),
    Client(firstName: "2021-10-24", lastName: "Алексей", blocked: false),
  ];

  final bloc = ClientsBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter SQLite2"),
      ),
      body: StreamBuilder<List<Client>>(
        stream: bloc.clients,
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    bloc.delete(item.id);
                  },
                  child: ListTile(
                    horizontalTitleGap: 100,
                    title: Text(item.lastName),
                    // leading: Text(item.id.toString()),
                    leading: Text(item.firstName),
                    trailing: Text(datelast(item.firstName).toString()),
                    // trailing: Checkbox(
                    //   onChanged: (bool value) {
                    //     bloc.blockUnblock(item);
                    //   },
                    //   value: item.blocked,
                    // ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     Client rnd = testClients[math.Random().nextInt(testClients.length)];
      //     bloc.add(rnd);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  int datelast(date) {
    final birthday = DateTime.parse(date);
    final dateNow = DateTime.now();
    final newBirthday = new DateTime(dateNow.year, birthday.month, birthday.day);

    final difference = -dateNow.difference(newBirthday).inDays;
    if (difference >= 0) {
      return difference;
    } else {
      final newDate =
          new DateTime(newBirthday.year + 1, birthday.month, birthday.day);
      return -dateNow.difference(newDate).inDays;
    }
  }
}
