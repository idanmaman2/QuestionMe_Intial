import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:questionme/ProfilePageCreate.dart';
import 'package:questionme/authentication.dart';
import 'package:questionme/main.dart';

class PhoneSign extends StatefulWidget {
  PhoneSign({Key? key}) : super(key: key);

  @override
  State<PhoneSign> createState() => _PhoneSignState();
}

class _PhoneSignState extends State<PhoneSign> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IL';
  PhoneNumber number = PhoneNumber(isoCode: 'IL');

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(),
                  flex: 4,
                ),
                Expanded(
                  flex: 2,
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                    },
                    onInputValidated: (bool value) {
                      print(value);
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: controller,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(),
                    onSaved: (PhoneNumber number) async {
                      print(number.phoneNumber);
                      print(number.phoneNumber?.length);
                      if (number.phoneNumber?.length == 13) {
                        await Authentication.auth.verifyPhoneNumber(
                          phoneNumber: number.phoneNumber as String,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Text("Error1")));
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Text("Error2")));
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PinCodeEnter(
                                          VerfactionId: verificationId,
                                        )));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Text("Error3")));
                          },
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Text("InCorrect PhoneNumber format ")));
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 2,
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      formKey.currentState?.save();
                    },
                    child: Text('Confirm'),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 4,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class PinCodeEnter extends StatefulWidget {
  String? _VerfactionId;
  PinCodeEnter({Key? key, @required String? VerfactionId})
      : _VerfactionId = VerfactionId,
        super(key: key);

  @override
  State<PinCodeEnter> createState() => _PinCodeEnterState();
}

class _PinCodeEnterState extends State<PinCodeEnter> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: PinCodeTextField(
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 35,
          fieldWidth: 40,
          activeFillColor: Colors.white54,
        ),
        animationDuration: Duration(milliseconds: 150),
        enableActiveFill: true,
        controller: textEditingController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) async {
          print(value);
          setState(() {
            currentText = value;
          });
          if (value.length == 6) {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: widget._VerfactionId as String, smsCode: value);
            UserCredential Usrcre =
                await Authentication.auth.signInWithCredential(credential);
            if (Usrcre.user != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePageDeisgn()));
            }
          }
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    ));
  }
}
