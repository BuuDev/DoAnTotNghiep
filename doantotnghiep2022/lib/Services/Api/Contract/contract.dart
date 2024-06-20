import 'package:doantotnghiep/Models/ChangePassword/response_change_password.dart';
import 'package:doantotnghiep/Models/Contract/contract_data.dart';
import 'package:doantotnghiep/Services/Api/api_client.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'contract.g.dart';

@RestApi()
abstract class ContractService {
  factory ContractService(Dio dio, {String baseUrl}) = _ContractService;

  factory ContractService.client({bool? isLoading}) {
    return ContractService(
        ClientApi().initDio()..options.headers['isLoading'] = isLoading);
  }

  @GET("/listContact")
  Future<ContractData> getAllListContract({
    @Query('user_id') int? userId,
    @Query('status') int? status,
  });

  @GET('/listContractIsAboutToExpire')
  Future<ContractData> getListContractIsAboutToExpire();

  @POST('/Contact/create')
  Future<ResponseChangePassword> createNewContract(
    @Query('fullname') String fullname,
    @Query('username') String username,
    @Query('password') String password,
    @Query('birthday') String birthday,
    @Query('phone') String phone,
    @Query('address') String address,
    @Query('citizen_identification') String citizenidentification,
    @Query('email') String email,
    @Query('content') String content,
    @Query('salary') String salary,
    @Query('role_id') String roleId,
    @Query('department_id') String departmentId,
    @Query('start_date') String startDate,
    @Query('finish_date') String finishDate,
    @Query('signing_date') String signingDate,
  );

  @POST('/Contact/update')
  Future<ResponseChangePassword> updateContract(
    @Query('id') int id,
    @Query('user_id') String userId,
    @Query('content') String content,
    @Query('salary') String salary,
    @Query('start_date') String startDate,
    @Query('finish_date') String finishDate,
    @Query('signing_date') String signingDate,
  );

  @POST('/Contact/extend')
  Future<ResponseChangePassword> giaHanContract(
    @Query('user_id') String userId,
    @Query('content') String content,
    @Query('salary') String salary,
    @Query('start_date') String startDate,
    @Query('finish_date') String finishDate,
    @Query('signing_date') String signingDate,
  );
}
