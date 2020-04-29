import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
//import 'package:flutterapp/ShelterDrawer/restaurantDetails.dart';



enum DialogAction { Yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Deleting account'),
          content: Text('Are you sure you want to delete account?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('No',style: TextStyle(color: Colors.black)),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.Yes),
              child: const Text('Yes', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}

class AccountSettingsDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountSettingsDetails> {
  bool tappedYes = false;
  Color mainColor;

  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        if (user.displayName == "Shelter") {
          mainColor = Colors.blue;
        } else {
          mainColor = Colors.green;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      child: Text(
                        "Change Email",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 0.0,
                    endIndent: 0.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 3.0,left: 0.0,right: 15.0),
                    child: GestureDetector(
                      child: Text(
                        "Delete Account",
                        semanticsLabel: tappedYes.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        final action = await Dialogs.yesAbortDialog(
                            context, 'My Title', 'my Body');
                        var DialogActions;
                        if (action == DialogActions.yes) {
                          setState(() => tappedYes = true);
                        } else {
                          setState(() => tappedYes = false);
                        }
                      },
                    ),
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 0.5,
                    color:Colors.black,
                    indent: 0.0,
                    endIndent: 0.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}