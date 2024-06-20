// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _TaskService implements TaskService {
  _TaskService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseAssign> createTask(
      id_level, title, content, timeStart, ending) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id_level': id_level,
      r'title': title,
      r'content': content,
      r'timeStart': timeStart,
      r'ending': ending
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/task/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> editTask(
      id_task, title, content, timeStart, ending) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'title': title,
      r'content': content,
      r'timeStart': timeStart,
      r'ending': ending
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/task/${id_task}/edit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> deleteTask(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/task/${id}/delete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> assignUserTask(id_task, user_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': user_id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/task/${id_task}/assign',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> createComment(id_task, content) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'content': content};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/task/${id_task}/comment/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> deleteAssignUserTask(id_user_work) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/assign/${id_user_work}/delete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
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
