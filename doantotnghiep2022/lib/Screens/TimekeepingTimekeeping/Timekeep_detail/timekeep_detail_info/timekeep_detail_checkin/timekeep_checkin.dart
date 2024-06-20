import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Models/Task_Timekeep/task_timekeep.dart';
import 'package:doantotnghiep/Models/Timekeep/time_keep.dart';
import 'package:doantotnghiep/Models/Timekeep/time_keep_data.dart';
import 'package:doantotnghiep/Services/Api/AnnualLeave/annualLeave.dart';
import 'package:doantotnghiep/Services/Api/Timekeep/timekeep_api.dart';
import 'package:doantotnghiep/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuple/tuple.dart';
part 'timekeep_detail_checkin_logic.dart';

class TimeKeepCheckIn extends StatefulWidget {
  const TimeKeepCheckIn({Key? key}) : super(key: key);

  @override
  State<TimeKeepCheckIn> createState() => _TimeKeepCheckInState();
}

class _TimeKeepCheckInState extends State<TimeKeepCheckIn>
    with AutomaticKeepAliveClientMixin {
  late CheckInLogic checkIn;

  @override
  void initState() {
    super.initState();
    checkIn = CheckInLogic();
    context.read<CheckInLogic>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    TimeKeepData infor =
        ModalRoute.of(context)!.settings.arguments as TimeKeepData;

    checkIn.getData(DateFormat('yyyy-MM').format(DateTime.parse(infor.date!)),
        infor.user_id);
    return ChangeNotifierProvider.value(
        value: checkIn,
        child: Consumer<CheckInLogic>(
          builder: (context, value, child) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Selector<CheckInLogic, Tuple3<int, int, int>>(
                        selector: (p0, p1) =>
                            Tuple3(p1.ngayCong, p1.chuaDuGio, p1.nghiLam),
                        builder: (context, value, __) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              side: BorderSide(
                                color: Colors.black.withOpacity(1),
                                width: 0.5,
                              ),
                            ),
                            color: AppColors.white,
                            elevation: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25, bottom: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${value.item1 + value.item2}/${checkIn.soNgayLam}',
                                            style: const TextStyle(
                                                color: AppColors.green,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const Text(
                                            'Ngày công',
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.more_vert,
                                        size: 20,
                                        color: AppColors.gray,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${value.item2}',
                                            style: const TextStyle(
                                                color: AppColors.secondary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const Text(
                                            'Chưa đủ giờ',
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.more_vert,
                                        size: 20,
                                        color: AppColors.gray,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${value.item3}',
                                            style: const TextStyle(
                                                color: AppColors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const Text(
                                            'Nghỉ đã duyệt',
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                    Divider(
                      height: 5,
                      thickness: 2,
                      indent: 8,
                      endIndent: 8,
                      color: AppColors.gray.withOpacity(0.2),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Tháng: ${checkIn.mouth.month}-${checkIn.mouth.year}',
                                style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        if (value.checkbutton) ...[
                          ElevatedButton(
                            onPressed: () {
                              if (value.checkEvent) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ChangeNotifierProvider.value(
                                          value: checkIn,
                                          child: Consumer<CheckInLogic>(
                                            builder: (context, value1, child) {
                                              return Dialog(
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.0))),
                                                child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 40),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.white,
                                                      ),
                                                      width: double.infinity,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 70,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12),
                                                            child: Text(
                                                              "Bạn có muốn chấm công cho nhân viên ${infor.user!.fullname}?",
                                                              style:
                                                                  const TextStyle(
                                                                color: AppColors
                                                                    .textBlack,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        10),
                                                            child: Text(
                                                              "Ngày chọn chấm công: ${DateFormat('yyyy-MM-dd').format(checkIn.focusedDay)}",
                                                              style:
                                                                  const TextStyle(
                                                                color: AppColors
                                                                    .textBlack,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      AppColors
                                                                          .primary,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          5),
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    value.timeKeep(DateFormat(
                                                                            'yyyy-MM-dd')
                                                                        .format(DateTime.parse(value
                                                                            .focusedDay
                                                                            .toString())));
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                },
                                                                child: const Text(
                                                                    'Xác nhận',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      AppColors
                                                                          .red,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          41,
                                                                      vertical:
                                                                          5),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    'Hủy',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 20)
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 0,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                            Assets.images.iconBg
                                                                .path,
                                                          ),
                                                          radius: 45,
                                                        )),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                            ),
                            child: const Text('Chấm công',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ]
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 300,
                      child: TableCalendar(
                          locale: Localizations.localeOf(context).languageCode,
                          shouldFillViewport: true,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: value.mouth,
                          headerVisible: false,
                          eventLoader: (day) => value.data.where((event) {
                                return isSameDay(
                                    DateTime.parse(event.date!), day);
                              }).toList(),
                          onPageChanged: (selectMouth) {
                            value.onPageMouth(selectMouth, infor.user_id);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            value.selected(selectedDay, focusedDay);
                            value.checkEvents(selectedDay);
                            value.getTaskTimeKeep(
                                infor.user_id,
                                DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(focusedDay.toString())));
                          },
                          selectedDayPredicate: (date) {
                            return isSameDay(value.selectedDay, date);
                          },
                          calendarBuilders: CalendarBuilders(
                            singleMarkerBuilder: (context, date, event) {
                              if (event.toString() == 'đi làm') {
                                return Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.green),
                                  width: 10,
                                  height: 10,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                );
                              } else if (event.toString() == 'đi muộn') {
                                return Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.orange),
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.5),
                                );
                              } else if (event.toString() == 'nghỉ làm') {
                                return Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.red),
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.5),
                                );
                              } else if (event.toString() == 'chua duyet') {
                                return Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary),
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.5),
                                );
                              }
                              return Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.black),
                                width: 10,
                                height: 10,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1.5),
                              );
                            },
                          ),
                          calendarStyle: const CalendarStyle(
                            defaultDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle:
                                TextStyle(color: AppColors.white),
                            todayDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: AppColors.colorCard,
                              shape: BoxShape.circle,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...value
                        .getEvent(value.selectedDay)
                        .map((TaskTimeKeepData event) {
                      return Scrollbar(
                        child: Column(
                          children:
                              List.generate(value.dataTask.length, (index) {
                            return Card(
                              elevation: 2,
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.3),
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Ngày hoàn thành:  ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.colorCard),
                                        ),
                                        Text(
                                            DateFormat('dd-MM-yyyy').format(
                                                DateTime.parse(
                                                    event.complete_at)),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tên công việc:  ',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.colorCard),
                                        ),
                                        Expanded(
                                          child: Text(
                                            event.title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Nội dung: ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.colorCard),
                                        ),
                                        Expanded(
                                          child: Text(
                                            event.content,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Trạng thái : ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.colorCard),
                                        ),
                                        Text(
                                          event.status == 1
                                              ? 'Đã hoàn thành'
                                              : 'Chưa hoàn thành',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
