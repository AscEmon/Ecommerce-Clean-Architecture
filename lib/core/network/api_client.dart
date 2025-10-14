
import 'dart:io';
import 'package:dio/dio.dart';
import '/core/utils/extension.dart';
import '../../../../core/constants/app_constants.dart';
import '../utils/preferences_helper.dart';
import '/core/error/exceptions.dart';
import '/core/network/network_info.dart';
import '../../../../core/constants/api_urls.dart';

/// HTTP methods enum
enum HttpMethod { get, post, put, delete, patch, download }

/// Core API client for making HTTP requests
class ApiClient {
  final Dio _dio;
  final NetworkInfo _networkInfo;
  final PrefHelper _prefHelper;

  ApiClient({
    required Dio dio,
    required NetworkInfo networkInfo,
    required PrefHelper prefHelper,
  }) : _dio = dio,
       _networkInfo = networkInfo,
       _prefHelper = prefHelper {
    _initDio();
  }

  /// Initialize Dio with default options
  void _initDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiUrl.base.url,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    _initInterceptors();
  }

  /// Initialize interceptors for logging and auth
  void _initInterceptors() {
    _dio.interceptors.addAll([
      _createAuthInterceptor(),
      _createLoggingInterceptor(),
    ]);
  }

  /// Create auth interceptor
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add common headers
        options.headers.addAll(_getHeaders());
        return handler.next(options);
      },
      onError: (error, handler) {
        // Handle token expiration (401 errors)
        if (error.response?.statusCode == 401) {
          // Clear token
          _prefHelper.setString(AppConstants.token.key, '');
        }
        return handler.next(error);
      },
    );
  }

  /// Create logging interceptor
  Interceptor _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        'REQUEST[${options.method}] => PATH: ${ApiUrl.base.url}${options.path} '
                '=> Request Values: param: ${options.queryParameters}, => Time : ${DateTime.now()}, DATA: ${options.data}, => _HEADERS: ${options.headers} '
            .log();
        return handler.next(options);
      },
      onResponse: (response, handler) {
        'RESPONSE[${response.statusCode}] => Time : ${DateTime.now()} => DATA: ${response.data} URL: ${response.requestOptions.baseUrl}${response.requestOptions.path} '
            .log();
        return handler.next(response);
      },
      onError: (error, handler) {
        'ERROR[${error.response?.statusCode}] => DATA: ${error.response?.data} Message: ${error.message} URL: ${error.response?.requestOptions.baseUrl}${error.response?.requestOptions.path}'
            .log();
        return handler.next(error);
      },
    );
  }

  /// Get headers including auth token
  Map<String, String> _getHeaders() {
    Map<String, String> headers = {
      'Content-Type': AppConstants.contentType.key,
      'Accept': AppConstants.accept.key,
      'app-version': _prefHelper.getString(AppConstants.appVersion.key),
      'build-number': _prefHelper.getString(AppConstants.buildNumber.key),
      'language':
          _prefHelper.getLanguage() == 1
              ? AppConstants.en.key
              : AppConstants.bn.key,
    };

    // Add bearer token if available
    String token = _prefHelper.getString(AppConstants.token.key);
    if (token.isNotEmpty) {
      headers['Authorization'] = '${AppConstants.bearer.key} $token';
    }

    return headers;
  }

  /// Unified request method for all HTTP methods
  Future<T> request<T>({
    required String endpoint,
    required HttpMethod method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
    List<File>? files,
    String? fileKeyName,
    String? savePath,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    ResponseConverter<T>? converter,
  }) async {
    // Check internet connectivity
    final isConnected = await _networkInfo.internetAvailable();
    if (!isConnected) {
      // Queue the request for later execution
      if (_networkInfo is NetworkInfoImpl) {
        (_networkInfo).apiStack.add(
          ApiRequest(
            url: endpoint,
            method: method,
            variables:
                data is Map<String, dynamic> ? data : <String, dynamic>{},
            onSuccessFunction: (response) {
              return converter != null ? converter(response) : response as T;
            },
            execute: () async {
              // Create a function that will retry this exact request
              try {
                return await request<T>(
                  endpoint: endpoint,
                  method: method,
                  data: data,
                  queryParameters: queryParameters,
                  extraHeaders: extraHeaders,
                  files: files,
                  fileKeyName: fileKeyName,
                  savePath: savePath,
                  onSendProgress: onSendProgress,
                  onReceiveProgress: onReceiveProgress,
                  converter: converter,
                );
              } catch (e) {
                'Error retrying request: $e'.log();
                return null;
              }
            },
          ),
        );
      }
      throw NetworkException(message: 'No internet connection');
    }

    // Update headers if needed
    if (extraHeaders != null) {
      _dio.options.headers.addAll(extraHeaders);
    }

    // Handle file uploads
    FormData? formData;
    if (files != null && files.isNotEmpty && fileKeyName != null) {
      formData = FormData();

      // Add regular params to form data
      if (data is Map<String, dynamic>) {
        data.forEach((key, value) {
          formData?.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add files to form data
      for (var file in files) {
        formData.files.add(
          MapEntry(
            fileKeyName,
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }
    }

    try {
      Response response;

      // Execute request based on method
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(
            endpoint,
            queryParameters: queryParameters,
            options: Options(headers: extraHeaders),
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.post:
          response = await _dio.post(
            endpoint,
            data: formData ?? data,
            queryParameters: queryParameters,
            options: Options(headers: extraHeaders),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.put:
          response = await _dio.put(
            endpoint,
            data: formData ?? data,
            queryParameters: queryParameters,
            options: Options(headers: extraHeaders),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.delete:
          response = await _dio.delete(
            endpoint,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: extraHeaders),
          );
          break;
        case HttpMethod.patch:
          response = await _dio.patch(
            endpoint,
            data: formData ?? data,
            queryParameters: queryParameters,
            options: Options(headers: extraHeaders),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case HttpMethod.download:
          if (savePath == null) {
            throw ArgumentError('savePath is required for download method');
          }
          response = await _dio.download(
            endpoint,
            savePath,
            queryParameters: queryParameters,
            options: Options(headers: extraHeaders),
            onReceiveProgress: onReceiveProgress,
          );
          break;
      }

      // Process response
      final result = _handleResponse(response);

      // Convert response if needed
      if (converter != null) {
        return converter(result);
      }

      return result as T;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Something went wrong: $e');
    }
  }

  /// Handle response based on status code
  dynamic _handleResponse(Response response) {
    'RESPONSE: ${response.data}'.log();
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(message: 'Bad request');
      case 401:
      case 403:
        throw UnauthorizedException(message: 'Unauthorized');
      case 404:
        throw NotFoundException(message: 'Not found');
      case 500:
      default:
        throw ServerException(message: 'Server error: ${response.statusCode}');
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        // Extract error message from response data if available
        String errorMessage = 'Server error occurred';
        if (e.response?.data != null) {
          if (e.response?.data is Map) {
            errorMessage = e.response?.data['message'] ?? errorMessage;
          } else if (e.response?.data is String) {
            errorMessage = e.response?.data;
          }
        }
        'RESPONSE ERROR: $errorMessage $statusCode'.log();
        // Handle specific status codes
        if (statusCode == 401) {
          _prefHelper.setString(AppConstants.token.key, '');
          return UnauthorizedException(message: errorMessage, statusCode: 401);
        } else if (statusCode == 404) {
          return NotFoundException(message: errorMessage, statusCode: 404);
        } else if (statusCode == 400) {
          return BadRequestException(message: errorMessage, statusCode: 400);
        } else if (statusCode == 500) {
          return ServerException(message: errorMessage, statusCode: 500);
        } else {
          return ServerException(message: errorMessage, statusCode: statusCode);
        }
      case DioExceptionType.cancel:
        return RequestCancelledException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return NetworkException(message: 'Connection error');
      default:
        return ServerException(message: e.message ?? 'Unknown error occurred');
    }
  }
}

/// Type definition for response converters
typedef ResponseConverter<T> = T Function(dynamic data);

