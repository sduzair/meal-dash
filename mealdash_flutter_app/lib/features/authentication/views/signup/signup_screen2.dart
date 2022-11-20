import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';

import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({Key? key}) : super(key: key);

  @override
  SignUpScreen2State createState() => SignUpScreen2State();
}

class SignUpScreen2State extends State<SignUpScreen2> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                context
                    .read<UserAuthViewModel>()
                    .resetSignUpState();
                GoRouter.of(context).goNamed(constants.signupRouteName);
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(constants.defaultPadding),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                // const SizedBox(height: Constants.defaultPadding * 2),
                TextFormField(
                  onSaved: (newValue) {
                    context
                        .read<UserAuthViewModel>()
                        .userSignUpModel
                        .firstName = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    hintText: "Enter your first name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    context.read<UserAuthViewModel>().userSignUpModel.lastName =
                        newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    hintText: "Enter your last name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    context
                        .read<UserAuthViewModel>()
                        .userSignUpModel
                        .phoneNumber = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Enter your phone number",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    context
                        .read<UserAuthViewModel>()
                        .userSignUpModel
                        .addressLine1 = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "Address line 1",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    context
                        .read<UserAuthViewModel>()
                        .userSignUpModel
                        .addressLine2 = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "Address line 2",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.location_on),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please enter your address";
                  //   }
                  //   return null;
                  // },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: constants.defaultPaddingSmall),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: IconTheme.of(context).color,
                      ),
                      const SizedBox(width: constants.defaultPadding),
                      Expanded(
                        child: CSCPicker(
                          layout: Layout.vertical,
                          defaultCountry: DefaultCountry.Canada,
                          disableCountry: true,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: Colors.grey),
                            shape: BoxShape.rectangle,
                          ),
                          onCountryChanged: (badRequiredField) {},
                          onStateChanged: (state) {
                            if (state != null && state.isNotEmpty) {
                              context
                                  .read<UserAuthViewModel>()
                                  .userSignUpModel
                                  .state = state;
                            }
                          },
                          onCityChanged: (city) {
                            if (city != null && city.isNotEmpty) {
                              context
                                  .read<UserAuthViewModel>()
                                  .userSignUpModel
                                  .city = city;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // TextFormField(
                //   onSaved: (newValue) {
                //     context.read<UserAuthViewModel>().userSignUpModel.city = newValue!;
                //   },
                //   decoration: const InputDecoration(
                //       labelText: "City",
                //       hintText: "Enter your city",
                //       floatingLabelBehavior: FloatingLabelBehavior.always,
                //       icon: Icon(Icons.location_city)),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please enter your city";
                //     }
                //     return null;
                //   },
                // ),
                // TextFormField(
                //   onSaved: (newValue) {
                //     context.read<UserAuthViewModel>().userSignUpModel.state = newValue!;
                //   },
                //   decoration: const InputDecoration(
                //       labelText: "State",
                //       hintText: "Enter your state",
                //       floatingLabelBehavior: FloatingLabelBehavior.always,
                //       icon: Icon(Icons.location_city)),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please enter your state";
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  onSaved: (newValue) {
                    context
                        .read<UserAuthViewModel>()
                        .userSignUpModel
                        .postalCode = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: "Postal Code",
                    hintText: "Enter your postal code",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.location_city),
                  ),
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
          SubmitButton(formKey: _formKey),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final userAuthVMWatch = context.watch<UserAuthViewModel>();
    if (userAuthVMWatch.isSigningUpSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).goNamed(constants.loginRouteName);
      });
      // * THIS IS DONE AFTER SIGNUP SUCCESS SNACKBAR IS SHOWN ON LOGIN PAGE
      // context.read<UserAuthViewModel>().resetSignUpStateAndNotifyListeners();
    }
    return Hero(
      tag: "signup_btn",
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          if (context.read<UserAuthViewModel>().isSigningUp ||
              context.read<UserAuthViewModel>().isSigningUpSuccess) {
            return;
          }
          // IF TESTING SIGNUP SIGNUP WITH DUMMY DATA THEN SKIP VALIDATION
          if (constants.isTestingSignUp) {
            context.read<UserAuthViewModel>().signUp();
            return;
          }
          // FORM VALIDATION AND SIGNUP
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            context.read<UserAuthViewModel>().signUp();
          }
        },
        child: const TextSignUpButton(),
        // ),
      ),
    );
  }
}

class TextSignUpButton extends StatelessWidget {
  const TextSignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authVMWatch = context.watch<UserAuthViewModel>();
    if (authVMWatch.isSigningUp) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    } else if (authVMWatch.isSigningUpError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(authVMWatch.signUpErrorMessage!),
            leading: const CircleAvatar(child: Icon(Icons.error)),
            actions: [
              if (authVMWatch.isSigningUpErrorUserAlreadyExists)
                TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  context
                      .read<UserAuthViewModel>()
                      .resetSignUpState();
                  GoRouter.of(context).goNamed(constants.loginRouteName);
                },
                child: const Text("SIGN IN"),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  context
                      .read<UserAuthViewModel>()
                      .resetSignUpStateAndNotifyListeners();
                },
                child: const Text("CLOSE"),
              ),
            ],
          ),
        );
      });
      return const Text("SIGNUP ERROR TRY AGAIN");
    } else if (authVMWatch.isSigningUpSuccess) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } else {
      return const Text("SIGN UP");
    }
  }
}
