import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class EditData extends StatefulWidget {

  
  final List list;
  final int index;
  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;

  void editData(){
    var url = "http://10.0.3.2/my_store_flutter/editdata.php";
    http.post(url, body: {
      'id' : widget.list[widget.index]['id'],
      'itemcode' : controllerCode.text,
      'itemname' : controllerName.text,
      'price' : controllerPrice.text,
      'stock' : controllerStock.text,
    });
  }

  @override
    void initState() {
      controllerCode = TextEditingController(text: widget.list[widget.index]['item_code']);
      controllerName = TextEditingController(text: widget.list[widget.index]['item_name']);
      controllerPrice = TextEditingController(text: widget.list[widget.index]['price']);
      controllerStock = TextEditingController(text: widget.list[widget.index]['stock']);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
       body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerCode,
                  decoration: InputDecoration(
                    hintText: 'Item Code',
                    labelText: 'Item Code',
                  ),
                ),
                TextField(
                  controller: controllerName,
                  decoration: InputDecoration(
                    hintText: 'Item Name',
                    labelText: 'Item Name',
                  ),
                ),
                TextField(
                  controller: controllerPrice,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: controllerStock,
                  decoration: InputDecoration(
                    hintText: 'Stock',
                    labelText: 'Stock',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                RaisedButton(
                  child: Text('Update Data'),
                  color: Colors.orange,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Home()
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}