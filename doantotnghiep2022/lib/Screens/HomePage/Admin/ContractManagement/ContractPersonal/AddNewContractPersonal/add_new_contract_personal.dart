import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Services/Api/Contract/contract.dart';
import 'package:doantotnghiep/Services/Api/Salary/salary_api.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/CustomSelect/custom_select.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:tuple/tuple.dart';
part 'add_new_contract_personal_logic.dart';

class AddNewContractPersonal extends StatefulWidget {
  const AddNewContractPersonal({Key? key}) : super(key: key);

  @override
  State<AddNewContractPersonal> createState() => _AddNewContractPersonalState();
}

class _AddNewContractPersonalState extends State<AddNewContractPersonal> {
  List<dynamic> get id =>
      ModalRoute.of(context)!.settings.arguments as List<dynamic>;

  late AddNewContractPersonalLogic addNewContractLogic;
  ValueNotifier<selectNV> type = ValueNotifier(selectNV.oldEmployee);
  @override
  void initState() {
    super.initState();
    addNewContractLogic = AddNewContractPersonalLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      addNewContractLogic.updateStartDay(id[1]!.startDate,
          value2: id[1]!.finishDate);
      addNewContractLogic.updateEndDay(id[1]!.finishDate);
      addNewContractLogic.updateDay(id[1]!.signingDate);
      addNewContractLogic.updateValue('content', id[1]!.content);
      addNewContractLogic.updateValue('salary', id[1]!.salary.toString());
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
            id.isNotEmpty && id[0] == 'giahan'
                ? 'Gia hạn hợp đồng'
                : 'Chỉnh sửa hợp đồng',
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
              //Ngày bắt đầu
              const SizedBox(
                height: 5,
              ),
              const LabelTextFieldCustom(
                value: 'Ngày bắt đầu',
              ),
              const SizedBox(
                height: 5,
              ),
              Selector<AddNewContractPersonalLogic, String>(
                selector: (_, state) => state.startDay,
                builder: (_, value, __) {
                  return CustomSelect(
                    title: id != null &&
                            id[1]!.startDate.isNotEmpty &&
                            addNewContractLogic.startDay == 'dd/ mm/ yyyy'
                        ? Helper.formatDate(id[1]!.startDate)
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
              Selector<AddNewContractPersonalLogic, Tuple2<String, String>>(
                selector: (_, state) => Tuple2(state.endDay, state.startDay),
                builder: (_, value, __) {
                  return CustomSelect(
                    title: id != null &&
                            id[1]!.finishDate.isNotEmpty &&
                            addNewContractLogic.endDay == 'dd/ mm/ yyyy'
                        ? Helper.formatDate(id[1]!.finishDate)
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
              Selector<AddNewContractPersonalLogic, String>(
                selector: (_, state) => state.day,
                builder: (_, value, __) {
                  return CustomSelect(
                      title: id.isNotEmpty &&
                              id[1]!.signingDate.isNotEmpty &&
                              addNewContractLogic.day == 'dd/ mm/ yyyy'
                          ? Helper.formatDate(id[1]!.signingDate)
                          : addNewContractLogic.day == 'dd/ mm/ yyyy'
                              ? 'dd/ mm/ yyyy'
                              : Helper.formatDate(addNewContractLogic.day),
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
              const LabelTextFieldCustom(value: 'Nội dung'),
              const SizedBox(
                height: 5,
              ),
              Consumer<AddNewContractPersonalLogic>(
                builder: (_, value, __) {
                  return TextFieldCustom(
                    controller: addNewContractLogic.txtContent
                      ..text = id.isNotEmpty ? id[1].content : '',
                    placeholder: 'nhập nội dung hợp đồng...',
                    onChanged: (val) {
                      addNewContractLogic.updateValue('content', val);
                    },
                  );
                },
              ),
              const LabelTextFieldCustom(value: 'Mức lương cơ bản'),
              const SizedBox(
                height: 5,
              ),
              Consumer<AddNewContractPersonalLogic>(
                builder: (_, value, __) {
                  return TextFieldCustom(
                    controller: addNewContractLogic.txtSalary
                      ..text = id.isNotEmpty ? id[1]!.salary.toString() : '',
                    placeholder: 'nhập lương cơ bản...',
                    onChanged: (val) {
                      addNewContractLogic.updateValue('salary', val);
                    },
                  );
                },
              ),
              //Nút
              const SizedBox(
                height: 20,
              ),
              //Nút lưu
              Consumer<AddNewContractPersonalLogic>(
                builder: (_, value, __) {
                  return InkWell(
                    onTap: () {
                      if (addNewContractLogic.startDay != 'dd/ mm/ yyyy' &&
                          addNewContractLogic.endDay != 'dd/ mm/ yyyy' &&
                          addNewContractLogic.day != 'dd/ mm/ yyyy') {
                        if (id.isNotEmpty && id[0] == 'giahan') {
                          addNewContractLogic.extendContract(
                              id[1]!.id, id[1]!.userId);
                        } else {
                          addNewContractLogic.updateContract(
                              id[1]!.id, id[1]!.userId);
                        }
                        // print(addNewContractLogic.day);
                      } else {
                        NotifyHelper.showSnackBar(
                            'Vui lòng nhâp đầy đủ thông tin!');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                      ),
                      child: const Center(
                        child: Text('Lưu',
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
        ),
      ),
    );
  }
}
