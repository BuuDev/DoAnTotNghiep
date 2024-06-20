import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/don_xin_nghi_phep/annual_leave.dart';
import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/DonXinNghiPhep/don_xin_nghi_phep_custom_widget.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
part 'viet_don_nghi_phep_logic.dart';

class VietDonNghiPhep extends StatefulWidget {
  const VietDonNghiPhep({Key? key}) : super(key: key);

  @override
  State<VietDonNghiPhep> createState() => _VietDonNghiPhepState();
}

class _VietDonNghiPhepState extends State<VietDonNghiPhep> {
  late VietDonNghiPhepLogic vietDonNghiPhepLogic;
  @override
  void initState() {
    super.initState();
    vietDonNghiPhepLogic = VietDonNghiPhepLogic();
    int? userId = context.read<AccountLogic>().user!.id;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      vietDonNghiPhepLogic.getListAnnualLeave();
    });
  }

  @override
  void dispose() {
    vietDonNghiPhepLogic.dispose();
    super.dispose();
  }

  String status(int value) {
    String response = '';
    if (value == 1) {
      response = 'đã duyệt';
    } else if (value == 0) {
      response = 'đang chờ duyệt';
    } else {
      response = 'đã huỷ';
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vietDonNghiPhepLogic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: const Text(
            'Đơn xin nghỉ phép',
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes().addNewDonXinNghiPhep,
                          arguments: '')
                      .then((dynamic value) {
                    if (value != null) {
                      vietDonNghiPhepLogic.getListAnnualLeave();
                    }
                  });
                },
                icon: const Icon(Icons.post_add_rounded,
                    color: AppColors.textBlack))
          ],
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextFieldSearch(
                placeholder: 'Tìm kiếm đơn nghỉ phép...',
                readOnly: true,
                onTap: () {
                  showMonthPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  ).then((value) {
                    if (value != null) {
                      vietDonNghiPhepLogic.search(value.toString());
                    }
                  });
                },
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.tertiary,
                    )),
              ),
            ),
            preferredSize: const Size.fromHeight(45),
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: vietDonNghiPhepLogic.restore,
                    child: const Text(
                      'Các đơn đã tạo',
                      style: TextStyle(
                        color: AppColors.acne3,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: vietDonNghiPhepLogic.sort,
                      child: const Text('Sắp xếp'))
                ],
              ),
              Consumer<VietDonNghiPhepLogic>(
                builder: (_, value, __) {
                  return value.lstDonXinNghiPhep.isEmpty
                      ? !value.load
                          ? Container(
                              color: AppColors.transparent,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width / 3,
                              child: const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 2,
                                    child: Image.asset(
                                      Assets.images.empty.path,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text('Danh sách đơn nghỉ phép trống'),
                                ],
                              ),
                            )
                      : Column(
                          children: List.generate(
                              vietDonNghiPhepLogic.lstDonXinNghiPhep.length,
                              (index) => Column(
                                    children: [
                                      DonXinNghiPhep(
                                        id: vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index].id,
                                        name: vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index]
                                            .user
                                            .fullname!,
                                        startDay: vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index]
                                            .start_date,
                                        endDay: vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index]
                                            .finish_date,
                                        lido: vietDonNghiPhepLogic
                                                .lstDonXinNghiPhep[index]
                                                .reason ??
                                            '',
                                        lidoHuy: vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index]
                                            .reason_not_approving,
                                        status: status(vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index].status),
                                        totalDay: vietDonNghiPhepLogic
                                            .lstDonXinNghiPhep[index].total_day,
                                        edit: () {
                                          if (status(vietDonNghiPhepLogic
                                                  .lstDonXinNghiPhep[index]
                                                  .status) !=
                                              'đã huỷ') {
                                            Navigator.pushNamed(
                                                    context,
                                                    Routes()
                                                        .addNewDonXinNghiPhep,
                                                    arguments: vietDonNghiPhepLogic
                                                            .lstDonXinNghiPhep[
                                                        index])
                                                .then((dynamic value) {
                                              if (value != null) {
                                                vietDonNghiPhepLogic
                                                    .getListAnnualLeave();
                                              }
                                            }).then((value) =>
                                                    Navigator.pop(context));
                                          } else {
                                            NotifyHelper.showSnackBar(
                                                'Đơn đã huỷ không được phép chỉnh sửa');
                                            Navigator.pop(context);
                                          }
                                        },
                                        delete: () {
                                          vietDonNghiPhepLogic.delete(
                                              vietDonNghiPhepLogic
                                                  .lstDonXinNghiPhep[index].id);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      vietDonNghiPhepLogic
                                                  .lstDonXinNghiPhep[index]
                                                  .reason_not_approving !=
                                              null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 15,
                                              ),
                                              child: Text(
                                                  'Lí do huỷ(admin):${vietDonNghiPhepLogic.lstDonXinNghiPhep[index].reason_not_approving}'),
                                            )
                                          : const SizedBox()
                                    ],
                                  )).reversed.toList(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
