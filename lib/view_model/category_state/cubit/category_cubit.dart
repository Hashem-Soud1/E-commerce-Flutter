import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  final _homeService = HomeServicesImpl();

  void fetchCategories() async {
    emit(CategoryLoading());

    final categories = await _homeService.fetchCategories();

    emit(CategoryLoaded(categories: categories));
  }
}
