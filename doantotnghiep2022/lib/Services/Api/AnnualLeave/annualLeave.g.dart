// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annualLeave.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _Leave implements Leave {
  _Leave(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AnnualLeave> getAnnualLeave() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AnnualLeave>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/waitingListForApproval',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AnnualLeave.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AnnualLeave> getListDisApprove() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AnnualLeave>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/AnnualLeave/listDisApprove',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AnnualLeave.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AnnualLeave> getApproved({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': id};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AnnualLeave>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/listAnnualLeave',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AnnualLeave.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Approve> approved(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Approve>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/AnnualLeave/approve',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Approve.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Approve> disapproved(id, reason_not_approving) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'reason_not_approving': reason_not_approving
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Approve>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/AnnualLeave/disApprove',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Approve.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> createAnnualLeave(
      startDay, finishDate, userId, reason) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDay,
      r'finish_date': finishDate,
      r'user_id': userId,
      r'reason': reason
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/AnnualLeave/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> updateAnnualLeave(
      id, startDay, finishDate, userId, reason) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'start_date': startDay,
      r'finish_date': finishDate,
      r'user_id': userId,
      r'reason': reason
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/AnnualLeave/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseChangePassword.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AnnualLeave> getAnnualListUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AnnualLeave>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/listAnnualLeaveInUser',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AnnualLeave.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseChangePassword> deleteDonNghiPhep(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseChangePassword>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/AnnualLeave/delete',
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
