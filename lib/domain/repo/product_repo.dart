
import 'package:dartz/dartz.dart';
import 'package:interview_code/data/models/product_response_model.dart';

import '../../data/models/failure.dart';

abstract class ProductRepo{

Future<Either<Failure,List<ProductResponse>>> getProducts();

}