// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _WorkService implements WorkService {
  _WorkService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WorkResponse> getWorkUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WorkResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WorkResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> createWork(
      name, priority, starting, ending, size, detail) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'name': name,
      r'priority ': priority,
      r'starting ': starting,
      r'ending ': ending,
      r'size ': size,
      r'detail ': detail
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> editWork(
      id, name, priority, starting, ending, size, detail) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'name': name,
      r'priority ': priority,
      r'starting ': starting,
      r'ending ': ending,
      r'size ': size,
      r'detail ': detail
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/edit/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> deleteWork(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/delete/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> assignUserWork(id, user_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': user_id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/${id}/assign',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GarbageModelResponse> garbageWork(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GarbageModelResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/${id}/task/trash',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GarbageModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> deleteAssignUserWork(id_user_work) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/assign/${id_user_work}/delete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LevelResponse> getLevelWork(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LevelResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/${id}/level',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LevelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> createLevel(id_work, name) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'name': name};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/${id_work}/level/create',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> editLevel(id_level, name) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'name': name};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/level/edit/${id_level}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseAssign> deleteLevel(id_level) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseAssign>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/project/level/delete/${id_level}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseAssign.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TaskResponse> getTaskLevel(work_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'work_id': work_id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TaskResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/task/list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TaskResponse.fromJson(_result.data!);
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
