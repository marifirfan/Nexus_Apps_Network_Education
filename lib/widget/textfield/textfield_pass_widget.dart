import 'package:flutter/material.dart';
import 'package:education_apps/provider/auth_provider.dart';
import 'package:provider/provider.dart';


class TextfieldPasswordWidget extends StatefulWidget {
  const TextfieldPasswordWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<TextfieldPasswordWidget> createState() => _TextfieldPasswordWidgetState();
}

class _TextfieldPasswordWidgetState extends State<TextfieldPasswordWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProfider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        const SizedBox(height: 20,),
        TextFormField(
          controller: widget.controller,
          autovalidateMode:  AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          validator: (value) {
            if(value!.trim().isEmpty || value == ""){
              return "Password can't be empty";
            }else if(value.trim().length < 6){
              return "Password should more than 6 character";
            }
            return null;
          },
          onSaved: (value) {
            loadAuth.enteredPassword = value!;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Insert Password....",
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                obscureText = !obscureText;
              });
            }, icon: const Icon(Icons.remove_red_eye_rounded))
          ),
        )
      ],
    );
  }
}