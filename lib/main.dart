import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './detail.dart';
import './adddata.dart';

void main() {
  runApp(MaterialApp(
    title: 'My Store',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    //class getdata
    final response =
        await http.get("http://10.0.3.2/my_store_flutter/getdata.php");
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Store'),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_to_queue),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context)=> AddData(),
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: getData(), //panggil class dari getdata
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(3),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                      list: list,
                      index: i,
                    ))),
            child: Card(
              child: ListTile(
                title: Text(list[i]['item_name']),
                leading: Icon(Icons.shop),
                subtitle: Text("Stock : ${list[i]['stock']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
