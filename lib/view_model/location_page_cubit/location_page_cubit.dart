import 'package:ecommerce_app/view_model/checkout_state/checkout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/location_item_model.dart';

part 'location_page_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String selectedLocation = dummyLocations.first.id;

  void fetchLocations() {
    emit(FetchingLocations());
    Future.delayed(const Duration(seconds: 1), () {
      emit(FetchedLocations(dummyLocations));
    });
  }

  void addLocation(String location) {
    emit(AddingLocation());
    Future.delayed(const Duration(seconds: 1), () {
      final splittedLocations = location.split('-');
      final locationItem = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: splittedLocations[0],
        country: splittedLocations[1],
      );
      dummyLocations.add(locationItem);
      emit(LocationAdded());
      emit(FetchedLocations(dummyLocations));
    });
  }

  void selectLocation(String id) {
    selectedLocation = id;
    var tempChoosenLocation = dummyLocations.firstWhere(
      (element) => element.id == id,
    );

    emit(LocalSelectedLocation(tempChoosenLocation));
  }

  void confirmLocation() {
    emit(ShippingMethodLoading());

    Future.delayed(const Duration(seconds: 1), () {
      var ChoosenLocation = dummyLocations.firstWhere(
        (element) => element.id == selectedLocation,
      );

      var previousLocation = dummyLocations.firstWhere(
        (element) => element.isChoosen == true,
        orElse: () => dummyLocations.first,
      );

      previousLocation = previousLocation.copyWith(isChoosen: false);
      ChoosenLocation = ChoosenLocation.copyWith(isChoosen: true);

      final previousIndex = dummyLocations.indexWhere(
        (element) => element.id == previousLocation.id,
      );

      final choosenIndex = dummyLocations.indexWhere(
        (element) => element.id == ChoosenLocation.id,
      );

      dummyLocations[previousIndex] = previousLocation;
      dummyLocations[choosenIndex] = ChoosenLocation;

      emit(ShippingMethodLoaded(locations: dummyLocations));
    });
  }
}
