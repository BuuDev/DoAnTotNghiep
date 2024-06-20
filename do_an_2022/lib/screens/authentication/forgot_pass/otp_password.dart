import 'package:demo_retrofit_api/screens/authentication/forgot_pass/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../../theme/color.dart';
import '../../../widget/appbar_back/appbarback.dart';

class OTPPagePassWord extends StatefulWidget {
  const OTPPagePassWord({Key? key}) : super(key: key);

  @override
  State<OTPPagePassWord> createState() => _OTPPagePassWordState();
}

class _OTPPagePassWordState extends State<OTPPagePassWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        colorIcon: AppColors.silvergrey,
        centerTitle: false,
        customTitle: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Text("Quay lại",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.silvergrey,
                )),
          ),
        ),
        backgroundColor: AppColors.appBg,
      ),
      body: Container(
        color: AppColors.appBg,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Đặt lại mật khẩu",
              style: TextStyle(
                color: AppColors.textBlack,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontFamily: Assets.fonts.montserratBlack,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 222,
                height: 48,
                child: Column(
                  children: [
                    Text(
                      "Vui lòng nhập mã OTP đã được",
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: Assets.fonts.montserratBlack,
                      ),
                    ),
                    Text(
                      "gửi tới email để xác nhận",
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: Assets.fonts.montserratBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textFieldOTP(context),
                  textFieldOTP(context),
                  textFieldOTP(context),
                  textFieldOTP(context),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  primary: AppColors.textLightGrayDisabled,
                  textStyle: const TextStyle(fontSize: 25),
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPassWord()),
                  );
                },
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textFieldOTP(BuildContext context) {
  return SizedBox(
    height: 80,
    width: 50,
    child: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      onChanged: ((value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      }),
      style: Theme.of(context).textTheme.headline6,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  );
}
