import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Contract/contract.dart';
import 'package:doantotnghiep/Services/Api/Contract/contract.dart';
import 'package:doantotnghiep/Widgets/ContractWidget/contract_widget.dart';
import 'package:doantotnghiep/Widgets/TextFieldSearch/textfield_search.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'contract_management_logic.dart';

class ContractManagement extends StatefulWidget {
  const ContractManagement({Key? key}) : super(key: key);

  @override
  State<ContractManagement> createState() => _ContractManagementState();
}

class _ContractManagementState extends State<ContractManagement>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late ContractManagementLogic contractManagementLogic;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    contractManagementLogic = ContractManagementLogic();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        int index = ModalRoute.of(context)!.settings.arguments as int;
        tabController.animateTo(index);
      }
    });
  }

  @override
  void dispose() {
    contractManagementLogic.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: contractManagementLogic,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
                backgroundColor: AppColors.transparent,
                elevation: 0.0,
                title: const Text(
                  'Danh sách hợp đồng',
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
                        Navigator.pushNamed(context, Routes().addNewContract,
                                arguments: '')
                            .then((value) {
                          if (value == true) {
                            contractManagementLogic.getAllListContract();
                          }
                        });
                      },
                      icon: const Icon(Icons.add_card_rounded,
                          color: AppColors.textBlack))
                ],
                bottom: PreferredSize(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: TextFieldSearch(
                          placeholder: 'Tìm hợp đồng theo tên nhân viên...',
                          onChanged: (val) {
                            contractManagementLogic.search(val);
                            contractManagementLogic.search2(val);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            tabs: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Tất cả hợp đồng',
                                      style: TextStyle(
                                        color: AppColors.acne3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Hợp đồng sắp hết hạn',
                                style: TextStyle(
                                  color: AppColors.acne3,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  preferredSize: const Size.fromHeight(100),
                )),
            body: TabBarView(controller: tabController, children: [
              RefreshIndicator(
                onRefresh: () async =>
                    contractManagementLogic.getAllListContract(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Consumer<ContractManagementLogic>(
                        builder: (_, value, __) {
                          return !value.isHideButtonSort
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hợp đồng ( ${contractManagementLogic.lst.length} )',
                                      style: const TextStyle(
                                        color: AppColors.acne3,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: contractManagementLogic.old,
                                            onChanged: (val) {
                                              contractManagementLogic
                                                  .changeValueOld(context);
                                            }),
                                        const Text('Hợp đồng cũ'),
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: contractManagementLogic.sort,
                                        child: const Text('Sắp xếp'))
                                  ],
                                )
                              : const SizedBox();
                        },
                      ),
                      Consumer<ContractManagementLogic>(
                        builder: (_, value, __) {
                          return value.lst.isNotEmpty
                              ? Column(
                                  children: List.generate(
                                    value.lst.length,
                                    (index) => ContractWidget(
                                      nameEmployee:
                                          value.lst[index].user != null
                                              ? value.lst[index].user!.fullname
                                              : '',
                                      startDay: value.lst[index].startDate,
                                      endDay: value.lst[index].finishDate,
                                      day: value.lst[index].signingDate,
                                      index: index + 1,
                                      solangiahan: value.lst[index].count,
                                      hideButton: true,
                                      giahan: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes().addNewContractPersonal,
                                          arguments: [
                                            'giahan',
                                            value.lst[index],
                                          ],
                                        ).then((value) {
                                          if (value == true) {
                                            contractManagementLogic
                                                .getAllListContract();
                                          }
                                        });
                                      },
                                      onEdit:
                                          value.lst[index].contractId != null
                                              ? false
                                              : true,
                                      edit: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes().addNewContractPersonal,
                                          arguments: [
                                            'edit',
                                            value.lst[index],
                                          ],
                                        ).then((value) {
                                          if (value == true) {
                                            contractManagementLogic
                                                .getAllListContract();
                                          }
                                        });
                                      },
                                    ),
                                  ).reversed.toList(),
                                )
                              : !contractManagementLogic.load
                                  ? Container(
                                      color: AppColors.transparent,
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.width / 3,
                                      child: const Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
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
                                          const Text(
                                              'Danh sách hợp đồng trống'),
                                        ],
                                      ),
                                    );
                        },
                      )
                    ],
                  ),
                ),
              ),
              //hợp đồng sắp hết hạn
              RefreshIndicator(
                onRefresh: () async =>
                    contractManagementLogic.getAllListContract(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Consumer<ContractManagementLogic>(
                        builder: (_, value, __) {
                          return !value.isHideButtonSort2
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hợp đồng ( ${contractManagementLogic.lstContractIsAboutToExpire.length} )',
                                      style: const TextStyle(
                                        color: AppColors.acne3,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed:
                                            contractManagementLogic.sort2,
                                        child: const Text('Sắp xếp'))
                                  ],
                                )
                              : const SizedBox();
                        },
                      ),
                      Consumer<ContractManagementLogic>(
                        builder: (_, value, __) {
                          return value.lstContractIsAboutToExpire.isNotEmpty
                              ? Column(
                                  children: List.generate(
                                    value.lstContractIsAboutToExpire.length,
                                    (index) => ContractWidget(
                                      nameEmployee: value
                                              .lstContractIsAboutToExpire[index]
                                              .user!
                                              .fullname ??
                                          '',
                                      startDay: value
                                          .lstContractIsAboutToExpire[index]
                                          .startDate,
                                      endDay: value
                                          .lstContractIsAboutToExpire[index]
                                          .finishDate,
                                      day: value
                                          .lstContractIsAboutToExpire[index]
                                          .signingDate,
                                      index: index + 1,
                                      solangiahan: value
                                          .lstContractIsAboutToExpire[index]
                                          .count,
                                      giahan: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes().addNewContractPersonal,
                                          arguments: [
                                            'giahan',
                                            value.lstContractIsAboutToExpire[
                                                index],
                                          ],
                                        ).then((value) {
                                          if (value == true) {
                                            contractManagementLogic
                                                .getListContractIsAboutToExpire();
                                          }
                                        });
                                      },
                                      edit: () {},
                                    ),
                                  ).reversed.toList(),
                                )
                              : !contractManagementLogic.load
                                  ? Container(
                                      color: AppColors.transparent,
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.width / 3,
                                      child: const Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
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
                                          const Text(
                                              'Chưa có hợp đồng cần gia hạn'),
                                        ],
                                      ),
                                    );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
          )),
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
                        contractManagementLogic.delete(id);
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

  @override
  bool get wantKeepAlive => true;
}
