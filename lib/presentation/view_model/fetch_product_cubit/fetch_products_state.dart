part of 'fetch_products_cubit.dart';

sealed class FetchProductsState extends Equatable {
  const FetchProductsState();
}

final class FetchProductsInitial extends FetchProductsState {
  @override
  List<Object> get props => [];
}

final class FetchProductsLoading extends FetchProductsState {
  @override
  List<Object> get props => [];
}

final class FetchProductsSuccess extends FetchProductsState {
  final List<ProductResponse> products;
  const FetchProductsSuccess(this.products);
  @override
  List<Object> get props => [];
}

final class FetchProductsFailure extends FetchProductsState {

  final Failure failure;
  const FetchProductsFailure(this.failure);

  @override
  List<Object> get props => [];
}
