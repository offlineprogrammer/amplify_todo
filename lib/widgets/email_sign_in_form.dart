import 'package:amplify_todo/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailSignInForm extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children:
              controller.emailformType.value == EmailSignInFormType.confirm
                  ? _buildConfirmchildren()
                  : _buildFormchildren(),
        ),
      );
    });
  }

  Future<void> _submit() async {
    try {} catch (e) {}
  }

  List<Widget> _buildFormchildren() {
    return [
      TextField(
          decoration: InputDecoration(
            enabled: controller.isLoading.value == false,
            labelText: 'Email',
            hintText: 'test@test.com',
            errorText: controller.emailErrorText,
          ),
          controller: controller.emailController,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          focusNode: controller.emailFocusNode,
          onChanged: controller.updateform
          //onEditingComplete: () => _emailEditingComplete(),
          ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
          decoration: InputDecoration(
            //  enabled: model.isLoading == false,
            labelText: 'Password',
            //   errorText: model.passwordErrorText,
          ),
          obscureText: true,
          controller: controller.passwordController,
          textInputAction: TextInputAction.done,
          focusNode: controller.passwordFocusNode,
          //  onEditingComplete: _submit,
          onChanged: controller.updateform),
      SizedBox(
        height: 8.0,
      ),
      ElevatedButton(
        onPressed: controller.submitEnabled.value
            ? controller.submitEmailAndPassword
            : null, //
        child: Text(
          controller.primaryButtonText,
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed:
            !controller.isLoading.value ? controller.toggleFormType : null,
        child: Text(controller.secondaryButtonText),
      )
    ];
  }

  List<Widget> _buildConfirmchildren() {
    return [
      TextField(
        decoration: InputDecoration(
          enabled: controller.isLoading.value == false,
          labelText: 'Confirmation Code',
          hintText: 'The code we sent you',
          errorText: controller.emailErrorText,
        ),
        controller: controller.codeController,
        autocorrect: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        focusNode: controller.passwordFocusNode,
        onEditingComplete: _submit,
        //onChanged: controller.updateCode,
      ),
      SizedBox(
        height: 8.0,
      ),
      ElevatedButton(
        onPressed: controller.submitEnabled.value
            ? controller.submitEmailAndPassword
            : null,
        child: Text(
          controller.primaryButtonText,
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
    ];
  }
}
