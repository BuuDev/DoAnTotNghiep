import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Timekeep/time_keep_data.dart';
import 'package:doantotnghiep/Services/Api/Timekeep/timekeep_api.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:doantotnghiep/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'timekeeping_logic.dart';

class TimekeepingSceen extends StatefulWidget {
  const TimekeepingSceen({Key? key}) : super(key: key);

  @override
  State<TimekeepingSceen> createState() => _TimekeepingSceenState();
}

class _TimekeepingSceenState extends State<TimekeepingSceen>
    with AutomaticKeepAliveClientMixin {
  late TimeKeepingLogic timeKeepingLogic;
  @override
  void initState() {
    super.initState();
    timeKeepingLogic = TimeKeepingLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: timeKeepingLogic,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Selector<TimeKeepingLogic, String>(
                selector: (_, state) => state.currentDateShow,
                builder: (_, value, __) {
                  return InkWell(
                    onTap: () {
                      timeKeepingLogic.selectDate(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Selector<TimeKeepingLogic, List<TimeKeepData>>(
                selector: (p0, p1) => p1.data,
                builder: ((context, value, child) {
                  if (value.isEmpty) {
                    return const Text('Không có dữ liệu');
                  }
                  return Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: RefreshIndicator(
                        color: AppColors.textBlack,
                        onRefresh: () async {
                          return Future<void>.delayed(
                              const Duration(seconds: 1), () {
                            timeKeepingLogic.loadData();
                          });
                        },
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Column(
                              children: List.generate(
                                value.length,
                                (index) => Card(
                                  margin: const EdgeInsets.only(top: 10),
                                  color: AppColors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(1),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 80,
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            child: Image.network(
                                              value[index].user == null
                                                  ? ''
                                                  : value[index].user!.avatar ??
                                                      '',
                                              fit: BoxFit.fill,
                                              errorBuilder: (context, exception,
                                                  stackTrace) {
                                                return Image.asset(
                                                  Assets.images.avatarNull.path,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  child: Text(
                                                      value[index].user == null
                                                          ? ''
                                                          : value[index]
                                                                  .user!
                                                                  .fullname ??
                                                              '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Checkin: ${value[index].tachCheckIn()}',
                                                  style: const TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Checkout: ${value[index].tachCheckOut()}',
                                                  style: const TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Time: ${value[index].thoiGianLamViec()}',
                                                  style: const TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: AppColors.primary,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes()
                                                            .timeKeepingDetail,
                                                        arguments:
                                                            value[index]);
                                                  },
                                                  child: const Text(
                                                    'Chấm công',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
