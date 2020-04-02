import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //first app
    final wordPair = new WordPair.random();
    AppBar appBar = new AppBar(
        title: new Text("welcome to flutter")
    );
    final centerText = "hello world";
//    Center center = new Center(child: new Text(wordPair.asPascalCase));
//    Scaffold scaffold = new Scaffold(appBar:appBar, body: center);

    //添加一个有状态的部件
//    Center center = new Center(child: new RandomWords());
//    Scaffold scaffold = new Scaffold(appBar:appBar, body: center);

    //创建一个无线滚动的listview
    Scaffold scaffold = new Scaffold(body:  new Center(child: new RandomWords()));

    return new MaterialApp(
      title: "welcome to flutter",
      home: scaffold,
    );
  }
}


class RandomWords extends StatefulWidget {

  @override
  State createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair> [];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Startup Name Genetator"),
          actions: <Widget> [new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)]
      ),
      body: _buildSuggestions(),
    );
  }

  _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
              (pair) {
                return new ListTile(title: new Text(pair.asPascalCase, style: _biggerFont));
              },
          );
          final divider = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return new Scaffold(
            appBar: new AppBar(title: new Text("Saved Suggestions")),
            body: new ListView(children: divider),
          );
        }
      )
    );
  }

  Widget _buildSuggestions() {
    ListView listView = new ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i){
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(prefix0.generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
    return listView;
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

