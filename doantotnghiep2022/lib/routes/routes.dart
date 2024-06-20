import 'package:doantotnghiep/Screens/Account/account.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/ContractManagement/AddNewContract/add_new_contract.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/ContractManagement/Contract/contract.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/ContractManagement/ContractPersonal/AddNewContractPersonal/add_new_contract_personal.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/ContractManagement/ContractPersonal/contract_personal.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/ContractManagement/contract_management.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/DepartmentManagement/department_management.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/DepartmentManagement/employee_in_department.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/EmployeeManagement/AddNewEmployee/add_new_employee.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/EmployeeManagement/SearchEmployee/search_employee.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/EmployeeManagement/employee_management.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/RoleManagement/AddNewRole/add_new_role.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/RoleManagement/role_management.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/SalaryManagement/detail_salary/salary_detail.dart';
import 'package:doantotnghiep/Screens/HomePage/Admin/SalaryManagement/salary_management.dart';
import 'package:doantotnghiep/Screens/HomePage/User/SalaryPersonal/salary_personal.dart';
import 'package:doantotnghiep/Screens/HomePage/User/VietDonNghiPhep/AddNewDonXinNghiPhep/add_new_don_xin_nghi_phep.dart';
import 'package:doantotnghiep/Screens/HomePage/User/VietDonNghiPhep/viet_don_nghi_phep.dart';
import 'package:doantotnghiep/Screens/HomePage/home.dart';
import 'package:doantotnghiep/Screens/Login/login.dart';
import 'package:doantotnghiep/Screens/Setting/ChangePassword/change_password.dart';
import 'package:doantotnghiep/Screens/Setting/setting.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Salary/salary.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Timekeep_detail/timekeep_detail.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Timekeep_detail/timekeep_detail_info/timekeep_detail_checkin/timekeep_checkin.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/Timekeep_detail/timekeep_detail_info/timekeep_detail_info/timekeep_info.dart';
import 'package:doantotnghiep/Screens/TimekeepingTimekeeping/timekeeping.dart';
import 'package:doantotnghiep/Screens/ViewStack/view_stack.dart';
import 'package:doantotnghiep/Screens/application_leave/application_detail/application_detail.dart';
import 'package:doantotnghiep/Screens/application_leave/application_leave.dart';
import 'package:doantotnghiep/Screens/forgot_password/forgot_password.dart';
import 'package:doantotnghiep/auth.dart';
import 'package:flutter/material.dart';

class Routes {
  String get auth => '/';
  String get login => '/login';
  String get forgotPassword => '/forgot_password';
  String get viewStack => '/view_stack';
  String get account => '/account';
  String get setting => '/setting';
  String get home => '/home';
  String get employeeManagement => '/employee_management';
  String get addNewEmployee => '/employee_management/add_new_employee';
  String get searchEmployee => '/employee_management/search_employee';
  String get departmentManagement => '/departmentManagement';
  String get addNewDepartment => '/departmentManagement/add_new_department';
  String get timeKeeping => '/timekeeping';
  String get timeKeepingDetail => '/timekeeping_detail';
  String get timeKeepingDetailInfo =>
      '/timekeeping_detail/timekeeping_detail_info';
  String get timeKeepingDetailCheckIn =>
      '/timekeeping_detail/timekeeping_detail_check_in';
  String get roleManagement => '/role_management';
  String get addRoles => '/role_management/add_role';
  String get salaryManagement => '/salary_management';
  String get contract => '/contract';
  String get salary => '/salary';
  String get salaryDetail => '/salary_detail';
  String get applicationLeave => '/applicationLeave';
  String get applicationDetail => '/applicationDetail';
  String get contractManagement => '/contract_management';
  String get addNewContract => '/contract_management/add_new_contract';
  String get contractPersonal => '/contract_personal';
  String get addNewContractPersonal => '/add_new_contrct_personal';
  String get vietXinNghiPhep => '/don_xin_nghi_phep';
  String get addNewDonXinNghiPhep =>
      '/don_xin_nghi_phep/add_new_don_xin_nghi_phep';
  String get changePassword => '/change_password';
  String get employeeInDepartment => '/department/employee_in_department';
  String get salaryPersonal => '/salary_personal';
  //thêm route ở đây

  Map<String, Widget Function(BuildContext)> get configRoute => {
        auth: (context) => const AuthScreen(),
        login: (_) => const LoginScreen(),
        viewStack: (_) => const ViewStack(),
        home: (_) => const HomePage(),
        account: (_) => const AccountScreen(),
        setting: (_) => const SettingScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        employeeManagement: (_) => const EmployeeManagementScreen(),
        addNewEmployee: (_) => const AddNewEmployee(),
        searchEmployee: (_) => const SearchEmployee(),
        departmentManagement: (_) => const DepartmentManagementSceen(),
        timeKeeping: (_) => const TimekeepingSceen(),
        timeKeepingDetail: (_) => const TimeKeepDetail(),
        timeKeepingDetailInfo: (_) => const TimeKeepInfo(),
        timeKeepingDetailCheckIn: (_) => const TimeKeepCheckIn(),
        roleManagement: (_) => const RoleManagement(),
        addRoles: (_) => const AddNewRole(),
        salary: (_) => const Salary(),
        salaryManagement: (_) => const SalaryManagement(),
        contract: (_) => const ContractScreen(),
        applicationLeave: (_) => const ApplicationLeave(),
        applicationDetail: (_) => const ApplicationDetail(),
        contractManagement: (_) => const ContractManagement(),
        addNewContract: (_) => const AddNewContract(),
        contractPersonal: (_) => const ContractPersonal(),
        vietXinNghiPhep: (_) => const VietDonNghiPhep(),
        salaryDetail: (_) => const DetailSalary(),
        addNewContractPersonal: (_) => const AddNewContractPersonal(),
        addNewDonXinNghiPhep: (_) => const AddNewDonXinNghiPhep(),
        changePassword: (_) => const ChangePassword(),
        employeeInDepartment: (_) => const EmployeeInDepartment(),
        salaryPersonal: (_) => const SalaryPersonal(),
      };
}
