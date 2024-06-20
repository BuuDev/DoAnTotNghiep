// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../../../../Config/Colors/colors.dart';
// import '../../level/task.dart/watch_image/watch_image.dart';

// class PickColor extends StatefulWidget {
//   const PickColor({Key? key}) : super(key: key);

//   @override
//   State<PickColor> createState() => _PickColorState();
// }

// class _PickColorState extends State<PickColor> {
//   final ImagePicker imagePicker = ImagePicker();
//   XFile? images;
//   Color color = AppColors.white;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         selectColor(context);
//       },
//       child: Container(
//         color: Colors.white,
//         width: double.infinity,
//         height: images == null ? 55 : 120,
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Row(
//             children: [
//               const SizedBox(
//                 width: 5,
//               ),
//               const Icon(
//                 Icons.line_weight_outlined,
//                 color: AppColors.primary,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               images == null
//                   ? Container(
//                       width: 60,
//                       height: 30,
//                       color: color,
//                     )
//                   : SizedBox(
//                       height: 110,
//                       width: 80,
//                       child: Stack(
//                         children: [
//                           InkWell(
//                             onTap: (() {
//                               Navigator.push<void>(
//                                 context,
//                                 MaterialPageRoute<void>(
//                                   builder: (BuildContext context) => WatchImage(
//                                     index: 0,
//                                     menuItem: false,
//                                     file: [images!],
//                                   ),
//                                 ),
//                               );
//                             }),
//                             child: Material(
//                               borderRadius: BorderRadius.circular(3),
//                               clipBehavior: Clip.antiAliasWithSaveLayer,
//                               child: Image.file(
//                                 File(images!.path),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   images = null;
//                                 });
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(3),
//                                 child: Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.red,
//                                     borderRadius: BorderRadius.circular(36),
//                                   ),
//                                   child: const Center(
//                                     child: Icon(
//                                       Icons.remove,
//                                       color: AppColors.white,
//                                       size: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> getSingleImage() async {
//     final XFile? selectedImages =
//         await imagePicker.pickImage(source: ImageSource.gallery);
//     if (selectedImages != null) {
//       setState(() {
//         color = AppColors.white;
//         images = selectedImages;
//       });
//     }
//   }

//   void selectColor(BuildContext context) => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Chọn màu nền bạn muốn"),
//           content: Column(mainAxisSize: MainAxisSize.min, children: [
//             SizedBox(height: 140, child: buildColorPicker()),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: IconButton(
//                 onPressed: () {
//                   getSingleImage().then((value) => Navigator.of(context).pop());
//                 },
//                 icon: const Icon(
//                   Icons.image,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       );
//   Widget buildColorPicker() => BlockPicker(
//         pickerColor: color,
//         availableColors: const [
//           AppColors.green,
//           AppColors.red,
//           AppColors.yellow,
//           AppColors.orange,
//           AppColors.primary,
//           AppColors.ocean,
//         ],
//         onColorChanged: (color) => setState(() {
//           images = null;
//           this.color = color;
//           Navigator.of(context).pop();
//         }),
//       );
// }

// enum BackGroundWork { green, red, yellow, orange, primary, ocean, image }

// String setBackGround(BackGroundWork value, XFile? image) {
//   switch (value) {
//     case BackGroundWork.green:
//       return "assets/images/green.png";
//     case BackGroundWork.red:
//       return "assets/images/red.png";
//     case BackGroundWork.yellow:
//       return "assets/images/yellow.png";
//     case BackGroundWork.orange:
//       return "assets/images/orange.png";
//     case BackGroundWork.primary:
//       return "assets/images/primary.png";
//     case BackGroundWork.ocean:
//       return "assets/images/ocean.png";
//     case BackGroundWork.image:
//       return image!.path;
//   }
// }

// bool checkBackGround(BackGroundWork backGroundWork) {
//   if (backGroundWork == BackGroundWork.image) {
//     return true;
//   } else {
//     return false;
//   }
// }
