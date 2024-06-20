import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Config/Colors/colors.dart';
import '../task.dart';

class WatchImage extends StatefulWidget {
  final int index;
  final List<XFile> file;
  final bool menuItem;
  const WatchImage(
      {Key? key,
      required this.file,
      required this.index,
      required this.menuItem})
      : super(key: key);

  @override
  State<WatchImage> createState() => _WatchImageState();
}

class _WatchImageState extends State<WatchImage> {
  int index = 0;
  void chandgeNext() {
    if (index >= widget.file.length - 1) {
      index = 0;
    } else {
      index = index + 1;
    }
  }

  void chandgeDown() {
    if (index == 0) {
      index = widget.file.length - 1;
    } else {
      index = index - 1;
    }
  }

  @override
  void initState() {
    index = widget.index;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: InkWell(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: const Icon(
              Icons.close,
              color: AppColors.textBlueBlack,
            )),
        actions: [
          if (widget.menuItem)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                icon: const Icon(Icons.more_horiz,
                    color: AppColors.textBlueBlack),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: (() {
                      context.read<TaskLogic>().updateImage(index);
                    }),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.create,
                          color: AppColors.textBlueBlack,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            "Đổi ảnh",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      color: AppColors.textBlueBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: (() {
                      context.read<TaskLogic>().removeImage(index);
                      Navigator.pop(context);
                    }),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: AppColors.textBlueBlack,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            "Xóa",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      color: AppColors.textBlueBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
      body: Stack(children: [
        Center(child: Image.file(File(widget.file[index].path))),
        Visibility(
          visible: widget.menuItem,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (() {
                setState(() {
                  chandgeNext();
                });
              }),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  height: 150,
                  width: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      color: AppColors.black),
                  child: const Center(
                      child: Icon(
                    Icons.navigate_next,
                    color: AppColors.white,
                    size: 40,
                  )),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.menuItem,
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: (() {
                setState(() {
                  chandgeDown();
                });
              }),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  height: 150,
                  width: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: AppColors.black),
                  child: const Center(
                      child: Icon(
                    Icons.navigate_before,
                    color: AppColors.white,
                    size: 40,
                  )),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
