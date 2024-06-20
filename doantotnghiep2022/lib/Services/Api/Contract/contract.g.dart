// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ContractService implements ContractService {
  _ContractService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ContractData> getAllListContract({userId, status}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'user_id': userId,
      r'status': status
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ContractData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/listContact',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ContractData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ContractData> getListContractIsAboutToExpire() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ContractData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/listContractIsAboutToExpire',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ContractData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> createNewContract(
      fullname,
      username,
      password,
      birthday,
      phone,
      address,
      citizenidentification,
      email,
      content,
      salary,
      roleId,
      departmentId,
      startDate,
      finishDate,
      signingDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'fullname': fullname,
      r'username': username,
      r'password': password,
      r'birthday': birthday,
      r'phone': phone,
      r'address': address,
      r'citizen_identification': citizenidentification,
      r'email': email,
      r'content': content,
      r'salary': salary,
      r'role_id': roleId,
      r'department_id': departmentId,
      r'start_date': startDate,
      r'finish_date': finishDate,
      r'signing_date': signingDate
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/Contact/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> updateContract(
      id, userId, content, salary, startDate, finishDate, signingDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'user_id': userId,
      r'content': content,
      r'salary': salary,
      r'start_date': startDate,
      r'finish_date': finishDate,
      r'signing_date': signingDate
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/Contact/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> giaHanContract(
      userId, content, salary, startDate, finishDate, signingDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'user_id': userId,
      r'content': content,
      r'salary': salary,
      r'start_date': startDate,
      r'finish_date': finishDate,
      r'signing_date': signingDate
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/Contact/extend',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
