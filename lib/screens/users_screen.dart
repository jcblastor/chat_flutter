import 'package:flutter/material.dart';

import 'package:chat_app/models/models.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = [
    User(isOnline: true, email: 'test1@gmail.com', name: 'maria', uid: '1'),
    User(isOnline: false, email: 'test2@gmail.com', name: 'carlos', uid: '2'),
    User(isOnline: true, email: 'test3@gmail.com', name: 'toby', uid: '3'),
    User(isOnline: false, email: 'test4@gmail.com', name: 'mili', uid: '4'),
    User(isOnline: true, email: 'test5@gmail.com', name: 'olga', uid: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My name', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
          color: Colors.black54,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            // child: const Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _uploadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue.shade400,
        ),
        child: _listViewUsers(),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, int index) => const Divider(),
      itemBuilder: (_, int index) => _userListTile(users[index]),
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  // cargar usuarios
  _uploadUsers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
