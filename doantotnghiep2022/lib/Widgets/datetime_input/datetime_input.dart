import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Config/Colors/colors.dart';

class DateTimeInput extends StatefulWidget {
  final String? date;
  final bool checkDateTaskorWork;
  final void Function(
    String? value,
  ) onCheck;
  const DateTimeInput(
      {Key? key,
      required this.date,
      required this.checkDateTaskorWork,
      required this.onCheck})
      : super(key: key);

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  String? _currentdate;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _currentdate = "";
    if (widget.date != null) {
      _currentdate = widget.date!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return Container(
        width: double.infinity,
        color: AppColors.white,
        child: InkWell(
            onTap: (() async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _currentdate!.isEmpty
                      ? DateTime.now()
                      : DateFormat(widget.checkDateTaskorWork
                              ? 'yyyy-MM-dd hh:mm:ss'
                              : "dd/MM/yyyy")
                          .parse(_currentdate!),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200));
              if (newDate == null) return;
              setState(() {
                if (widget.checkDateTaskorWork) {
                  _currentdate =
                      DateFormat('yyyy-MM-dd hh:mm:ss').format(newDate);
                } else {
                  _currentdate = DateFormat('dd/MM/yyyy').format(newDate);
                }

                widget.onCheck(_currentdate);
              });
            }),
            child: ListTile(
              leading: const Icon(
                Icons.date_range,
                color: AppColors.primary,
              ),
              title: Text(
                _currentdate == "" ? "Thêm ngày" : _currentdate!,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 16,
                      color: AppColors.textBlueBlack,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )));
  }
}
