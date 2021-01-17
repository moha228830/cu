import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/login_signup/forgot_password.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:passwordfield/passwordfield.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedCountryCode = "+965";
  List<String> _countryCodes = ['+02', '+965'];

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      margin: const EdgeInsets.all(3.0),
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {
              return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(fontSize: 12.0),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCountryCode = value;
              });
            },
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100.0),
                  Image.asset(
                    'assets/round_logo.png',
                    height: 80.0,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: width - 40.0,
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.color,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).translate('signupPage','usernameString'),
                              prefixIcon: Icon(Icons.perm_identity),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2, color: Colors.purple)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                          ),

                          child: new TextFormField(
                           // validator: (value) {
                            //  if (value.isEmpty) {
                              //  return 'Please enter some text';
                            //  }
                         //   },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(12.0),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(width: 2, color: Colors.purple)),
                                fillColor: Colors.white,
                                prefixIcon: countryDropDown,
                                hintText: AppLocalizations.of(context)
                                    .translate('loginPage', 'phone'),
                                labelText: AppLocalizations.of(context)
                                    .translate('loginPage', 'phone')),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).translate('loginPage','passwordString'),
                              prefixIcon: Icon(Icons.vpn_key),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2, color: Colors.purple)),
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                  BorderRadius.all(Radius.circular(20.0)),
                ),                child: PasswordField(


                  color: Colors.green,
                  hasFloatingPlaceholder: true,
                border: InputBorder.none,

                focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color: Colors.purple)),
                ),
              ),
                        SizedBox(
                          height: 30.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ForgotPasswordPage(
                                    )));
                          },
                          child: Container(
                            height: 45.0,
                            width: 190.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.redAccent,
                              color: Colors.red,
                              elevation: 7.0,
                              child: GestureDetector(
                                child: Center(
                                  child: Text(AppLocalizations.of(context).translate('loginPage','createAccountString'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Jost',
                                      fontSize: 16.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: LoginPage(
                                    )));
                          },
                          child: Text(AppLocalizations.of(context).translate('loginPage','loginString'),
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline6.color,
                              fontFamily: 'Jost',
                              fontSize: 17.0,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50.0),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
