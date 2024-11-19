import 'package:flutter/material.dart';
import 'package:education_apps/provider/auth_provider.dart';
import 'package:provider/provider.dart';


class TextfieldEmailWidget extends StatefulWidget {
  const TextfieldEmailWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<TextfieldEmailWidget> createState() => _TextfieldEmailWidgetState();
}

class _TextfieldEmailWidgetState extends State<TextfieldEmailWidget> {
  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProfider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        const SizedBox(height: 20,),
        TextFormField(
          controller: widget.controller,
          autovalidateMode:  AutovalidateMode.onUserInteraction,
          validator: (value) {
            if(value!.isEmpty || value == ""){
              return "Email can't be empty";
            }else if(!value.trim().contains("@")){
              return "Email not valid";
            }
            return null;
          },
          onSaved: (value) {
            loadAuth.enteredEmail = value!;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Insert Email...."
          ),
        )
      ],
    );
  }
}