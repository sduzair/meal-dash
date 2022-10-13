import 'package:flutter/material.dart';
import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/features/authentication/views/login/login_screen.dart';

import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class SignUpScreen2 extends StatefulWidget {
  final UserSignUpModel userSignUpModel;
  const SignUpScreen2({required this.userSignUpModel, Key? key})
      : super(key: key);

  @override
  SignUpScreen2State createState() => SignUpScreen2State();
}

class SignUpScreen2State extends State<SignUpScreen2> {
  final _formKey = GlobalKey<FormState>();
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
                  onSaved: (newValue) {
                    // widget.userSignUpModel.firstName = newValue!;
                  },
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
                  onSaved: (newValue) {
                    // widget.userSignUpModel.lastName = newValue!;
                  },
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
                  onSaved: (newValue) {
                    widget.userSignUpModel.phoneNumber = newValue!;
                  },
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
                  onSaved: (newValue) {
                    widget.userSignUpModel.addressLine1 = newValue!;
                  },
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
                  onSaved: (newValue) {
                    widget.userSignUpModel.addressLine2 = newValue!;
                  },
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
                  onSaved: (newValue) {
                    widget.userSignUpModel.city = newValue!;
                  },
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
                  onSaved: (newValue) {
                    widget.userSignUpModel.state = newValue!;
                  },
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
                  onSaved: (newValue) {
                    widget.userSignUpModel.postalCode = newValue!;
                  },
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
            child: SubmitButton(
                formKey: _formKey, userSignUpModel: widget.userSignUpModel),
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final UserSignUpModel userSignUpModel;

  const SubmitButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.userSignUpModel,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.read<UserAuthViewModel>().isSigningUp) {
          return;
        }
        if (!constants.isTestingSignUp && _formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return ;
          // }));
        }
        context.read<UserAuthViewModel>().signUp(userSignUpModel);
        if (context.read<UserAuthViewModel>().isSigningUpSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ),
          );
        }
      },
      // icon: const Icon(Icons.check_circle),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(constants.borderRadiusExtraLarge),
        ),
        elevation: constants.defaultElevation,
      ), 
      child: const TextSignUpButton(),
    );
  }
}

class TextSignUpButton extends StatelessWidget {
  const TextSignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserAuthViewModel>(
      builder: (context, userAuthViewModel, child) {
        if (userAuthViewModel.isSigningUp) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          );
        } else if (userAuthViewModel.isSigningUpError) {
          return const Text("SIGNUP ERROR TRY AGAIN");
        } else if (userAuthViewModel.isSigningUpSuccess) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          );
        } else {
          return const Text("SIGNUP");
        }
      },
    );
  }
}
