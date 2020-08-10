import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vistas'),
      ),
      //backgroundColor: Color(0xff84FFFF),
      body: Stack(children: <Widget>[
        //_buildList(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /*            FlatButton(
              child: Text("asdasdassa"),
              onPressed: () {},
            ), */
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "alert"),
              child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("data/1.PNG"),
                            /* IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text("Esta es una carta") */
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "alert"),
              child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("data/1.PNG"),
                            /* IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text("Esta es una carta") */
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "alert"),
              child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("data/1.PNG"),
                            /* IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text("Esta es una carta") */
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "alert"),
              child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("data/1.PNG"),
                            /* IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text("Esta es una carta") */
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "alert"),
              child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("data/1.PNG"),
                            /* IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text("Esta es una carta") */
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "alert"),
              child: Card(
                elevation: 10.0,
                color: Colors.red,
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    color: Colors.green,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset("data/1.PNG"),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text("Esta es una carta")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ]),
    );
  }

/*   Widget _buildList() {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          elevation: 10.0,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Text("Esta es la card numero $i"),
          ),
        );
      },
    );
  } */
}
