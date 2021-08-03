import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:startup_namer/network_utils/api.dart';
import 'package:startup_namer/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_namer/pages/register.dart';
 
class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}
 
class _State extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController motDePasseController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final SnackBar _snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState!.showSnackBar(_snackBar);
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: _scaffoldKey,
        home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(/* 
            width: double.infinity,
            height: MediaQuery.of(context).size.height, */
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wall5.jpg"),
                fit: BoxFit.cover,
                //alignment: Alignment.topCenter,
              ),
            ),
            child: ListView(
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text(
                              'BIENVENUE !',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                letterSpacing: 2.0,
                              ),
                            )
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Admin',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                              ),
                            )
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/person.png'),
                              backgroundColor: Colors.transparent,
                              maxRadius: 35.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.0),
                  //color: Colors.transparent,
                  elevation: 0.0,
                  child: 
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              height: 40.0,
                              child: TextFormField(
                                controller: loginController,
                                focusNode: myFocusNode,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.grey[500],
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal.shade300, width: 2.0),
                                  ),
                                  labelText: 'Gmail',
                                  labelStyle: TextStyle(
                                    fontSize: 12.0,/* 
                                    color: myFocusNode.hasFocus ? Colors.blue : Colors.teal.shade300, */
                                  ),
                                ),
                                validator: (loginController) {
                                  if (loginController == null || loginController.isEmpty) {
                                    return 'Veuillez remplir votre email';
                                  }
                                  email = loginController;
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              height: 40.0,
                              child: TextFormField(
                                obscureText: true,
                                controller: motDePasseController,
                                focusNode: myFocusNode1,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.credit_card_sharp,
                                    color: Colors.grey[500],
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal.shade300, width: 2.0),
                                  ),
                                  labelText: 'Mot de passe',
                                  labelStyle: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                validator: (motDePasseController) {
                                  if (motDePasseController == null || motDePasseController.isEmpty) {
                                    return 'Veuillez entrer votre mot de passe';
                                  }
                                  password = motDePasseController;
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 40.0,
                              child: ElevatedButton.icon(
                                label: Text(_isLoading? 'En attente...' : 'Se Connecter',
                                          textDirection: TextDirection.ltr,
                                        ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.teal[300],
                                ),
                                onPressed: () {
                                  //Navigator.pushNamed(context, '/home');
                                  if (_formKey.currentState!.validate()) {
                                    _login();
                                  }
                                },
                                icon: Icon(
                                  Icons.login_outlined,
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: TextButton(
                          onPressed: (){
                            //forgot password screen
                          },
                          child: Text(
                            'Mot de passe oublier ?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color : Colors.black87,
                              letterSpacing: 1.0,
                              fontSize: 10.0,
                            ),
                          ),
                        )
                      ),
                      Expanded(
                        flex: 6,
                        child: SizedBox (width: 10.0,),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextButton(
                          child: Text(
                            'Sign Up ?',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 13.0,
                              color: Colors.teal.shade400,
                            ),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  )
                )
              ],
            ),
          ),
        )
      ),
    );
  }
  
  void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password
    };

    var res = await Network().authData(data, '/login');
    var body = jsonDecode(res.body);
    if(res.statusCode == 200 && body['api_token'] != null){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('api_token', json.encode(body['api_token']));
      localStorage.setString('userId', json.encode(body['id']));
      localStorage.setString('user', json.encode(body['name']));
      localStorage.setString('userEmail', json.encode(body['email']));
      localStorage.setString('userFonction', json.encode(body['function']));
      localStorage.setString('userAge', json.encode(body['age']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => Home()
          ),
      );
    }else{
      setState(() {
        _isLoading = false;
      });
      //print(body);
      _showMsg(body['error']);
    }

    setState(() {
      _isLoading = false;
    });

  }

}
