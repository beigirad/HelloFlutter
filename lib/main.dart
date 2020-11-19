import 'dart:ui' as ui;

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
      routes: {PageA.routeName: (context) => PageA()},
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> with TickerProviderStateMixin {
  int _counter = 0;

  bool _showImage = true;

  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

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
    if (_showImage)
      controller.reverse();
    else
      controller.forward();

    setState(() {
      this._showImage = showImage;
    });
  }

  _getImage() {
    return FadeTransition(
        opacity: curve,
        child: FlutterLogo(
          size: 50,
        ));
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
            ),
            CustomPaint(
              painter: Message('Custom Painter'),
              size: Size(100, 100),
            ),
            CustomButton(label: 'Goto PageA')
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

class Message extends CustomPainter {
  String message;

  Message(String message) {
    this.message = message;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(100, 20)),
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 5);

    var textStyle = ui.TextStyle(color: Colors.deepPurple);
    var paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontStyle: FontStyle.normal))
      ..pushStyle(textStyle)
      ..addText(message);
    canvas.drawParagraph(
        paragraphBuilder.build()
          ..layout(ui.ParagraphConstraints(width: size.width)),
        Offset.zero);
  }

  @override
  bool shouldRepaint(covariant Message oldDelegate) {
    return oldDelegate.message != message;
  }
}

class CustomButton extends StatelessWidget {
  final String label;

  const CustomButton({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/a',
              arguments: PageAArguments('This message comes from main page'));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Text(label),
        ));
  }
}

class PageA extends StatelessWidget {
  static const routeName = '/a';

  @override
  Widget build(BuildContext context) {
    final PageAArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('PageA'),
      ),
      body: Center(
        child: Text(
          args.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class PageAArguments {
  final String message;

  PageAArguments(this.message);
}