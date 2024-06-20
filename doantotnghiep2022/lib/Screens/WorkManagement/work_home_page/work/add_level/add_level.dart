import 'package:flutter/material.dart';

import '../../../../../Config/Colors/colors.dart';
import '../../../../../Widgets/popup_level_name/popup_level_name.dart';

class AddLevel extends StatefulWidget {
  final int? id_work;
  final int? id_level;
  const AddLevel({Key? key, required this.id_work, required this.id_level})
      : super(key: key);

  @override
  State<AddLevel> createState() => _AddLevelState();
}

class _AddLevelState extends State<AddLevel> {
  static double width(BuildContext context) {
    double insets = MediaQuery.of(context).size.width;
    return insets;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: InkWell(
          onTap: () {
            popupSetNameLevel(
              null,
              widget.id_work,
              null,
              context,
            );
          },
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.white.withOpacity(0.25)],
                    stops: const [0.0]),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              width: width(context) * 0.8,
              height: 60,
              child: Center(
                child: Text(
                  "Thêm Mục",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              )),
        ),
      ),
    );
  }
}
