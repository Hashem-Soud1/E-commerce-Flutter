import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/home_carouesl_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchHomeData() {
    emit(HomeLoading());

    Future.delayed(Duration(seconds: 1), () {
      emit(
        HomeLoaded(
          carouselItems: dummyHomeCarouselItems,
          products: dummyProducts,
        ),
      );
    });
  }
}
