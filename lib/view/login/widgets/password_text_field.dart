import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_dimension.dart';
import 'package:hrm_medical_world_app_two/core/core_config/config_style.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  final String title,hint;
  final bool isObscure;
  final TextEditingController passwordController;
  final Function onPressedVisibleIcon;
  final Function onChanged;
  final FocusNode? focusNode;

  const PasswordTextFieldWidget({
    super.key,
    required this.isObscure,
    required this.passwordController,
    required this.onPressedVisibleIcon,
    required this.onChanged,
    this.title = "Password",
    this.hint = "Enter Password",
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ConfigStyle.boldStyleTwo(DIMEN_SIXTEEN, Colors.black87),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            focusNode: focusNode,
            cursorColor: Colors.green,
            onChanged: (text) {
              onChanged();
            },
            obscureText: isObscure,
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Password';
              } else if (value == "123456") {
                return "Password is too easy";
              } else if (value.length < 4) {
                return "Password is too short";
              } else if (value.length <= 4 && value != "123456") {
                return "Password is strong";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: isObscure ? Colors.grey : Colors.green,
                ),
                onPressed: () {
                  onPressedVisibleIcon();
                },
              ),
              hintText: hint,
              hintStyle: ConfigStyle.regularStyleTwo(16, Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DIMEN_SIXTEEN),
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DIMEN_SIXTEEN),
                borderSide: const BorderSide(color: Colors.green),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DIMEN_SIXTEEN),
                borderSide: const BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DIMEN_SIXTEEN),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
