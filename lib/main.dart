import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

// This project uses the carousel slider plugin to present a
// rotating display of images from unsplash collections.
void main() => runApp(MyApp());
// mapImpactType is a dictionary where the key is the unsplash
// collection id and the value is the number of images in the
// forest (3302326)
// oil (3947516)
// money (2364459)
// These images provide the backdrop for the impact section of
// the dashboard.
var mapImpactType = {3302326: 264, 3947516: 18, 2364459: 22};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
          child: CarouselSlider(
              items: [1].map((i) {
                return new Builder(
                  builder: (BuildContext context) {
                    return _impactImageWidget();
                  },
                );
              }).toList(),
              // TODO: CarouselSlider has interval set as const Duration.
              // the doc says I should be able to set this.  I went to the
              // code and changed for 10 seconds.  Would be much better to
              // be able to set the interval here.
              //interval: Duration(seconds:10),
              viewportFraction: 0.99,
              height: MediaQuery.of(context).size.height * 2 / 3,
              autoPlay: true)),
    );
  }

  Widget _impactImageWidget() {
    String urlString = _getCollectionURL();

    return new Container(
      //width: MediaQuery.of(context).size.width,
      margin: new EdgeInsets.symmetric(horizontal: 1.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage(urlString),
        ),
      ),
    );
  }

  String _getCollectionURL() {
    int randomImpactCollection = mapImpactType.keys
        .elementAt(new Random().nextInt(mapImpactType.length));
    int numImages = mapImpactType[randomImpactCollection];
    Random rnd = new Random();
    int randomImage = 1 + rnd.nextInt(numImages + 1);
    String urlString = "https://source.unsplash.com/collection/" +
        randomImpactCollection.toString() +
        "/400x400/?sig=" +
        randomImage.toString();
    print(urlString);
    return urlString;
  }
}
