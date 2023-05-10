import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gitstats/utils/constants.dart';
import 'package:gitstats/utils/snack_bar.dart';

class DioHandler{
  final Dio _dio=Dio();

  DioHandler(){
    _dio.options.baseUrl=Constants.baseUrl;
  }


  Future<Either<String,T>> invokeApi<T>({
    required String path,
    required T Function(List<dynamic>)factory
  }) async{

    debugPrint("calling: ${_dio.options.baseUrl}$path");
    try {
       Response response= await _dio.get(path);
       if ((response.statusCode ?? 401) < 400) {
           return Right(factory(response.data));
       } else {
         snackBar(content: "${response.statusCode}: ${response.statusMessage}");
         return Left(response.statusMessage??'-');
       }
    } on DioError catch(e){
      snackBar(content: e.message);
      print(e.message);
      return Left(e.message??e.toString());
    } catch(e){
      snackBar(content: e.toString());
      return Left(e.toString());
    }
  }



}