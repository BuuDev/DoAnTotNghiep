import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Contract/contract.dart';
import 'package:doantotnghiep/Services/Api/Contract/contract.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Widgets/ContractWidget/contract_widget.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'contract_personal_logic.dart';

class ContractPersonal extends StatefulWidget {
  const ContractPersonal({Key? key}) : super(key: key);

  @override
  State<ContractPersonal> createState() => _ContractPersonalState();
}

class _ContractPersonalState extends State<ContractPersonal> {
  late ContractPersonalLogic contractPersonalLogic;

  @override
  void initState() {
    super.initState();
    contractPersonalLogic = ContractPersonalLogic();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      contractPersonalLogic.getListContract(context);
    });
  }

  @override
  void dispose() {
    contractPersonalLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: contractPersonalLogic,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0.0,
          title: const Text(
            'Hợp đồng cá nhân',
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
            Consumer<ContractPersonalLogic>(
              builder: (_, value, __) {
                return IconButton(
                    onPressed: () {
                      if (contractPersonalLogic.lst.isEmpty &&
                          contractPersonalLogic.old == false) {
                        NotifyHelper.showSnackBar(
                            'Bạn chưa có hợp đồng cần gia hạn');
                      } else {
                        Navigator.pushNamed(
                            context, Routes().addNewContractPersonal,
                            arguments: [
                              'giahan',
                              contractPersonalLogic
                                  .lst[contractPersonalLogic.lst.length - 1],
                            ]).then((dynamic value) {
                          if (value == true) {
                            contractPersonalLogic.getListContract(context);
                          }
                        });
                      }
                    },
                    icon: const Icon(Icons.add_card_rounded,
                        color: AppColors.textBlack));
              },
            )
          ],
          // bottom: PreferredSize(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //     child: TextFieldSearch(
          //       placeholder: 'Tìm kiếm hợp đồng',
          //       onChanged: (val) {
          //         contractPersonalLogic.search(val);
          //       },
          //     ),
          //   ),
          //   preferredSize: const Size.fromHeight(45),
          // ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Consumer<ContractPersonalLogic>(
                builder: (_, value, __) {
                  return !value.isHideButtonSort
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hợp đồng ( ${contractPersonalLogic.lst.length} )',
                              style: const TextStyle(
                                color: AppColors.acne3,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: contractPersonalLogic.old,
                                    onChanged: (val) {
                                      contractPersonalLogic
                                          .changeValueOld(context);
                                    }),
                                const Text('Hợp đồng cũ'),
                              ],
                            ),
                            TextButton(
                                onPressed: contractPersonalLogic.sort,
                                child: const Text('Sắp xếp'))
                          ],
                        )
                      : const SizedBox();
                },
              ),
              Consumer<ContractPersonalLogic>(
                builder: (_, value, __) {
                  return value.lst.isNotEmpty
                      ? Column(
                          children: List.generate(
                            value.lst.length,
                            (index) => ContractWidget(
                              hideButton: value.lst[index].contractId == null
                                  ? false
                                  : true,
                              title: 'Chỉnh sửa hợp đồng',
                              nameEmployee: value.lst[index].user!.fullname,
                              startDay: value.lst[index].startDate,
                              endDay: value.lst[index].finishDate,
                              day: value.lst[index].signingDate,
                              index: index,
                              solangiahan: value.lst[index].count,
                              giahan: () {
                                Navigator.pushNamed(
                                    context, Routes().addNewContractPersonal,
                                    arguments: [
                                      'edit',
                                      value.lst[index]
                                    ]).then((value) {
                                  if (value == true) {
                                    contractPersonalLogic
                                        .getListContract(context);
                                  }
                                });
                              },
                              // kethuc: () {
                              //   deleteContract(context, value.lst[index]['id']);
                              // },
                            ),
                          ).reversed.toList(),
                        )
                      : !contractPersonalLogic.load
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
                                  const Text('Danh sách hợp đồng trống'),
                                ],
                              ),
                            );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteContract(BuildContext context, int id) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Bạn có thật sự muốn kết thúc hợp đồng này?',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Monserrat',
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.red,
                        ),
                        child: const Center(
                          child: Text(
                            'Không',
                            style: TextStyle(
                              color: AppColors.white,
                              fontFamily: 'Monserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        contractPersonalLogic.delete(id);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primary,
                        ),
                        child: const Center(
                          child: Text(
                            'Đồng ý',
                            style: TextStyle(
                              color: AppColors.white,
                              fontFamily: 'Monserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
