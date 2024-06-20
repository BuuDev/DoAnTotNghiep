part of 'user_home.dart';

class UserHomeLogic extends ChangeNotifier {
  late AnimationController animationController;
  late Animation<Color?> baseColor;
  late Animation<Color?> hightlightColor;
  bool lst = true;
  double opacity = 0.3;
  bool oncheckIn = false;
  bool oncheckOut = false;
  UserHomeLogic();
  DemoService service = DemoService.client();

  void initAnimation(TickerProvider val) {
    animationController = AnimationController(
        vsync: val,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 1));
    baseColor = ColorTween(begin: AppColors.primary, end: Colors.white)
        .animate(animationController);
    hightlightColor = ColorTween(begin: Colors.white, end: AppColors.primary)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse();
      }
      if (animationController.status == AnimationStatus.dismissed) {
        animationController.forward();
      }
      notifyListeners();
    });
  }

  void activeAnimation() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    lst = false;
    await Future.delayed(const Duration(milliseconds: 100), () {});
    opacity = 1;
    notifyListeners();
  }

  void checkIn(context) async {
    await service.kiemTraCheckIn().then((value) async {
      oncheckIn = value.status;
      notifyListeners();
      if (value.status) {
        await service.kiemTraCheckout().then((value) {
          oncheckOut = value.status;
        });
      }
    });
    if (!oncheckIn) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                backgroundColor: AppColors.transparent,
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Thông báo',
                            style: TextStyle(
                              color: AppColors.acne3,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Monsserat",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.acne3,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 1,
                        color: AppColors.black.withOpacity(0.5),
                      ),
                      const Text(
                        'Vui lòng check in cho ngày làm việc hôm nay!',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          await service.checkIn();
                          oncheckIn = true;
                          notifyListeners();
                          if (oncheckIn) {
                            NotifyHelper.showSnackBar('Check in thành công!');
                          } else {
                            NotifyHelper.showSnackBar('Check out thành công!');
                          }
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: AppColors.textBlue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              'Check in',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Monsserat",
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  void checkOut(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: AppColors.transparent,
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              title: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thông báo',
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monsserat",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppColors.red,
                            size: 14,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    const Text(
                      'Vui lòng check out để kết thúc ngày làm việc hôm nay!',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        await service.checkOut();
                        oncheckOut = true;
                        notifyListeners();
                        NotifyHelper.showSnackBar('Check out thành công!');
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Check out',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Monsserat",
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
