import 'dart:convert';
import 'dart:io';

import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Province/province.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/Helper/custom_loading.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:doantotnghiep/Widgets/CustomBottomsheet/custom_bottomsheet.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
part 'account_logic.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

enum Gender { nam, nu, khac }

class _AccountScreenState extends State<AccountScreen> {
  late AccountLogic accountLogic;

  ValueNotifier<Gender> gioitinh = ValueNotifier(Gender.nam);
  @override
  void initState() {
    accountLogic = context.read<AccountLogic>();
    super.initState();
  }

  // @override
  // void dispose() {
  //   accountLogic.dispose();
  //   super.dispose();
  // }

  void showbottomSheet() {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return CustomBottomSheet(
            txtSearch: accountLogic.txtSearch,
            data: accountLogic.data,
          );
        }).then((value) {
      if (value != null) {
        accountLogic.updateProvince(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: accountLogic,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: const Text(
            'Thông tin tài khoản',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textBlack,
                size: 15,
              )),
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: Selector<AccountLogic, UserDemo?>(
            selector: (_, state) => state.user,
            builder: (_, value1, __) {
              return value1 == null
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : SingleChildScrollView(
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
                                  Selector<AccountLogic,
                                      Tuple2<File?, UserDemo?>>(
                                    selector: (_, state) =>
                                        Tuple2(state.imageShow, state.user),
                                    builder: (_, value, __) {
                                      return InkWell(
                                        onTap: () {
                                          try {
                                            if (accountLogic.user!.avatar !=
                                                    null &&
                                                accountLogic.imageShow ==
                                                    null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return InteractiveViewer(
                                                        child: Image.network(
                                                            value.item2!
                                                                .avatar!));
                                                  });
                                            }
                                            if (value.item1!.path.isNotEmpty) {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return InteractiveViewer(
                                                        child: Image.file(File(
                                                            value
                                                                .item1!.path)));
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
                                              color: const Color(0xff009866),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: accountLogic.user!.avatar !=
                                                        null &&
                                                    accountLogic.imageShow ==
                                                        null
                                                ? Image.network(
                                                    accountLogic.user!.avatar!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) {
                                                      return Image.asset(
                                                        Assets.images.avatarNull
                                                            .path,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                : accountLogic.imageShow != null
                                                    ? Image.file(
                                                        accountLogic.imageShow!,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        Assets.images.avatarNull
                                                            .path,
                                                        fit: BoxFit.cover,
                                                      ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: accountLogic.selectImage,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff009866),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: AppColors.white,
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
                          Consumer<AccountLogic>(
                            builder: (_, value, __) {
                              return TextFieldCustom(
                                value: accountLogic.name,
                                onChanged: (val) {
                                  accountLogic.updateValueTextfield(
                                      'name', val);
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
                          // TextFieldCustom(
                          //   controller: accountLogic.txtBirthday,
                          // ),
                          Selector<AccountLogic, String>(
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
                                      accountLogic.updateBirthday(value));
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
                                          Helper.formatDate(
                                              accountLogic.birthday),
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
                          TextFieldCustom(
                            keyboardType: TextInputType.number,
                            value: accountLogic.phone,
                            onChanged: (val) {
                              accountLogic.updateValueTextfield('phone', val);
                            },
                          ),

                          //Chứng minh nhân dân
                          Consumer<AccountLogic>(
                            builder: (_, value, __) {
                              return const LabelTextFieldCustom(
                                value: 'CMND/CCCD',
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<AccountLogic>(
                            builder: (_, value, __) {
                              return TextFieldCustom(
                                keyboardType: TextInputType.number,
                                value: accountLogic.cmnd,
                                onChanged: (val) {
                                  accountLogic.updateValueTextfield(
                                      'cmnd', val);
                                },
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
                          Consumer<AccountLogic>(
                            builder: (_, value, __) {
                              return TextFieldCustom(
                                keyboardType: TextInputType.emailAddress,
                                value: accountLogic.email,
                                onChanged: (val) {
                                  accountLogic.updateValueTextfield(
                                      'email', val);
                                },
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
                          // Selector<AccountLogic, String>(
                          //   selector: (_, state) => state.address,
                          //   builder: (_, value, __) {
                          //     return InkWell(
                          //       onTap: showbottomSheet,
                          //       child: Container(
                          //         padding: const EdgeInsets.symmetric(horizontal: 10),
                          //         width: double.infinity,
                          //         height: 50,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             color: AppColors.primary,
                          //             width: 2,
                          //           ),
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Text(accountLogic.address,
                          //                 style: TextStyle(
                          //                   color: AppColors.textBlack,
                          //                   fontSize: 15,
                          //
                          //                   // fontWeight: FontWeight.bold,
                          //                 )),
                          //             const Icon(
                          //               Icons.expand_more_outlined,
                          //               color: AppColors.textBlack,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          Consumer<AccountLogic>(
                            builder: (_, value, __) {
                              return TextFieldCustom(
                                value: accountLogic.address,
                                onChanged: (val) {
                                  accountLogic.updateValueTextfield(
                                      'address', val);
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //Nút lưu
                          Consumer<AccountLogic>(
                            builder: (_, value, __) {
                              return InkWell(
                                onTap: () {
                                  if (accountLogic.activeButton) {
                                    accountLogic.updateInfoUser();
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: accountLogic.activeButton
                                        ? const Color(0xff009866)
                                        : AppColors.tertiary,
                                  ),
                                  child: const Center(
                                    child: Text('Lưu thông tin',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
