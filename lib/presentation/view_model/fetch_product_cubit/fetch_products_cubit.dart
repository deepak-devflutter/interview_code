import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interview_code/data/models/failure.dart';
import 'package:interview_code/domain/repo/product_repo.dart';

import '../../../data/models/product_response_model.dart';

part 'fetch_products_state.dart';

class FetchProductsCubit extends Cubit<FetchProductsState> {
  final ProductRepo repo;

  FetchProductsCubit(this.repo) : super(FetchProductsInitial());

  void fetchProducts() {
    emit(FetchProductsLoading());

    try {
      repo.getProducts().then((value) {
        value.fold(
          (l) => emit(FetchProductsFailure(l)),
          (r) => emit(FetchProductsSuccess(r)),
        );
      });
    } on Exception catch (e) {
      emit(FetchProductsFailure(Failure('Something went wring')));
    }
  }
}
