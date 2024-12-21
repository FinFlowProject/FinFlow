import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 10),
  sendTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
));

Future<void> signIn({
  required String username,
  required String password,
  required BuildContext context,
}) async {
  const url = 'http://10.0.2.2:8080/auth/signin';
  final data = {
    'username': username,
    'password': password,
  };

  try {
    final response = await dio.post(url, data: data);

    if (response.statusCode == 200 && context.mounted) {
      final token = response.data;
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        if (context.mounted) {
          Navigator.of(context).pushNamed('/');
        }
      } else {
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error: Token not found')));
      }
    } else if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${response.statusMessage}')));
    }
  } on DioException catch (e) {
    String errorMessage;
    if (context.mounted) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Receive timeout';
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Received invalid status code: ${e.response?.statusCode}';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request to API server was cancelled';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Failed to connect to the server';
          break;
        default:
          errorMessage = 'Unexpected error occurred';
          break;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $errorMessage')));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}

Future<void> signUp({
  required String username,
  required String email,
  required String password,
  required BuildContext context,
}) async {
  const url = 'http://10.0.2.2:8080/auth/signup';
  final data = {
    'username': username,
    'email': email,
    'password': password,
  };

  try {
    final response = await dio.post(url, data: data);

    if (response.statusCode == 200 && context.mounted) {
      final message = response.data;
      if (message == 'Success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign up successful! Please sign in.')));
        final tabController = DefaultTabController.of(context);
        tabController.animateTo(0);
      } else {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $message')));
      }
    } else if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${response.statusMessage}')));
    }
  } on DioException catch (e) {
    String errorMessage;
    if (context.mounted) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Receive timeout';
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Received invalid status code: ${e.response?.statusCode}';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request to API server was cancelled';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Failed to connect to the server';
          break;
        default:
          errorMessage = 'Unexpected error occurred';
          break;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $errorMessage')));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}