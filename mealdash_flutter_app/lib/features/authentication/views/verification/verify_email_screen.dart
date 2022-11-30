import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mealdash_app/components/custombuttons.dart';
import 'package:mealdash_app/features/authentication/view_models/verify_email_view_model.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/components/background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String userEmail;
  const VerifyEmailScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  void setStateHasError(bool value) {
    setState(() {
      hasError = value;
    });
  }

  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyEmailViewModel = context.watch<VerifyEmailViewModel>();
    if (context.read<VerifyEmailViewModel>().isVerifyingEmailError) {
      textEditingController.clear();
      errorController?.add(ErrorAnimationType.shake);
    }
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
                GoRouter.of(context).goNamed(constants.welcomeRouteName);
              },
            ),
          ],
        ),
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    padding: const EdgeInsets.all(constants.defaultPadding),
                    children: <Widget>[
                      const SizedBox(height: constants.defaultPaddingLarge),
                      Text(
                        'Email Verification',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.headline4!.fontSize,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: constants.defaultPadding,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Enter the code sent to ",
                          children: [
                            TextSpan(
                              text: widget.userEmail,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontSize,
                              ),
                            ),
                          ],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize:
                                Theme.of(context).textTheme.bodyText1!.fontSize,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: constants.defaultPaddingLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: constants.defaultPaddingSmall,
                          horizontal: constants.defaultPaddingLarge,
                        ),
                        child: PinCodeTextField(
                          autovalidateMode: AutovalidateMode.disabled,
                          // backgroundColor: Theme.of(context).colorScheme.background,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            // color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          // blinkWhenObscuring: true,a
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 6) {
                              return "Please enter a valid code";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            activeColor: hasError ||
                                    verifyEmailViewModel.isVerifyingEmailError
                                ? Theme.of(context).errorColor
                                : Theme.of(context).colorScheme.onBackground,
                            inactiveColor: hasError ||
                                    verifyEmailViewModel.isVerifyingEmailError
                                ? Theme.of(context).errorColor
                                : Theme.of(context).highlightColor,
                            selectedColor: hasError ||
                                    verifyEmailViewModel.isVerifyingEmailError
                                ? Theme.of(context).errorColor
                                : Theme.of(context).colorScheme.onBackground,
                            errorBorderColor: Theme.of(context).errorColor,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: false,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            debugPrint("Completed");
                            if (context
                                    .read<VerifyEmailViewModel>()
                                    .isVerifyngEmail ||
                                context
                                    .read<VerifyEmailViewModel>()
                                    .isVerifyingEmailSuccess) {
                              return;
                            }
                            // IF TESTING
                            if (constants.isTestingEmailVerification) {
                              context
                                  .read<VerifyEmailViewModel>()
                                  .verifyEmail();
                              return;
                            }
                            // IF NOT TESTING
                            if (!formKey.currentState!.validate()) {
                              setStateHasError(true);
                              errorController?.add(
                                ErrorAnimationType.shake,
                              );
                            } else {
                              context
                                  .read<VerifyEmailViewModel>()
                                  .verifyEmailDTO
                                  .activationCode = int.tryParse(v) ?? 0;
                              context
                                  .read<VerifyEmailViewModel>()
                                  .verifyEmail();
                            }
                            // if (context
                            //         .read<VerifyEmailViewModel>()
                            //         .isVerifyngEmail ||
                            //     context
                            //         .read<VerifyEmailViewModel>()
                            //         .isVerifyingEmailSuccess) {
                            //   return;
                            // }
                            // formKey.currentState!.validate();
                            // context.read<VerifyEmailViewModel>().verifyEmail();
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              hasError = false;
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      // const SizedBox(
                      //   height: constants.defaultPaddingSmall,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Flexible(
                      //       child: TextButton(
                      //         child: const Text("Clear"),
                      //         onPressed: () {
                      //           textEditingController.clear();
                      //         },
                      //       ),
                      //     ),
                      //     Flexible(
                      //       child: TextButton(
                      //         child: const Text("Set Text"),
                      //         onPressed: () {
                      //           setState(() {
                      //             textEditingController.text = "123456";
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(
                    constants.defaultPadding,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontSize,
                            ),
                          ),
                          TextButton(
                            onPressed: () => {},
                            child: Text(
                              "RESEND",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontSize,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: constants.defaultPaddingSmall,
                      ),
                      EmailVerificationButton(
                        formKey: formKey,
                        errorController: errorController!,
                        setStateHasError: setStateHasError,
                        widgetUserEmail: widget.userEmail,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmailVerificationButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final StreamController<ErrorAnimationType> errorController;
  final void Function(bool) setStateHasError;
  final String widgetUserEmail;

  const EmailVerificationButton({
    Key? key,
    required this.formKey,
    required this.errorController,
    required this.setStateHasError,
    required this.widgetUserEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: () {
        debugPrint("Verify Email");
        // ALREADY PRESSED THE BUTTON
        if (context.read<VerifyEmailViewModel>().isVerifyngEmail ||
            context.read<VerifyEmailViewModel>().isVerifyingEmailSuccess) {
          return;
        }
        // IF TESTING
        if (constants.isTestingEmailVerification) {
          context.read<VerifyEmailViewModel>().verifyEmail();
          return;
        }
        // IF NOT TESTING
        if (!formKey.currentState!.validate()) {
          errorController.add(
            ErrorAnimationType.shake,
          );
          setStateHasError(true);
        } else {
          // context.read<VerifyEmailViewModel>().verifyEmailDTO.activationCode = int.tryParse()
          context.read<VerifyEmailViewModel>().verifyEmail();
        }
      },
      child: TextEmailVerificationButton(
        setStateHasError: setStateHasError,
        widgetUserEmail: widgetUserEmail,
      ),
    );
  }
}

class TextEmailVerificationButton extends StatelessWidget {
  final void Function(bool) setStateHasError;
  final String widgetUserEmail;

  const TextEmailVerificationButton({
    Key? key,
    required this.setStateHasError,
    required this.widgetUserEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verifyEmailViewModel = context.watch<VerifyEmailViewModel>();
    if (verifyEmailViewModel.isVerifyngEmail) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      );
    } else if (verifyEmailViewModel.isVerifyingEmailSuccess) {
      // TODO: TRY TO DISPOSE THE VIEW MODEL IF POSSIBLE
      context.read<VerifyEmailViewModel>().resetVerifyEmailState();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).goNamed(constants.loginRouteName);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Signup successful for $widgetUserEmail!',
              ),
            ),
          );
        });
        // SchedulerBinding.instance.add
      });
      return const Icon(
        Icons.check,
        color: Colors.white,
      );
    } else if (verifyEmailViewModel.isVerifyingEmailError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(
              verifyEmailViewModel.verifyingEmailErrorMessage!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            leading: Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  context
                      .read<VerifyEmailViewModel>()
                      .resetVerifyEmailStateAndNotifyListeners();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              )
            ],
          ),
        );
        // * Without this textEditingController.clear() keeps clearing the text
        context.read<VerifyEmailViewModel>().resetVerifyEmailState();
      });
      return const Text(
        "VERIFY",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const Text(
        "VERIFY",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
