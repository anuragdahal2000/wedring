import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wedring/components/custom_textfield.dart';
import 'package:wedring/components/primary_button.dart';
import 'package:wedring/util/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkboxValue = false;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _username = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create a new account",
                    style: kSemiBold20,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Please fill the form to create a new account",
                    style: kRegular14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  buildFormWidget(),
                  const SizedBox(
                    height: 24,
                  ),
                  PrimaryButton(
                    title: 'Continue',
                    onPressed: () {
                      context.goNamed('signup-2');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form buildFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Full Name',
            prefixIcon: const Icon(Icons.person_outline),
            controller: _username,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            prefixIcon: const Icon(Icons.email_outlined),
            controller: _email,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            prefixIcon: const Icon(Icons.phone),
            controller: _phoneController,
            hintText: 'Phone',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Phone';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              if (value.length < 8) {
                return 'Please enter atleast 8 digits';
              }
              return null;
            },
            controller: _passwordController,
            hintText: 'Password',
            forPassword: true,
            obscureText: true,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            controller: _confirmPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please re-enter password';
              }
              if (value.length < 8) {
                return 'Please enter atleast 8 digits';
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Password doesnot match';
              }
              return null;
            },
            hintText: 'Confirm Password',
            forPassword: true,
            keyboardType: TextInputType.text,
            obscureText: true,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              variant: Variant.outline,
              title: selectedDate == null
                  ? 'Select Date of Birth'
                  : 'DOB ${intl.DateFormat.yMMMd().format(selectedDate!)}',
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  lastDate: DateTime.now(),
                  firstDate: DateTime(1900, 1, 1, 12, 20),
                  initialDatePickerMode: DatePickerMode.year,
                  initialDate: selectedDate ?? DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<DateTime?> showDatePicker(
    {required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    final ValueChanged<DatePickerEntryMode>? onDatePickerModeChange}) async {
  initialDate = DateUtils.dateOnly(initialDate);
  firstDate = DateUtils.dateOnly(firstDate);
  lastDate = DateUtils.dateOnly(lastDate);
  assert(
    !lastDate.isBefore(firstDate),
    'lastDate $lastDate must be on or after firstDate $firstDate.',
  );
  assert(
    !initialDate.isBefore(firstDate),
    'initialDate $initialDate must be on or after firstDate $firstDate.',
  );
  assert(
    !initialDate.isAfter(lastDate),
    'initialDate $initialDate must be on or before lastDate $lastDate.',
  );
  assert(
    selectableDayPredicate == null || selectableDayPredicate(initialDate),
    'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.',
  );
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = DatePickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: currentDate,
    initialEntryMode: initialEntryMode,
    selectableDayPredicate: selectableDayPredicate,
    helpText: helpText,
    cancelText: cancelText,
    confirmText: confirmText,
    initialCalendarMode: initialDatePickerMode,
    errorFormatText: errorFormatText,
    errorInvalidText: errorInvalidText,
    fieldHintText: fieldHintText,
    fieldLabelText: fieldLabelText,
    keyboardType: keyboardType,
    onDatePickerModeChange: onDatePickerModeChange,
  );

  if (textDirection != null) {
    dialog = Directionality(
      textDirection: textDirection,
      child: dialog,
    );
  }

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
  }

  return showDialog<DateTime>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    anchorPoint: anchorPoint,
  );
}
