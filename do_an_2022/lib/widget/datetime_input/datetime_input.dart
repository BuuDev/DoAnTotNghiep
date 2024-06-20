import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../theme/color.dart';

class DateTimeInput extends StatefulWidget {
  final DateTime? date;
  DateTimeInput({Key? key, required this.date}) : super(key: key);

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  late DateTime? _currentdate;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _currentdate = DateTime(0);
    if (widget.date != null) {
      _currentdate = widget.date!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String _formattedate = new DateFormat.yMMMd().format(_currentdate!);
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          enabled: true,
          keyboardType: TextInputType.none,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2200));
            if (newDate == null) return;
            setState(() => _currentdate = newDate);
          },
          style: const TextStyle(color: AppColors.textBlack),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.date_range,
              color: AppColors.primary,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            // ignore: unnecessary_null_comparison

            hintText: _currentdate == DateTime(0)
                ? "Thêm ngày"
                : _formattedate.toString(),
            hintStyle: TextStyle(
                color: AppColors.textBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
