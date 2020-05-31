import 'package:animation_practice/level1/uis/select_num_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String userName;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _getUserName("name").then((value) {
      setState(() {
        this.userName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Center(
            child: this.userName == null
                ? RaisedButton(
                    child: Text("register your  name"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (innerContext) {
                            return Container(
                              height: size.height * 0.5,
                              child: Dialog(
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      onChanged: (val) {
                                        setState(() {
                                          this.userName = val;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          errorText: this.errorMessage,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blueGrey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: 'enter your name here'),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        if (this.userName == "") {
                                          setState(() {
                                            this.errorMessage =
                                                "name can't be empty";
                                          });
                                        }
                                        _putUserName("name", this.userName);
                                        Navigator.pop(context);
                                      },
                                      child: Text("save my name"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  )
//              DefaultTextStyle.of(context).style
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: GoogleFonts.openSans(
                          fontSize: 34,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          this.userName + "\n",
                          style: GoogleFonts.openSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Image.asset(
                        "images/newlogo.png",
                        width: size.width * 0.3,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Number master",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      "is a game of numbers,you can select numbers and play with your selected numbers in various different ways."),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SelectNumber()));
                          },
                          child: Text("Let's kick off."),
                        ),
                      )
                    ],
                  )));
  }

  void _putUserName(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("user added sucessfully");
  }

  Future<String> _getUserName(userKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString(userKey);
    return name;
  }
}
