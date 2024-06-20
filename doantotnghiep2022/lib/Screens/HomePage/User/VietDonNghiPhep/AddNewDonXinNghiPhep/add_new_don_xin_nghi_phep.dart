import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/Services/Helper/helper.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/CustomSelect/custom_select.dart';
import 'package:doantotnghiep/Widgets/LabelCustom/label_textfield_custom.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
part 'add_new_don_xin_nghi_phep_logic.dart';

class AddNewDonXinNghiPhep extends StatefulWidget {
  const AddNewDonXinNghiPhep({Key? key}) : super(key: key);

  @override
  State<AddNewDonXinNghiPhep> createState() => _AddNewDonXinNghiPhepState();
}

class _AddNewDonXinNghiPhepState extends State<AddNewDonXinNghiPhep> {
  late AddNewDonXinNghiPhepLogic addNewDonXinNghiPhepLogic;
  @override
  void initState() {
    super.initState();
    addNewDonXinNghiPhepLogic = AddNewDonXinNghiPhepLogic(context: context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dynamic id = ModalRoute.of(context)!.settings.arguments as dynamic;
      if (id != '') {
        addNewDonXinNghiPhepLogic.updateStartDay(id.start_date,
            value2: id.finish_date);
        addNewDonXinNghiPhepLogic.updateEndDay(id.finish_date);
        addNewDonXinNghiPhepLogic.updateTxtLido(id.reason ?? '');
      }
    });
  }

  @override
  void dispose() {
    addNewDonXinNghiPhepLogic.dispose();
    super.dispose();
  }

  dynamic get id => ModalRoute.of(context)!.settings.arguments as dynamic;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addNewDonXinNghiPhepLogic,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: Text(
            id != '' ? 'Sửa đơn nghỉ phép' : 'Thêm Đơn Nghỉ Phép',
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
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textBlack,
                size: 15,
              )),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LabelTextFieldCustom(
                value: 'Ngày bắt đầu',
              ),
              const SizedBox(
                height: 5,
              ),
              Selector<AddNewDonXinNghiPhepLogic, String>(
                selector: (_, state) => state.startDay,
                builder: (_, value, __) {
                  return CustomSelect(
                    title: id != '' &&
                            id.start_date.isNotEmpty &&
                            addNewDonXinNghiPhepLogic.startDay == 'dd/ mm/ yyyy'
                        ? Helper.formatDate(id.start_date)
                        : addNewDonXinNghiPhepLogic.startDay == 'dd/ mm/ yyyy'
                            ? 'dd/ mm/ yyyy'
                            : Helper.formatDate(
                                addNewDonXinNghiPhepLogic.startDay),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ).then((value) {
                        if (value != null) {
                          addNewDonXinNghiPhepLogic.updateStartDay(
                            value,
                            // value2: value.add(const Duration(days: 1))
                            value2: value,
                          );
                        }
                      });
                    },
                    icon: Icons.calendar_today_outlined,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              //Ngày kết thúc
              const LabelTextFieldCustom(
                value: 'Ngày kết thúc',
              ),
              const SizedBox(
                height: 5,
              ),
              Selector<AddNewDonXinNghiPhepLogic, Tuple2<String, String>>(
                selector: (_, state) => Tuple2(state.endDay, state.startDay),
                builder: (_, value, __) {
                  return CustomSelect(
                    title: id != '' &&
                            id.finish_date.isNotEmpty &&
                            addNewDonXinNghiPhepLogic.endDay == 'dd/ mm/ yyyy'
                        ? Helper.formatDate(id.finish_date)
                        : addNewDonXinNghiPhepLogic.endDay == 'dd/ mm/ yyyy'
                            ? 'dd/ mm/ yyyy'
                            : Helper.formatDate(
                                addNewDonXinNghiPhepLogic.endDay),
                    onTap: () {
                      if (addNewDonXinNghiPhepLogic.startDay ==
                          'dd/ mm/ yyyy') {
                        NotifyHelper.showSnackBar('Vui lòng chọn ngày bắt đầu');
                      } else {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(
                              addNewDonXinNghiPhepLogic.startDay),
                          firstDate: DateTime.parse(
                              addNewDonXinNghiPhepLogic.startDay),
                          lastDate: DateTime(2030),
                        ).then((value) {
                          if (value != null) {
                            addNewDonXinNghiPhepLogic.updateEndDay(value);
                          }
                        });
                      }
                    },
                    icon: Icons.calendar_today_outlined,
                  );
                },
              ),
              //Lí do
              const SizedBox(
                height: 10,
              ),
              const LabelTextFieldCustom(
                value: 'Lí do',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFieldCustom(
                // value: addNewDonXinNghiPhepLogic.lido,
                controller: addNewDonXinNghiPhepLogic.txtLido
                  ..text = id != '' ? id.reason : '',
                onChanged: (val) {
                  addNewDonXinNghiPhepLogic.updateTxtLido(val);
                },
                placeholder: 'Nhập nội dung...',
                height: 300,
                maxline: 20,
                paddingTop: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              //Nút lưu
              Consumer<AddNewDonXinNghiPhepLogic>(
                builder: (_, value, __) {
                  return InkWell(
                    onTap: () {
                      if (id != '') {
                        addNewDonXinNghiPhepLogic.updateAnnualLeave(
                            id.id,
                            Provider.of<AccountLogic>(context, listen: false)
                                .user!
                                .id!);
                      } else {
                        if (addNewDonXinNghiPhepLogic.lido == '' ||
                            addNewDonXinNghiPhepLogic.startDay ==
                                'dd/ mm/ yyyy' ||
                            addNewDonXinNghiPhepLogic.endDay ==
                                'dd/ mm/ yyyy') {
                          NotifyHelper.showSnackBar(
                              'Vui lòng điền đầy đủ thông tin!');
                        } else {
                          addNewDonXinNghiPhepLogic.addNew(
                              Provider.of<AccountLogic>(context, listen: false)
                                  .user!
                                  .id!);
                        }
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
                        child: Text(id != '' ? 'Lưu' : 'Gửi',
                            style: const TextStyle(
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
