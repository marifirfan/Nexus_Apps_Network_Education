import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/imagepick_provider.dart';



class ImagePickWidget extends StatefulWidget {
  const ImagePickWidget({super.key});

  @override
  State<ImagePickWidget> createState() => _ImagePickWidgetState();
}

class _ImagePickWidgetState extends State<ImagePickWidget> {
  @override
  Widget build(BuildContext context) {
    var loadPickImg = Provider.of<ImagePickProvider>(context);
    var getImage = loadPickImg.pickedImageFile;
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: getImage != null ? FileImage(getImage): null,
        ),
        TextButton.icon(onPressed: (){
          loadPickImg.pickImage();
        }, icon: const Icon(Icons.image), label: const Text("Upload Image"))
      ],
    );
  }
}