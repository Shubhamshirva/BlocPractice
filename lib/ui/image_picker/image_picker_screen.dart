import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/image_picker/image_picker_bloc.dart';
import 'package:practice/bloc/image_picker/image_picker_event.dart';
import 'package:practice/bloc/image_picker/image_picker_state.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Center(
        child: BlocBuilder<ImagePickerBloc, ImagePickerStates>(builder: (context,state) {
         return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: state.file != null
                    ? DecorationImage(
                        image: FileImage(File(state.file!.path)), // Set picked image
                        fit: BoxFit.cover, // Adjust fit as needed
                      )
                    : DecorationImage(
                        image: AssetImage("assets/background.jpg"), // Default background
                        fit: BoxFit.cover,
                      ),
              ),
              child: 
              state.file == null 
              ?
              SizedBox()
              :
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: InkWell(
                      onTap: () {
                        context.read<ImagePickerBloc>().add(RemoveImage());
                      },
                      child: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              ),
                     ),
                    SizedBox(height: 20),

                     state.file != null ?
                    SizedBox()
                    :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<ImagePickerBloc>().add(CameraCapture());
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.camera),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<ImagePickerBloc>().add(GalleryImagePicker());
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.camera_alt_rounded),
                          ),
                        ),
                      ],
                    ),
           ],
         );
          // if (state.file == null) {
          //   return
          //    Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           InkWell(
          //             onTap: () {
          //               context.read<ImagePickerBloc>().add(CameraCapture());
          //             },
          //             child: CircleAvatar(
          //             child: Icon(Icons.camera),
          //                     ),
          //           ),
                        
          //           InkWell(
          //             onTap: () {
          //               context.read<ImagePickerBloc>().add(GalleryImagePicker());
          //             },
          //             child: CircleAvatar(
          //             child: Icon(Icons.camera_alt_rounded),
          //                     ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 20,),
          //       InkWell(
          //         onTap: () {
          //            context.read<ImagePickerBloc>().add(RemoveImage()); 
          //         },
          //         child: Icon(Icons.delete,color: Colors.red,))
          //     ],
          //   );
          // } else {
          //   return Image.file(File(state.file!.path.toString()));
          // }
          }
          ),
      ),
    );
  }
}