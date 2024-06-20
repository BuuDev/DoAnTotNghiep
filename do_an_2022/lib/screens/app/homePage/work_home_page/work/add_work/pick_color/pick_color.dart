import 'dart:io';

import 'package:demo_retrofit_api/screens/app/homePage/work_home_page/work/level/task.dart/watch_image/watch_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../theme/color.dart';

class PickColor extends StatefulWidget {
  const PickColor({Key? key}) : super(key: key);

  @override
  State<PickColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? images;
  Color color = AppColors.white;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectColor(context);
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: images == null ? 55 : 120,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.line_weight_outlined,
                color: AppColors.primary,
              ),
              SizedBox(
                width: 10,
              ),
              images == null
                  ? Container(
                      width: 60,
                      height: 30,
                      color: color,
                    )
                  : SizedBox(
                      height: 110,
                      width: 80,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: (() {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => WatchImage(
                                    index: 0,
                                    color: AppColors.blue,
                                    file: [images!],
                                  ),
                                ),
                              );
                            }),
                            child: Material(
                              borderRadius: BorderRadius.circular(3),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.file(
                                File(images!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  images = null;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getSingleImage() async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      setState(() {
        color = AppColors.white;
        images = selectedImages;
      });
    }
  }

  void selectColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Chọn màu nền bạn muốn"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(height: 140, child: buildColorPicker()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                onPressed: () {
                  getSingleImage().then((value) => Navigator.of(context).pop());
                },
                icon: Icon(
                  Icons.image,
                  size: 30,
                ),
              ),
            ),
          ]),
        ),
      );
  Widget buildColorPicker() => BlockPicker(
        pickerColor: color,
        availableColors: [
          AppColors.green,
          AppColors.red,
          AppColors.yellow,
          AppColors.orange,
          AppColors.primary,
          AppColors.ocean,
        ],
        onColorChanged: (color) => setState(() {
          images = null;
          this.color = color;
          Navigator.of(context).pop();
        }),
      );
}

enum BackGroundWork { green, red, yellow, orange, primary, ocean, image }

String setBackGround(BackGroundWork value, XFile? image) {
  switch (value) {
    case BackGroundWork.green:
      return "assets/icon/green.png";
    case BackGroundWork.red:
      return "assets/icon/red.png";
    case BackGroundWork.yellow:
      return "assets/icon/yellow.png";
    case BackGroundWork.orange:
      return "assets/icon/orange.png";
    case BackGroundWork.primary:
      return "assets/icon/primary.png";
    case BackGroundWork.ocean:
      return "assets/icon/ocean.png";
    case BackGroundWork.image:
      return image!.path;
  }
}

bool checkBackGround(BackGroundWork backGroundWork) {
  if (backGroundWork == BackGroundWork.image) {
    return true;
  } else {
    return false;
  }
}
