import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/util/constant.dart';

class OptVerification extends StatefulWidget {
  const OptVerification({Key? key}) : super(key: key);

  @override
  State<OptVerification> createState() => _OptVerificationState();
}

class _OptVerificationState extends State<OptVerification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor2,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "OTP Verification",
                style: kSemiBold20,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Please type the verfication code sent to ja*************@gmail.com',
                style: kRegular14,
              ),
              const SizedBox(
                height: 32,
              ),
              Form(
                key: _formKey,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeFillColor: kTeritary2,
                    errorBorderColor: kStateColorError,
                    inactiveColor: kTeritary1,
                    inactiveFillColor: kTeritary1,
                    activeColor: kTeritary2,
                    selectedColor: kTeritary2,
                    selectedFillColor: kTeritary2,
                  ),
                  cursorColor: kPrimaryColor2,
                  animationDuration: const Duration(
                    milliseconds: 300,
                  ),
                  errorAnimationController: errorController,
                  controller: _pinCodeController,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
              // Text(
              //   hasError ? "*Please fill up all the codes properly" : "",
              //   style: kRegular12.copyWith(
              //     color: kStateColorError,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Expries in 01:38',
                    style: kRegular14,
                  ),
                  Text(
                    'Re-send Code',
                    style: kRegular14.copyWith(color: kPrimaryColor1),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                title: 'Continue',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.goNamed('new-password');
                    // if (currentText.length != 4 || currentText != "1234") {
                    //   errorController!.add(
                    //     ErrorAnimationType.shake,
                    //   );
                    //   setState(() => hasError = true);
                    // } else {
                    //   setState(
                    //     () {
                    //       hasError = false;
                    //     },
                    //   );
                    // }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
