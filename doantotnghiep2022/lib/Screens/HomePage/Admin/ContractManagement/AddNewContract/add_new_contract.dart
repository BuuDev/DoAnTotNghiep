import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Department/department.dart';
import 'package:doantotnghiep/Models/UserSkinDetective/role_user.dart';
import 'package:doantotnghiep/Services/Api/Contract/contract.dart';
import 'package:doantotnghiep/Services/Api/Salary/salary_api.dart';
import 'package:doantotnghiep/Services/Api/demoCallApi/demo.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/CustomSelect/custom_select.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:tuple/tuple.dart';
part 'add_new_contract_logic.dart';

class AddNewContract extends StatefulWidget {
  const AddNewContract({Key? key}) : super(key: key);

  @override
  State<AddNewContract> createState() => _AddNewContractState();
}

class _AddNewContractState extends State<AddNewContract> {
  dynamic get id => ModalRoute.of(context)!.settings.arguments as dynamic;

  late AddNewContractLogic addNewContractLogic;
  ValueNotifier<selectNV> type = ValueNotifier(selectNV.newEmployee);
  @override
  void initState() {
    super.initState();
    addNewContractLogic = AddNewContractLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dynamic id = ModalRoute.of(context)!.settings.arguments as dynamic;
      if (id != '') {
        addNewContractLogic.updateStartDay(id['startDay']);
        addNewContractLogic.updateEndDay(id['endDay']);
        // addNewContractLogic.day(id['lido']);
      }
    });
  }

  @override
  void dispose() {
    addNewContractLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addNewContractLogic,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: Text(
            id != '' ? 'Chỉnh sửa hợp đồng' : 'Thêm mới hợp đồng',
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
                Navigator.pop(context, [false]);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textBlack,
                size: 15,
              )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  //Email
                  const LabelTextFieldCustom(
                    value: 'Họ tên',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return TextFieldCustom(
                        value: addNewContractLogic.name,
                        placeholder: 'Nhập họ tên...',
                        onChanged: (value) {
                          addNewContractLogic.updateValue('name', value);
                        },
                      );
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Email
                  const LabelTextFieldCustom(
                    value: 'Tên tài khoản',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return TextFieldCustom(
                        value: addNewContractLogic.username,
                        placeholder: 'Nhập tên tài khoản...',
                        onChanged: (value) {
                          addNewContractLogic.updateValue('username', value);
                        },
                      );
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Email
                  const LabelTextFieldCustom(
                    value: 'Mật khẩu',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldCustom(
                            typePassword: !addNewContractLogic.showPassword,
                            errorBorder: addNewContractLogic.txtPassword.text
                                    .trim()
                                    .isNotEmpty &&
                                addNewContractLogic.errorPassword.isNotEmpty,
                            controller: addNewContractLogic.txtPassword,
                            onChanged: (val) {
                              addNewContractLogic.updateValue('password', val);
                              addNewContractLogic.validatePass(val);
                            },
                            placeholder: 'Nhập mật khẩu...',
                            suFFixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                addNewContractLogic.txtPassword.text
                                            .trim()
                                            .isNotEmpty &&
                                        addNewContractLogic
                                            .errorPassword.isNotEmpty
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
                                    onTap: addNewContractLogic.showPass,
                                    child: Icon(
                                      !addNewContractLogic.showPassword
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.tertiary,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          if (addNewContractLogic.errorPassword.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(addNewContractLogic.errorPassword,
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
                ],
              ),

              //Ngày sinh

              //Ngày sinh
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTextFieldCustom(
                    value: 'Ngày sinh',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Selector<AddNewContractLogic, String>(
                    selector: (_, state) => state.birthday,
                    builder: (_, value, __) {
                      return CustomSelect(
                        title: id != '' &&
                                id['birthday'].isNotEmpty &&
                                addNewContractLogic.birthday == 'dd/ mm/ yyyy'
                            ? Helper.formatDate(id['birthday'])
                            : Helper.formatDate(addNewContractLogic.birthday),
                        icon: Icons.calendar_month_outlined,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime(2004),
                            firstDate: DateTime(1980, 1, 1),
                            lastDate: DateTime(2004, 12),
                          ).then((value) =>
                              addNewContractLogic.updateBirthday(value));
                        },
                      );
                    },
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  //Email
                  const LabelTextFieldCustom(
                    value: 'Email',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldCustom(
                              keyboardType: TextInputType.emailAddress,
                              errorBorder:
                                  addNewContractLogic.email.trim().isNotEmpty &&
                                      addNewContractLogic.errorEmail.isNotEmpty,
                              value: addNewContractLogic.email,
                              onChanged: (val) {
                                addNewContractLogic.updateValue('email', val);

                                addNewContractLogic.validateEmail(val);
                              },
                              placeholder: 'Nhập email...',
                              suFFixIcon: addNewContractLogic.email
                                          .trim()
                                          .isNotEmpty &&
                                      addNewContractLogic.errorEmail.isNotEmpty
                                  ? const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 20,
                                      color: AppColors.red,
                                    )
                                  : null),
                          if (addNewContractLogic.errorEmail.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(addNewContractLogic.errorEmail,
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
                  )
                ],
              ),
              //Địa chỉ
              // const SizedBox(
              //   height: 5,
              // ),
              //Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTextFieldCustom(
                    value: 'Địa chỉ',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return TextFieldCustom(
                        value: addNewContractLogic.address,
                        placeholder: 'Nhập địa chỉ...',
                        onChanged: (value) {
                          addNewContractLogic.updateValue('address', value);
                        },
                      );
                    },
                  )
                ],
              ),
              //số điện thoại
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTextFieldCustom(
                    value: 'Số điện thoại',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return TextFieldCustom(
                        keyboardType: TextInputType.number,
                        value: addNewContractLogic.phone,
                        placeholder: 'nhập số điện thoại...',
                        onChanged: (value) {
                          addNewContractLogic.updateValue('phone', value);
                        },
                      );
                    },
                  )
                ],
              ),
              //CMND
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTextFieldCustom(
                    value: 'CMND/CCCD',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AddNewContractLogic>(
                    builder: (_, value, __) {
                      return TextFieldCustom(
                        keyboardType: TextInputType.number,
                        value: addNewContractLogic.cmnd,
                        placeholder: 'nhập CMND/CCCD...',
                        onChanged: (value) {
                          addNewContractLogic.updateValue('cmnd', value);
                        },
                      );
                    },
                  )
                ],
              ),
              //chức vụ
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelTextFieldCustom(
                    value: 'Chức vụ',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Selector<AddNewContractLogic, RoleUser>(
                    selector: (_, state) => state.chucvu,
                    builder: (_, value, __) {
                      return CustomSelect(
                          title: id != '' &&
                                  id['chucvu'].isNotEmpty &&
                                  value.name.isEmpty
                              ? id['chucvu']
                              : value.name.isNotEmpty
                                  ? value.name
                                  : 'Chọn chức vụ',
                          icon: Icons.keyboard_arrow_down_outlined,
                          onTap: addNewContractLogic.selectChucvu);
                    },
                  )
                ],
              ),
              //Phòng ban
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const LabelTextFieldCustom(
                    value: 'Phòng ban',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Selector<AddNewContractLogic, Department>(
                    selector: (_, state) => state.phongban,
                    builder: (_, value, __) {
                      return CustomSelect(
                          title: id != '' &&
                                  id['phongban'].isNotEmpty &&
                                  value.name.isEmpty
                              ? id['phongban']
                              : value.name.isNotEmpty
                                  ? value.name
                                  : 'Chọn phòng ban',
                          icon: Icons.keyboard_arrow_down_outlined,
                          onTap: addNewContractLogic.selectPhongban);
                    },
                  ),
                ],
              ),

              //Ngày bắt đầu
              const SizedBox(
                height: 10,
              ),
              const LabelTextFieldCustom(
                value: 'Ngày bắt đầu',
              ),
              const SizedBox(
                height: 5,
              ),
              Selector<AddNewContractLogic, String>(
                selector: (_, state) => state.startDay,
                builder: (_, value, __) {
                  return CustomSelect(
                    title: id != '' &&
                            id['startDay'].isNotEmpty &&
                            addNewContractLogic.startDay == 'dd/ mm/ yyyy'
                        ? Helper.formatDate(id['startDay'])
                        : addNewContractLogic.startDay == 'dd/ mm/ yyyy'
                            ? 'dd/ mm/ yyyy'
                            : Helper.formatDate(addNewContractLogic.startDay),
                    icon: Icons.calendar_month_outlined,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980, 1, 1),
                        lastDate: DateTime(2030),
                      ).then((value) {
                        if (value != null) {
                          addNewContractLogic.updateStartDay(value,
                              value2: value.add(const Duration(days: 1)));
                        }
                      });
                    },
                  );
                },
              ),

              //Ngày kết thúc
              const SizedBox(
                height: 10,
              ),
              const LabelTextFieldCustom(
                value: 'Ngày kết thúc',
              ),
              const SizedBox(
                height: 5,
              ),
              Selector<AddNewContractLogic, Tuple2<String, String>>(
                selector: (_, state) => Tuple2(state.endDay, state.startDay),
                builder: (_, value, __) {
                  return CustomSelect(
                    title: id != '' &&
                            id['endDay'].isNotEmpty &&
                            addNewContractLogic.endDay == 'dd/ mm/ yyyy'
                        ? Helper.formatDate(id['endDay'])
                        : addNewContractLogic.startDay == 'dd/ mm/ yyyy'
                            ? 'dd/ mm/ yyyy'
                            : Helper.formatDate(addNewContractLogic.endDay),
                    icon: Icons.calendar_month_outlined,
                    onTap: () {
                      if (addNewContractLogic.startDay == 'dd/ mm/ yyyy') {
                        NotifyHelper.showSnackBar('Vui lòng chọn ngày bắt đầu');
                      } else {
                        showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.parse(addNewContractLogic.startDay)
                                  .add(const Duration(days: 1)),
                          firstDate:
                              DateTime.parse(addNewContractLogic.startDay)
                                  .add(const Duration(days: 1)),
                          lastDate: DateTime(2030),
                        ).then((value) {
                          addNewContractLogic.updateEndDay(value);
                        });
                      }
                    },
                  );
                },
              ),

              //Ngày kí hợp đồng
              const SizedBox(
                height: 10,
              ),
              const LabelTextFieldCustom(
                value: 'Ngày kí hợp đồng',
              ),
              const SizedBox(
                height: 5,
              ),
              Selector<AddNewContractLogic, String>(
                selector: (_, state) => state.day,
                builder: (_, value, __) {
                  return CustomSelect(
                      title: id != '' &&
                              id['day'].isNotEmpty &&
                              addNewContractLogic.day == 'dd/ mm/ yyyy'
                          ? Helper.formatDate(id['day'])
                          : addNewContractLogic.day != 'dd/ mm/ yyyy'
                              ? Helper.formatDate(addNewContractLogic.day)
                              : 'dd/ mm/ yyyy',
                      icon: Icons.calendar_month_outlined,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980, 1, 1),
                          lastDate: DateTime.now(),
                        ).then((value) => addNewContractLogic.updateDay(value));
                      });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelTextFieldCustom(
                value: 'Nội dung',
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<AddNewContractLogic>(
                builder: (_, value, __) {
                  return TextFieldCustom(
                    value: '',
                    placeholder: 'Nhập nội dung...',
                    onChanged: (value) {
                      addNewContractLogic.updateValue('content', value);
                    },
                  );
                },
              ),

              const LabelTextFieldCustom(
                value: 'Lương cơ bản',
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<AddNewContractLogic>(
                builder: (_, value, __) {
                  return TextFieldCustom(
                    keyboardType: TextInputType.number,
                    value: '',
                    placeholder: 'Nhập lương cơ bản...',
                    onChanged: (value) {
                      addNewContractLogic.updateValue('salary', value);
                    },
                  );
                },
              ),
              //Nút
              const SizedBox(
                height: 20,
              ),
              //Nút lưu
              InkWell(
                onTap: () {
                  if (addNewContractLogic.name.isNotEmpty) {
                    addNewContractLogic.addNewContract();

                    // print(addNewContractLogic.cmnd);
                  } else {
                    NotifyHelper.showSnackBar(
                        'Vui lòng nhập họ tên nhân viên!');
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child:
                        Text(id!.isNotEmpty ? 'Cập nhật' : 'Thêm mới hợp đồng',
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
      ),
    );
  }
}
