import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyStarterApp());
}

class MyStarterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _counter = 0;

  bool _showImage = true;

  _increaseCounter() {
    setState(() {
      _counter++;
    });
  }

  _decreaseCounter() {
    if (_counter > 0)
      setState(() {
        _counter--;
      });
    else
      showToast("value must be more than 0");
  }

  toggleImage(bool showImage) {
    setState(() {
      this._showImage = showImage;
    });
  }

  _getImage() {
    return _showImage ? Tab(icon: Icon(Icons.ac_unit_sharp)) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Hello World!',
                  style: Theme.of(context).textTheme.headline5),
            ),
            Text('This is my first Flutter application'),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    onPressed: _increaseCounter,
                    child: Icon(Icons.add),
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                SizedBox(width: 8),
                MaterialButton(
                  onPressed: _decreaseCounter,
                  child: Icon(Icons.remove),
                  color: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                )
              ],
            ),
            Switch(
              value: _showImage,
              onChanged: (value) => toggleImage(value),
            ),
            Center(
              child: _getImage(),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'say hello',
        onPressed: () {
          showToast("Hello World!");
        },
        label: Text('Say'),
        icon: Icon(Icons.message),
      ),
    );
  }

  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

}
