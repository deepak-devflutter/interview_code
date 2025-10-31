import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_code/presentation/view/product_details_screen.dart';
import 'package:interview_code/presentation/view_model/fetch_product_cubit/fetch_products_cubit.dart';

import '../../core/sl_dependency_injection.dart';
import '../../domain/repo/product_repo.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // List<dynamic> products = [];
  String searchText = '';
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(


      create: (context) =>
      FetchProductsCubit(sl<ProductRepo>())
        ..fetchProducts(),



      child: BlocBuilder<FetchProductsCubit, FetchProductsState>(
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
                title: Text('Products'), backgroundColor: Colors.blue),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: (state is FetchProductsLoading)
                      ? Center(child: CircularProgressIndicator())
                      :(state is FetchProductsSuccess)? ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      // Filter products based on search
                      // if (searchText.isNotEmpty &&
                      //     (!product.title??'').toLowerCase().contains(
                      //       searchText.toLowerCase(),
                      //     )) {
                      //   return Container();
                      // }

                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  product.image??'',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title??'',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                        Text(
                                          ' ${product.rating?.rate??''} (${product.rating?.count??''})',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ):ElevatedButton(onPressed: (){
                    context.read<FetchProductsCubit>().fetchProducts();
                  }, child: Text('Retry')),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<FetchProductsCubit>().fetchProducts();
              },
              child: Icon(Icons.refresh),
            ),
          );
        },
      ),
    );
  }
}