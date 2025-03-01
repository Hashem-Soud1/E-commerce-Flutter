import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void fetchCategories() {
    emit(CategoryLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(CategoryLoaded(categories: dummyCategories));
    });
  }
}
