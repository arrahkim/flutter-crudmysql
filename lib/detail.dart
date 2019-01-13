import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;
  Detail({this.list, this.index});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    var url = "http://10.0.3.2/my_store_flutter/deletedata.php";
    http.post(url, body:{
      'id' : widget.list[widget.index]['id']
    });
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Apakah anda yakin ingin menghapus '${widget.list[widget.index]['item_name']}' "),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            'Tidak',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () =>Navigator.pop(context),
        ),
        RaisedButton(
          child: Text(
            'Hapus',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.red,
          onPressed: (){
            deleteData();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext contaext)=> Home(),
              )
            );
          },
        ),
      ],
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.list[widget.index]['item_name']}"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                ),
                Text(
                  widget.list[widget.index]['item_name'],
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Code : ${widget.list[widget.index]['item_code']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Price : ${widget.list[widget.index]['price']}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Stock : ${widget.list[widget.index]['stock']}',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Edit'),
                      color: Colors.blue,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => EditData(
                                  list: widget.list,
                                  index: widget.index,
                                ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                    ),
                    RaisedButton(
                      child: Text('Hapus'),
                      color: Colors.red,
                      onPressed: () => confirm(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
