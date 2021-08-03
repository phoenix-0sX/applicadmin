import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:startup_namer/pages/login.dart';
import 'package:startup_namer/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_table/json_table.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String id = '';
  String name = '';
  String email = '';
  String fonction = '';
  String age = '';
  var json = [];
  var tableColumns = [
    JsonTableColumn("name", label: "Nom"),
    JsonTableColumn("email", label: "E-mail", defaultValue: "NA"),
    JsonTableColumn("function", label: "Fonction"),
    JsonTableColumn("age", label: "Age"),
  ];

  @override
  void initState(){
    dashboard();
    _loadUserData();
    super.initState();
  }
  
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    /* var userId = jsonDecode(localStorage.getString('user_id').toString());
    //var user = localStorage.getString('user');
    var userEmail = jsonDecode(localStorage.getString('user_email').toString());
    var userFonction = jsonDecode(localStorage.getString('user_fonction').toString());
    var userAge = jsonDecode(localStorage.getString('user_age').toString()); */

    setState(() {
      id = localStorage.getString('userId').toString();
      name = localStorage.getString('user').toString();
      email = localStorage.getString('userEmail').toString();
      fonction = localStorage.getString('userFonction').toString();
      age = localStorage.getString('userAge').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(id + '/' + name + '/' + email + '/' + fonction + '/' + age);
    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 7.0,
            bottom: TabBar(
              //indicatorColor: Colors.teal.shade300,
              indicator: BoxDecoration(
                //borderRadius: BorderRadius.circular(50), // Creates border
                color: Colors.teal.shade300,
              ),
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.all(0.0),
              labelStyle: TextStyle(
                fontSize: 10.0,
                letterSpacing: 2.0,
              ),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.info_outline,
                    size: 15,
                  ),
                  text: 'Info',
                  
                ),
                Tab(
                  icon: Icon(
                    Icons.list_alt_outlined,
                    size: 15,
                  ),
                  text: 'Listes',
                ),
              ],
            ),
            title: Text(
              'DEMO',
              style: TextStyle(
                color: Colors.teal[300],
                letterSpacing: 2.0,
              ),
            ),
            //toolbarHeight: 50.0,
            backgroundColor: Colors.black45,
          ),
          body: TabBarView(
            children: [
              Container(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 4 / 5,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [  
                      Center(  
                        child: Text(  
                          'INFO ADMINS CONNECTÉ',  
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),  
                        )
                      ),
                      SizedBox(height: 12.0,),  
                      Row(
                        children: [
                          Icon(Icons.assignment_ind),
                          Text(
                            'NOM',
                            style: TextStyle(
                              fontSize: 13.0, 
                              letterSpacing: 2.0, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Text(
                        '$name',
                        style: TextStyle(
                          fontSize: 11.0, 
                          letterSpacing: 1.0, 
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      //SizedBox(height: 20.0,),
                      Row(
                        children: [
                          Icon(Icons.work),
                          Text(
                            'FONCTION',
                            style: TextStyle(
                              fontSize: 13.0, 
                              letterSpacing: 2.0, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Text(
                        '$fonction',
                        style: TextStyle(
                          fontSize: 11.0, 
                          letterSpacing: 1.0, 
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 13.0, 
                              letterSpacing: 2.0, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Text(
                        '$age',
                        style: TextStyle(
                          fontSize: 11.0, 
                          letterSpacing: 1.0, 
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Icon(Icons.email),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 13.0, 
                              letterSpacing: 2.0, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Text(
                        '$email',
                        style: TextStyle(
                          fontSize: 11.0, 
                          letterSpacing: 1.0, 
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              ),
              Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[  
                  Center(  
                      child: Text(  
                        'LISTES DES ADMINISTRATEURS',  
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),  
                      )),
                  JsonTable(
                    json,
                    columns: tableColumns,
                    showColumnToggle: true,
                    tableHeaderBuilder: (var header) {
                      return Container(
                        padding: EdgeInsets.all(5.0),
                        height: 25.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.3),
                          color: Colors.black87,
                        ),
                        child: Text(
                          '$header',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300, 
                            fontSize: 10.0, 
                            color: Colors.teal[300],
                            letterSpacing: 2.0
                          ),
                        ),
                      );
                    },
                    tableCellBuilder: (value) {
                      return Container(
                        height: 30,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            )
                          ),
                        ),
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.0, 
                              color: Colors.grey[900],
                              letterSpacing: 1.0),
                        ),
                      );
                    },
                    allowRowHighlight: true,
                    rowHighlightColor: Colors.yellow[300]!.withOpacity(0.7),
                    paginationRowCount: 20,
                  ),  
                  /* DataTable(  
                    columns: [
                      DataColumn(label: Text(  
                          'Nom',  
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)  
                      )),  
                      DataColumn(label: Text(  
                          'Fonction',  
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)  
                      )),  
                    ],  
                    rows: [  
                      DataRow(cells: [  
                        DataCell(Text('Stephen',
                          style: TextStyle(fontSize: 10.0) )),  
                        DataCell(Text('Actor',
                          style: TextStyle(fontSize: 10.0) )),  
                      ]),  
                      DataRow(cells: [   
                        DataCell(Text('John',
                          style: TextStyle(fontSize: 10.0) )),  
                        DataCell(Text('Student',
                          style: TextStyle(fontSize: 10.0) )),   
                      ]),  
                      DataRow(cells: [  
                        DataCell(Text('Harry',
                          style: TextStyle(fontSize: 10.0) )),   
                        DataCell(Text('Leader',
                          style: TextStyle(fontSize: 10.0) )),  
                      ]),  
                      DataRow(cells: [  
                        DataCell(Text('Peter',
                          style: TextStyle(fontSize: 10.0) )),  
                        DataCell(Text('Scientist',
                          style: TextStyle(fontSize: 10.0) )),   
                      ]),  
                    ],  
                  ), */  
                ]),
              )  
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              logout();
            },
            child: Text("Logout"),
            backgroundColor: Colors.teal.shade300,
          ),
        ),
      ),
    );
  }

  void dashboard() async{

    var res = await Network().getData('/dashboard');
    var body = jsonDecode(res.body);
    //print(body);
    if(res.statusCode == 200){
      setState(() {
        json = body;
      });
    }
  }

  void logout() async{

    var res = await Network().logoutData('/logout');
    var body = jsonDecode(res.body);
    print(body);
    if(res.statusCode == 200){
      setState(() {
        id = '';
        name = '';
        email = '';
        fonction = '';
        age = '';
        json = [];
      });
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('userId');
      localStorage.remove('user');
      localStorage.remove('userEmail');
      localStorage.remove('userFonction');
      localStorage.remove('userAge');
      localStorage.remove('api_token');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>Login())
      );
    }
  }
}