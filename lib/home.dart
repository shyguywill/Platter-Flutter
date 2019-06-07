import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import "./View/start_page.dart";

class Home extends StatefulWidget {
  final List myMeals;

  final Function load;

  final Function delete;

  final int userStreak;

  final Function displayStreak;

  Home(this.myMeals, this.load, this.delete, this.userStreak,
      this.displayStreak);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {
  void _launchMail(String toMailId, String subject, String body) async {
    //Launch mail app for feedback
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.account_circle,
                      ),
                      iconSize: 50,
                    ),
                    Text("User")
                  ],
                ),
              )),
            ),
            ListTile(
              onTap: () {
                LaunchReview.launch(
                    androidAppId: "com.theplatterapp.Platterfoodrecipes");
              },
              title: Text("Rate us"),
            ),
            ListTile(
              onTap: () {
                _launchMail("platter.product@gmail.com", "Feedback", "");
              },
              title: Text("Feedback"),
            ),
            ListTile(
              onTap: () {
                Share.share(
                    "Platter is an app which finds meals you can make with ingredients you've already got🥘 Available to download now📲 Download now to get started! Get it on Google Play: https://t.co/DaqDsyr0Yz Download on the Apple App Store: https://t.co/3bXT4Qms31");
              },
              title: Text("Share"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "platter",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: StartPage(widget.userStreak, widget.displayStreak, widget.myMeals,
          widget.load, widget.delete),
      floatingActionButton: Container(
          width: 200.0,
          height: 50.0,
          child: RawMaterialButton(
            child: Text(
              "Let's cook !",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            fillColor: Colors.greenAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5.0,
            onPressed: () {
              Navigator.pushNamed(context, "/search").then((value) {
                widget.load(key: 1);
              });
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
