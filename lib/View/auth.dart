import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum FormMode { LOGIN, SIGNUP }

class Auth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Auth();
  }
}

class _Auth extends State<Auth> {
  String _email;
  String _password;
  bool _termsAccepted = false;
  bool _errorsPresent = false;
  bool userLoggedIn = false;
  String _errorMessage;
  bool _isLoading = false;

  final _formKey = new GlobalKey<FormState>();

  void _launchURL() async {
  const url = 'https://termsfeed.com/terms-conditions/326c2821e797d81cbcaeff104b0e2c68';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  void setUserStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("user", status);
  }

  void netWork() async {
    if (_errorsPresent == false &&
        _password != null &&
        _email != null &&
        _termsAccepted == true) {
      final Map successInfo = await signUp(_email, _password);

      if (successInfo["success"]) {
        setState(() {
          userLoggedIn = true;

          setUserStatus(true);
        });

        // Navigator.pop(context);
      } else {
        print(_password + _email);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Something's gone wrong"),
                content: Text(successInfo["message"]),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } else
      setState(() {
        _errorMessage = "Please fill all fields and accept terms";
      });

    print("errors");
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final http.Response res = await http.post(
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyABdIF7F-ch19OVorQKspJEiiMdoIECEOY",
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});

    print(json.decode(res.body)); //obtaining response

    var hasError = true;
    var message =
        "An error has occured, please check your email and password then try again";

    Map<String, dynamic> responseBody = json.decode(res.body);

    if (responseBody.containsKey("idToken")) {
      hasError = false;
      message = "Success";
    } else if (responseBody["error"]["message"] == "EMAIL_EXISTS") {
      message = "This email already exists";
    }

    setState(() {
      _isLoading = false;
    });

    return {"success": !hasError, "message": message};
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color:Theme.of(context).accentColor),
          title: new Text('Sign Up',style: TextStyle(color: Theme.of(context).accentColor),),
        ),
        body: Stack(
          children: <Widget>[
            userLoggedIn ? userSignedUp() : _showBody(),
          ],
        ));
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  _showLogo(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _confirmPasswordInput(),
                  _showErrorMessage(),
                  _showTermsAndConditions(),
                  _showPrimaryButton(),
                ],
              ),
            )));
  }

  Widget userSignedUp() {
    return Container(
        padding: EdgeInsets.all(50),
        child: ListView(children: <Widget>[ 
                  Image.asset('assets/logoNoBackground.png'),
                  Text(
                    "Thank you for signing up to be a part of Platter's CookBook. This part of the app is still under construction, but you will be the first to know when it becomes available!",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),
                  )
                ],
              ),
        );
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/logoNoBackground.png'),
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        onChanged: (value) {
          setState(() {
            _email = value;
          });
        },
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password (Min. 6 characters)',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
      ),
    );
  }

  Widget _confirmPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Confirm Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onChanged: (value) {
          if (value != _password) {
            setState(() {
              _errorMessage = "Passwords must match";
              _errorsPresent = true;
            });
          } else
            setState(() {
              _password = value;
              _errorMessage = null;
              _errorsPresent = false;
            });
        },
      ),
    );
  }

  Widget _showPrimaryButton() {
    return _isLoading
        ? CircularProgressIndicator(
          )
        : new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
            child: new MaterialButton(
              elevation: 5.0,
              minWidth: 200.0,
              height: 42.0,
              color: Colors.greenAccent,
              child: Text('Sign Up',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () {
                netWork();
              },
            ));
  }

  Widget _showTermsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Text(
            "Accept terms and conditions",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: _launchURL,
        ),
        Checkbox(
          activeColor: Colors.greenAccent,
          value: _termsAccepted,
          onChanged: (value) {
            setState(() {
              _termsAccepted = value;
            });
          },
        )
      ],
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
