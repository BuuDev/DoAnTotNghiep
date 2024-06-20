part of 'admin_home_new_ui.dart';

class AdminHomeNewUILogic extends ChangeNotifier {
  AdminHomeNewUILogic();
  List menu = [
    // {
    //   'id': 1,
    //   'title': 'Quản lý nhân viên',
    //   'backgroundColor': const Color(0xff009866).withOpacity(0.3),
    //   'icon': Icons.people,
    //   'onTap': (BuildContext context) {
    //     Navigator.pushNamed(context, Routes().employeeManagement);
    //   }
    // },
    {
      'id': 1,
      'title': 'Quản lý phòng ban',
      'backgroundColor': const Color(0xff009866).withOpacity(0.3),
      'icon': Icons.business_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().departmentManagement);
      }
    },
    {
      'id': 2,
      'title': 'Quản lý lương',
      'backgroundColor': AppColors.primary.withOpacity(0.3),
      'icon': Icons.currency_exchange_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().salaryManagement);
      }
    },
    {
      'id': 3,
      'title': 'Quản lý chức vụ',
      'backgroundColor': Colors.pink.withOpacity(0.3),
      'icon': Icons.admin_panel_settings_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().roleManagement);
      }
    },
    {
      'id': 4,
      'title': 'Quản lý hợp đồng',
      'backgroundColor': Colors.purple.withOpacity(0.3),
      'icon': Icons.wysiwyg_rounded,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().contractManagement);
      }
    },
    {
      'id': 5,
      'title': 'Quản lý đơn nghỉ phép',
      'backgroundColor': Colors.yellow.withOpacity(0.3),
      'icon': Icons.contact_mail_outlined,
      'onTap': (BuildContext context) {
        Navigator.pushNamed(context, Routes().applicationLeave);
      }
    },
  ];
}
