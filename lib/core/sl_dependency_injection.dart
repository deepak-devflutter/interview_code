

import 'package:get_it/get_it.dart';
import 'package:interview_code/data/repo_impl/product_repo_impl.dart';
import 'package:interview_code/domain/repo/product_repo.dart';

final GetIt sl = GetIt.instance;


Future<void> initServiceLocator()async {

  sl.registerLazySingleton<ProductRepo>(
        () => ProductRepoImpl(),
  );
}
