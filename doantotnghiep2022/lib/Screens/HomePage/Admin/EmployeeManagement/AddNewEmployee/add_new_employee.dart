import 'dart:io';

import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Department/department.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/role_user.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';
part 'add_new_employee_logic.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({Key? key}) : super(key: key);

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

enum Gender { nam, nu, khac }

class _AddNewEmployeeState extends State<AddNewEmployee> {
  late AddNewEmployeeLogic addNewEmployeeLogic;

  ValueNotifier<Gender> gioitinh = ValueNotifier(Gender.nam);
  @override
  void initState() {
    addNewEmployeeLogic = AddNewEmployeeLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      UserDemo? id = ModalRoute.of(context)!.settings.arguments as UserDemo?;
      if (id != null) {
        addNewEmployeeLogic.fillValueUdate(id);
      }
    });
    renderUI();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void renderUI() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    addNewEmployeeLogic.show();
  }

  UserDemo? get id => ModalRoute.of(context)!.settings.arguments as UserDemo?;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addNewEmployeeLogic,
      child: Selector<AddNewEmployeeLogic, bool>(
        selector: (_, state) => state.isShow,
        builder: (_, value, __) {
          return addNewEmployeeLogic.isShow
              ? const Scaffold(
                  backgroundColor: AppColors.white,
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.transparent,
                    elevation: 0.0,
                    title: Text(
                      addNewEmployeeLogic.chucvu.name.isNotEmpty
                          ? 'Thông tin nhân viên'
                          : 'Thêm mới nhân viên',
                      style: const TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    leading: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textBlack,
                          size: 15,
                        )),
                  ),
                  body: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Selector<AddNewEmployeeLogic, File?>(
                                  selector: (_, state) => state.imageShow,
                                  builder: (_, value, __) {
                                    return InkWell(
                                      onTap: () {
                                        try {
                                          if (addNewEmployeeLogic
                                                  .avatar.isNotEmpty &&
                                              addNewEmployeeLogic.imageShow ==
                                                  null) {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return InteractiveViewer(
                                                      child: Image.network(
                                                          addNewEmployeeLogic
                                                              .avatar));
                                                });
                                          }
                                          if (value!.path.isNotEmpty) {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return InteractiveViewer(
                                                      child: Image.file(
                                                          File(value.path)));
                                                });
                                          }
                                        } catch (e) {
                                          debugPrint(e.toString());
                                        }
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: const Color(0xff009688),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: addNewEmployeeLogic
                                                      .avatar.isNotEmpty &&
                                                  addNewEmployeeLogic
                                                          .imageShow ==
                                                      null
                                              ? Image.network(
                                                  addNewEmployeeLogic.avatar,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) {
                                                    return Image.asset(
                                                        Assets.images.avatarNull
                                                            .path,
                                                        fit: BoxFit.cover);
                                                  },
                                                )
                                              : addNewEmployeeLogic.imageShow !=
                                                      null
                                                  ? Image.file(
                                                      addNewEmployeeLogic
                                                          .imageShow!,
                                                      fit: BoxFit.cover)
                                                  : Image.asset(
                                                      Assets.images.avatarNull
                                                          .path,
                                                      fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: addNewEmployeeLogic.selectImage,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff009688),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColors.tertiary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Họ tên
                        const LabelTextFieldCustom(
                          value: 'Họ Tên',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return TextFieldCustom(
                              placeholder: 'nhập họ tên...',
                              value: addNewEmployeeLogic.name,
                              onChanged: (val) {
                                addNewEmployeeLogic.update('name', val);
                              },
                            );
                          },
                        ),

                        //Ngày sinh
                        const LabelTextFieldCustom(
                          value: 'Ngày sinh',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Selector<AddNewEmployeeLogic, String>(
                          selector: (_, state) => state.birthday,
                          builder: (_, value, __) {
                            return InkWell(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2004),
                                  firstDate: DateTime(1980, 1, 1),
                                  lastDate: DateTime(2004, 12),
                                ).then((value) =>
                                    addNewEmployeeLogic.updateBirthday(value));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.tertiary, width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        addNewEmployeeLogic.birthday ==
                                                'dd/ mm/ yyyy'
                                            ? 'dd/ mm/ yyyy'
                                            : Helper.formatDate(
                                                addNewEmployeeLogic.birthday),
                                        style: const TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: AppColors.textBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Giới tính
                        // const LabelTextFieldCustom(
                        //   value: 'Giới tính',
                        // ),
                        // Row(
                        //   children: [
                        //     ValueListenableBuilder<Gender>(
                        //         valueListenable: gioitinh,
                        //         builder: (_, value, __) {
                        //           return Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Radio(
                        //                 toggleable: true,
                        //                 value: Gender.nam,
                        //                 groupValue: value,
                        //                 onChanged: (value) {
                        //                   gioitinh.value = Gender.nam;
                        //                 },
                        //               ),
                        //               const Text('Nam')
                        //             ],
                        //           );
                        //         }),
                        //     ValueListenableBuilder<Gender>(
                        //         valueListenable: gioitinh,
                        //         builder: (_, value, __) {
                        //           return Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Radio(
                        //                 toggleable: true,
                        //                 value: Gender.nu,
                        //                 groupValue: value,
                        //                 onChanged: (value) {
                        //                   gioitinh.value = Gender.nu;
                        //                 },
                        //               ),
                        //               const Text('Nữ')
                        //             ],
                        //           );
                        //         }),
                        //     ValueListenableBuilder<Gender>(
                        //         valueListenable: gioitinh,
                        //         builder: (_, value, __) {
                        //           return Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Radio(
                        //                 toggleable: true,
                        //                 value: Gender.khac,
                        //                 groupValue: value,
                        //                 onChanged: (value) {
                        //                   gioitinh.value = Gender.khac;
                        //                 },
                        //               ),
                        //               const Text('Khác')
                        //             ],
                        //           );
                        //         }),
                        //   ],
                        // ),
                        //Số điện thoại
                        const LabelTextFieldCustom(
                          value: 'Số điện thoại',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldCustom(
                                  keyboardType: TextInputType.number,
                                  value: addNewEmployeeLogic.phone,
                                  placeholder: 'nhập số điện thoại...',
                                  onChanged: (value) {
                                    addNewEmployeeLogic.update('phone', value);
                                  },
                                  errorBorder: addNewEmployeeLogic.phone
                                          .trim()
                                          .isNotEmpty &&
                                      addNewEmployeeLogic.errorPhone.isNotEmpty,
                                  suFFixIcon: addNewEmployeeLogic.phone
                                              .trim()
                                              .isNotEmpty &&
                                          addNewEmployeeLogic
                                              .errorPhone.isNotEmpty
                                      ? const Icon(
                                          Icons.warning_amber_rounded,
                                          size: 20,
                                          color: AppColors.red,
                                        )
                                      : null,
                                ),
                                if (addNewEmployeeLogic.errorPhone.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(addNewEmployeeLogic.errorPhone,
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 14,
                                          fontFamily:
                                              Assets.googleFonts.montserratBold,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                              ],
                            );
                          },
                        ),

                        //Chứng minh nhân dân
                        const LabelTextFieldCustom(
                          value: 'CMND/CCCD',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldCustom(
                                  keyboardType: TextInputType.number,
                                  value: addNewEmployeeLogic.cmnd,
                                  placeholder: 'chứng mình nhân dân...',
                                  onChanged: (value) {
                                    addNewEmployeeLogic.update('cmnd', value);
                                  },
                                  errorBorder: addNewEmployeeLogic.cmnd
                                          .trim()
                                          .isNotEmpty &&
                                      addNewEmployeeLogic.errorCmnd.isNotEmpty,
                                  suFFixIcon: addNewEmployeeLogic.cmnd
                                              .trim()
                                              .isNotEmpty &&
                                          addNewEmployeeLogic
                                              .errorCmnd.isNotEmpty
                                      ? const Icon(
                                          Icons.warning_amber_rounded,
                                          size: 20,
                                          color: AppColors.red,
                                        )
                                      : null,
                                ),
                                if (addNewEmployeeLogic.errorCmnd.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(addNewEmployeeLogic.errorCmnd,
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 14,
                                          fontFamily:
                                              Assets.googleFonts.montserratBold,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                              ],
                            );
                          },
                        ),

                        //Email
                        const LabelTextFieldCustom(
                          value: 'Email',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldCustom(
                                  value: addNewEmployeeLogic.email,
                                  errorBorder: addNewEmployeeLogic.email
                                          .trim()
                                          .isNotEmpty &&
                                      addNewEmployeeLogic.errorEmail.isNotEmpty,
                                  onChanged: (val) {
                                    addNewEmployeeLogic.update('email', val);
                                  },
                                  placeholder: 'Nhập email...',
                                  suFFixIcon: addNewEmployeeLogic.email
                                              .trim()
                                              .isNotEmpty &&
                                          addNewEmployeeLogic
                                              .errorEmail.isNotEmpty
                                      ? const Icon(
                                          Icons.warning_amber_rounded,
                                          size: 20,
                                          color: AppColors.red,
                                        )
                                      : null,
                                ),
                                if (addNewEmployeeLogic.errorEmail.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(addNewEmployeeLogic.errorEmail,
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 14,
                                          fontFamily:
                                              Assets.googleFonts.montserratBold,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                              ],
                            );
                          },
                        ),

                        //Địa chỉ
                        const LabelTextFieldCustom(
                          value: 'Quê quán/địa chỉ',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return TextFieldCustom(
                              value: addNewEmployeeLogic.address,
                              placeholder: 'nhập địa chỉ...',
                              onChanged: (val) {
                                addNewEmployeeLogic.update('address', val);
                              },
                            );
                          },
                        ),

                        //Địa chỉ
                        const LabelTextFieldCustom(
                          value: 'Tên đăng nhập',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldCustom(
                                  value: addNewEmployeeLogic.username,
                                  placeholder: 'tên đăng nhập...',
                                  onChanged: (val) {
                                    addNewEmployeeLogic.update('username', val);
                                  },
                                  errorBorder: addNewEmployeeLogic.username
                                          .trim()
                                          .isNotEmpty &&
                                      addNewEmployeeLogic
                                          .errorUsername.isNotEmpty,
                                  suFFixIcon: addNewEmployeeLogic.username
                                              .trim()
                                              .isNotEmpty &&
                                          addNewEmployeeLogic
                                              .errorUsername.isNotEmpty
                                      ? const Icon(
                                          Icons.warning_amber_rounded,
                                          size: 20,
                                          color: AppColors.red,
                                        )
                                      : null,
                                ),
                                if (addNewEmployeeLogic
                                    .errorUsername.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child:
                                        Text(addNewEmployeeLogic.errorUsername,
                                            style: TextStyle(
                                              color: AppColors.red,
                                              fontSize: 14,
                                              fontFamily: Assets
                                                  .googleFonts.montserratBold,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  )
                              ],
                            );
                          },
                        ),

                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return addNewEmployeeLogic.chucvu.name.isNotEmpty
                                ? const SizedBox()
                                : const LabelTextFieldCustom(
                                    value: 'Mật khẩu',
                                  );
                          },
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return addNewEmployeeLogic.chucvu.name.isNotEmpty
                                ? const SizedBox()
                                : const SizedBox(
                                    height: 5,
                                  );
                          },
                        ),
                        Consumer<AddNewEmployeeLogic>(
                          builder: (_, value, __) {
                            return addNewEmployeeLogic.chucvu.name.isNotEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFieldCustom(
                                        value: addNewEmployeeLogic.password,
                                        typePassword:
                                            !addNewEmployeeLogic.showPassword,
                                        errorBorder: addNewEmployeeLogic
                                                .password
                                                .trim()
                                                .isNotEmpty &&
                                            addNewEmployeeLogic
                                                .errorPassword.isNotEmpty,
                                        onChanged: (val) {
                                          addNewEmployeeLogic.update(
                                              'password', val);
                                        },
                                        placeholder: 'Nhập mật khẩu...',
                                        suFFixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            addNewEmployeeLogic.password
                                                        .trim()
                                                        .isNotEmpty &&
                                                    addNewEmployeeLogic
                                                        .errorPassword
                                                        .isNotEmpty
                                                ? const Icon(
                                                    Icons.warning_amber_rounded,
                                                    size: 20,
                                                    color: AppColors.red,
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                                onTap: addNewEmployeeLogic
                                                    .showPass,
                                                child: Icon(
                                                  !addNewEmployeeLogic.showPassword
                                                      ? Icons
                                                          .remove_red_eye_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color: AppColors.tertiary,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      if (addNewEmployeeLogic
                                          .errorPassword.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                              addNewEmployeeLogic.errorPassword,
                                              style: TextStyle(
                                                color: AppColors.red,
                                                fontSize: 14,
                                                fontFamily: Assets
                                                    .googleFonts.montserratBold,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        )
                                    ],
                                  );
                          },
                        ),

                        const LabelTextFieldCustom(value: 'Phòng ban'),
                        const SizedBox(
                          height: 5,
                        ),
                        Selector<AddNewEmployeeLogic, Department>(
                          selector: (_, state) => state.phongban,
                          builder: (_, value, __) {
                            return InkWell(
                              onTap: addNewEmployeeLogic.selectPhongBan,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.tertiary, width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        addNewEmployeeLogic
                                                .phongban.name.isEmpty
                                            ? 'Chọn phòng ban'
                                            : addNewEmployeeLogic.phongban.name,
                                        style: const TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: AppColors.textBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const LabelTextFieldCustom(value: 'Chức vụ'),
                        const SizedBox(
                          height: 5,
                        ),
                        Selector<AddNewEmployeeLogic, RoleUser>(
                          selector: (_, state) => state.chucvu,
                          builder: (_, value, __) {
                            return InkWell(
                              onTap: addNewEmployeeLogic.selectChucVu,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.tertiary, width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        addNewEmployeeLogic.chucvu.name.isEmpty
                                            ? 'Chọn chức vụ'
                                            : addNewEmployeeLogic.chucvu.name,
                                        style: const TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: AppColors.textBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Nút lưu
                        InkWell(
                          onTap: () {
                            id != null
                                ? addNewEmployeeLogic.updateEmoloyee()
                                : addNewEmployeeLogic.addNewEmoloyee();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff009688),
                            ),
                            child: Center(
                              child: Text(
                                  addNewEmployeeLogic.chucvu.name.isNotEmpty
                                      ? 'Cập nhật'
                                      : 'Thêm nhân viên',
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
