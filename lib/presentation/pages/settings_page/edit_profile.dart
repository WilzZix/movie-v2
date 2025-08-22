import 'package:flutter/material.dart';
import 'package:movie/core/utils/components/button.dart' show Buttons;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  static String tag = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  FocusNode focusNodeName = FocusNode();
  TextEditingController surNameController = TextEditingController();
  FocusNode focusNodeSurname = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode focusNodePhone = FocusNode();
  TextEditingController genderController = TextEditingController();
  FocusNode focusNodeGender = FocusNode();
  TextEditingController stateController = TextEditingController();
  FocusNode focusNodeState = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    genderController.dispose();
    stateController.dispose();
    emailController.dispose();
    stateController.dispose();

    focusNodeGender.dispose();
    focusNodeEmail.dispose();
    focusNodeSurname.dispose();
    focusNodeName.dispose();
    focusNodePhone.dispose();
    focusNodeState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: const Column(
            children: [
              // InputField(focusNode: focusNodeName, controller: nameController),
              // const SizedBox(
              //   height: 24,
              // ),
              // InputField(
              //     focusNode: focusNodeSurname, controller: surNameController),
              // const SizedBox(
              //   height: 24,
              // ),
              // InputField.email(
              //     focusNode: focusNodeEmail, controller: emailController),
              // const SizedBox(
              //   height: 24,
              // ),
              // InputField.phone(
              //     focusNode: focusNodePhone, controller: phoneController),
              // const SizedBox(
              //   height: 24,
              // ),
              // InputField.phone(
              //   focusNode: focusNodeGender,
              //   controller: genderController,
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              // InputField.phone(
              //     focusNode: focusNodeState, controller: stateController),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 42,
              ),
              Buttons.primary(text: 'Update')
            ],
          ),
        ),
      )),
    );
  }
}
