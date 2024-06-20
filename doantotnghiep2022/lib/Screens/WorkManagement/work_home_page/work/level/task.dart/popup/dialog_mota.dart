import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Config/Colors/colors.dart';
import '../task.dart';

Future popupMota(BuildContext context) {
  late TaskLogic taskLogic;
  taskLogic = context.read<TaskLogic>();
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(microseconds: 200),
    barrierColor: AppColors.tertiary,
    context: context,
    pageBuilder: (BuildContext context, Animation first, Animation second) =>
        ChangeNotifierProvider.value(
      value: taskLogic,
      child: Consumer<TaskLogic>(builder: (_, logic, __) {
        return Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  title: Text(
                    "Mô tả",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 22,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          logic.setString(logic.controllerMoTa.text);
                        },
                        child: Center(
                          child: Text(
                            "Xong",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 20,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: SizedBox(
                  height: double.infinity,
                  child: TextField(
                    maxLength: 300,
                    keyboardType: TextInputType.text,
                    controller: logic.controllerMoTa,
                    onChanged: (text) {
                      logic.setString(logic.controllerMoTa.text);
                    },
                    autofocus: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      counterStyle:
                          Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: AppColors.textLightGray,
                              ),
                      contentPadding:
                          const EdgeInsets.only(left: 15, right: 15, top: 30),
                      hintText: "Nhập mô tả",
                      border: InputBorder.none,
                      hintStyle:
                          Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: AppColors.textLightGray,
                              ),
                    ),
                  ),
                ),
              )),
        );
      }),
    ),
  ).then((e) => taskLogic.setString(taskLogic.controllerMoTa.text));
}
