import 'package:flutter/material.dart';
import 'package:restfull_api/model/user_model.dart';
import 'package:restfull_api/service/user_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  bool? isLoading;

  List<Data?> users = [];

  @override
  void initState() {
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        isLoading = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (contex, index) {
            return isLoading == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : isLoading == true
                    ? ListTile(
                        title: Text(
                            "${users[index]!.firstName} + ${users[index]!.lastName}"),
                        subtitle: Text(users[index]!.email!),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index]!.avatar!),
                        ),
                      )
                    : Center(
                        child: Text("Eror"),
                      );
          },
        ),
      ),
    );
  }
}
