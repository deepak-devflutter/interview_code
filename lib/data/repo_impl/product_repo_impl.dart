
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:interview_code/domain/repo/product_repo.dart';

import '../models/failure.dart';
import '../models/product_response_model.dart';

class ProductRepoImpl implements ProductRepo{


  @override
  Future<Either<Failure,List<ProductResponse>>> getProducts()async{

    try {
      // Simulating API call - replace with actual endpoint
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {

         return right( productResponseFromJson(response.body));
      }
      else{
        return left(Failure('Something went wrong'));
      }
    } catch (e) {

      print('Error: $e');
      //TODO: record e logs on server or crashlatics;
      return left(Failure('Something went wrong'));
    }

  }


}