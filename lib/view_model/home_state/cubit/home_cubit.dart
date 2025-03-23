import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/home_carouesl_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _homeService = HomeServicesImpl();

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      final products = await _homeService.fetchProducts();
      final carouselItems = await _homeService.fetchCarouselItems();

      emit(HomeLoaded(carouselItems: carouselItems, products: products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
