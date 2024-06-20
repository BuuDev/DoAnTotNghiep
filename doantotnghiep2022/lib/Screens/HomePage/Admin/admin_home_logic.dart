part of 'admin_home.dart';

class AdminHomeLogic extends ChangeNotifier {
  late AnimationController animationController;
  late Animation<Color?> baseColor;
  late Animation<Color?> hightlightColor;
  bool hide = true;
  double opacity = 0.5;
  int lst = 10;
  int df = 10;
  int step = 1;
  int total = 50;
  late bool isLoadMore = false;
  List<UserDemo> lstUser = [];
  AdminHomeLogic() {
    // getListUser();
    getListContractIsAboutToExpire();
  }

  DemoService service = DemoService.client();
  ContractService service2 = ContractService.client(isLoading: false);
  Leave leaveService = Leave.client(isLoading: false);
  List<Contract> lstContractIsAboutToExpire = [];
  List<AnnualLeaveData> lstAnnualWait = [];
  bool load = false;

  void getWaitListAnnualLeave() async {
    await leaveService.getAnnualLeave().then((value) {
      lstAnnualWait = value.annual_leave;
      lstAnnualWait = lstAnnualWait.reversed.toList();
      load = true;
      notifyListeners();
    });
  }

  void getListUser() async {
    await service.getListUser().then((value) {
      step = 1;
      lstUser = value.user.data!;
      lst = lstUser.length;
      total = value.user.total;
      isLoadMore = false;
      notifyListeners();
    });
  }

  void loadMore() async {
    try {
      if (lst < total) {
        ++step;
        await service.getListUser(page: step).then((value) {
          lstUser = [...lstUser, ...value.user.data!];
          lst = lstUser.length;
          notifyListeners();
        });
        if (lst > total) {
          lst = total;
        }
        notifyListeners();
      } else {
        isLoadMore = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  List menu = [
    {
      'id': 1,
      'title': 'Quản lý nhân viên',
      'backgroundColor': const Color(0xff009866).withOpacity(0.3),
      'icon': Icons.people,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().employeeManagement);
      }
    },
    {
      'id': 2,
      'title': 'Quản lý phòng ban',
      'backgroundColor': AppColors.primary.withOpacity(0.3),
      'icon': Icons.business_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().departmentManagement);
      }
    },
    {
      'id': 3,
      'title': 'Quản lý lương',
      'backgroundColor': AppColors.red.withOpacity(0.3),
      'icon': Icons.currency_exchange_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().salaryManagement);
      }
    },
    // {
    //   'id': 4,
    //   'title': 'Quản lý chức vụ',
    //   'backgroundColor': Colors.pink.withOpacity(0.3),
    //   'icon': Icons.admin_panel_settings_outlined,
    //   'onTap': (BuildContext context) {
    //     Navigator.pushNamed(context, Routes().roleManagement);
    //   }
    // },
    {
      'id': 5,
      'title': 'Quản lý hợp đồng',
      'backgroundColor': Colors.purple.withOpacity(0.3),
      'icon': Icons.wysiwyg_rounded,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().contractManagement);
      }
    },
    {
      'id': 6,
      'title': 'Quản lý đơn nghỉ phép',
      'backgroundColor': Colors.yellow.withOpacity(0.3),
      'icon': Icons.contact_mail_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().applicationLeave);
      }
    },
  ];

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
    hide = false;
    await Future.delayed(const Duration(milliseconds: 100), () {});
    opacity = 1;
    notifyListeners();
  }

  void getListContractIsAboutToExpire() async {
    await service2.getListContractIsAboutToExpire().then((value) {
      lstContractIsAboutToExpire = value.contract;
      lstContractIsAboutToExpire = lstContractIsAboutToExpire.reversed.toList();
      getWaitListAnnualLeave();
      notifyListeners();
    });
  }
}
