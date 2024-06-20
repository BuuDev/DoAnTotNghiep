// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _DemoService implements DemoService {
  _DemoService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<DemoModels>> getUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<DemoModels>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => DemoModels.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ResponseUser> login(username, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'username': username,
      r'password': password
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseUser>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseListUser> getListUser({paginate, page, departmentId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'paginate': paginate,
      r'page': page,
      r'department_id': departmentId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseListUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/listUser',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseListUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> addNewEmployee(fullname, username, password,
      birthday, phone, address, cmnd, email, roleId, departmentId,
      [avatar]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'fullname': fullname,
      r'username': username,
      r'password': password,
      r'birthday': birthday,
      r'phone': phone,
      r'address': address,
      r'citizen_identification': cmnd,
      r'email': email,
      r'role_id': roleId,
      r'department_id': departmentId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (avatar != null) {
      _data.files.add(MapEntry(
          'avatar[]',
          MultipartFile.fromFileSync(avatar.path,
              filename: avatar.path.split(Platform.pathSeparator).last)));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> updateEmployee(id, fullname, username,
      birthday, phone, address, cmnd, email, roleId, departmentId,
      [avatar]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'fullname': fullname,
      r'username': username,
      r'birthday': birthday,
      r'phone': phone,
      r'address': address,
      r'citizen_identification': cmnd,
      r'email': email,
      r'role_id': roleId,
      r'department_id': departmentId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (avatar != null) {
      _data.files.add(MapEntry(
          'avatar[]',
          MultipartFile.fromFileSync(avatar.path,
              filename: avatar.path.split(Platform.pathSeparator).last)));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckInResponse> kiemTraCheckIn() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckInResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/checkIn',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckInResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> checkIn() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/authCheckin',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<CheckInResponse> kiemTraCheckout() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckInResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/checkoutAt',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckInResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> checkOut() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/checkOut',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<ResponseChangePassword> changePassword(
      oldPassword, newPassword, confirmPassword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'old_password': oldPassword,
      r'new_password': newPassword,
      r'confirm_password': confirmPassword
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/account/change-Password',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseUser> reFreshToken() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/token/refresh',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> updateInfoUser(fullname, username, birthday,
      phone, address, cmnd, email, roleId, departmentId,
      [avatar]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'fullname': fullname,
      r'username': username,
      r'birthday': birthday,
      r'phone': phone,
      r'address': address,
      r'citizen_identification': cmnd,
      r'email': email,
      r'role_id': roleId,
      r'department_id': departmentId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (avatar != null) {
      _data.files.add(MapEntry(
          'avatar[]',
          MultipartFile.fromFileSync(avatar.path,
              filename: avatar.path.split(Platform.pathSeparator).last)));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/changeUser',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseSearchUser> searchUser({paginate, page, fullname}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'paginate': paginate,
      r'page': page,
      r'fullname': fullname
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseSearchUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/searchUser',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseSearchUser.fromJson(_result.data!);
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
