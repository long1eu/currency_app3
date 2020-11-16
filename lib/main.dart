import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Currency app vers 0.01'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currencies = ['Ron', 'Dollar', 'Euro'];
  String _currentItemSelected = 'Dollar';
  String _currentItemSelected2 = 'Euro';
  double _amount;
  double _sum;

  String _convertAmount() {
    if (_amount == null) {
      return _sum.toString();
    }

    if (_currentItemSelected == 'Dollar') {
      final double ratio = _currentItemSelected2 == 'Euro' ? 0.85 : 4.12;
      _sum = _amount * ratio;
    }

    if (_currentItemSelected == 'Ron') {
      final double ratio = _currentItemSelected2 == 'Euro' ? 0.21 : 0.24;
      _sum = _amount * ratio;
    }

    if (_currentItemSelected == 'Euro') {
      final double ratio = _currentItemSelected2 == 'Dollar' ? 1.18 : 4.87;
      _sum = _amount * ratio;
    }

    return _sum.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  'amount',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(
                    () {
                      _amount = double.parse(value);
                    },
                  );
                },
                decoration: InputDecoration(hintText: ''),
              ),
            ],
          ),
          Container(
            color: Colors.blue,
            child: DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                      ),
                      Text(
                        dropDownStringItem,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(
                  () {
                    this._currentItemSelected = newValueSelected;
                  },
                );
              },
              value: _currentItemSelected,
            ),
          ),
          Container(
            color: Colors.blue,
            child: DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                      ),
                      Text(
                        dropDownStringItem,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  this._currentItemSelected2 = newValueSelected;
                });
              },
              value: _currentItemSelected2,
            ),
          ),
          FlatButton(
            color: Colors.blue,
            child: Container(
              width: 100,
              child: Text(
                'convert',
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(_convertAmount()),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('ok'),
                        onPressed: () {
                          _amount = 0.0;
                          Navigator.pop(context, null);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ]),
      ),
    );
  }
}