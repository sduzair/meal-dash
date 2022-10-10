import 'package:flutter/material.dart';
import 'package:mealdash_app/components/background.dart';

import 'package:mealdash_app/utils/constants.dart' as constants;

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({Key? key}) : super(key: key);

  @override
  SignUpScreen2State createState() => SignUpScreen2State();
}

class SignUpScreen2State extends State<SignUpScreen2> {
  final _formKey = GlobalKey<FormState>();
  // late final UserSignUpModel _userSignUpModel = UserSignUpModel();
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:
            AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]),
        body: Container(
          padding: const EdgeInsets.all(constants.defaultPadding),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                // const SizedBox(height: Constants.defaultPadding * 2),
                TextFormField(
                  // onSaved: (newValue) => {_userSignUpModel.email = newValue!},
                  decoration: const InputDecoration(
                      labelText: "First Name",
                      hintText: "Enter your first name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.account_circle)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "Last Name",
                      hintText: "Enter your last name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.account_circle)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter your phone number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "Address",
                      hintText: "Address line 1",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.location_on)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "Address",
                      hintText: "Address line 2",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.location_on)),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please enter your address";
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "City",
                      hintText: "Enter your city",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.location_city)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your city";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "State",
                      hintText: "Enter your state",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.location_city)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your state";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) => {},
                  decoration: const InputDecoration(
                      labelText: "Postal Code",
                      hintText: "Enter your postal code",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      icon: Icon(Icons.location_city)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your postal code";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        // resizeToAvoidBottomInset: false,
        persistentFooterButtons: [
          Hero(
            tag: "signup_btn",
            child: ElevatedButton.icon(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('SIGN UP'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(constants.borderRadiusExtraLarge),
                ),
                elevation: constants.defaultElevation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
