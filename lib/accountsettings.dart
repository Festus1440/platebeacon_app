import 'package:flutter/material.dart';
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
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('No'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.Yes),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
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
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 3.0),
                    child: GestureDetector(
                      child: Text(
                        "Delete Account",
                        semanticsLabel: tappedYes.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}