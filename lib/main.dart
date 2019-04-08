import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  runApp(MyApp());
}

final ThemeData kIOSThemeData = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kIDefaultThemeData = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;

Future<Null> _ensureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    user = await googleSignIn.signIn();
  }
  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credentials =
        await googleSignIn.currentUser.authentication;
    await auth.signInWithGoogle(
        idToken: credentials.idToken, accessToken: credentials.accessToken);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? kIOSThemeData
          : kIDefaultThemeData,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Chat App"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 4.0 : 0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[ChatMessage(), ChatMessage(), ChatMessage()],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              child: TextComposer(),
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
            )
          ],
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      child: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    this._isComposing = text.length > 0;
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar um mensagem"),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text("Enviar"),
                        onPressed: _isComposing ? () {} : null)
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _isComposing ? () {} : null))
          ],
        ),
      ),
      data: IconThemeData(color: Theme.of(context).accentColor),
    );
  }
}

class ChatMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://acuvate.com/wp-content/uploads/2017/04/IT-Helpdesk-Avatar-300x300.png")),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Thiago", style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text("Teste"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
