import 'package:ecommerce_app/services/firebase_auth_service.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/location_item_model.dart';

part 'location_page_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String? selectedLocationId;
  LocationItemModel? selectedLocation;

  final locationServices = LocationServicesImpl();
  final authServices = AuthServicesImpl();

  void fetchLocations() async {
    emit(FetchingLocations());
    try {
      final currentUser = authServices.getCurrentUser();
      final locations = await locationServices.fetchLocations(currentUser!.uid);

      for (var location in locations) {
        if (location.isChoosen) {
          selectedLocationId = location.id;
          selectedLocation = location;
        }
      }
      selectedLocationId ??= locations.first.id;
      selectedLocation ??= locations.first;
      emit(FetchedLocations(locations));
      emit(LocalSelectedLocation(selectedLocation!));
    } catch (e) {
      emit(FetchLocationsFailure(e.toString()));
    }
  }

  void addLocation(String location) async {
    emit(AddingLocation());
    try {
      final splittedLocations = location.split('-');
      final locationItem = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: splittedLocations[0],
        country: splittedLocations[1],
      );
      final currentUser = authServices.getCurrentUser();
      await locationServices.setLocation(locationItem, currentUser!.uid);
      emit(LocationAdded());
      final locations = await locationServices.fetchLocations(currentUser.uid);
      emit(FetchedLocations(locations));
    } catch (e) {
      emit(LocationAddingFailure(e.toString()));
    }
  }

  Future<void> selectLocation(String id) async {
    selectedLocationId = id;

    final currentUser = authServices.getCurrentUser();
    final chosenLocation = await locationServices.fetchLocation(
      currentUser!.uid,
      id,
    );
    selectedLocation = chosenLocation;
    emit(LocalSelectedLocation(chosenLocation));
  }

  Future<void> confirmAddress() async {
    try {
      final currentUser = authServices.getCurrentUser();
      var previousChosenLocations = await locationServices.fetchLocations(
        currentUser!.uid,
        true,
      );
      if (previousChosenLocations.isNotEmpty) {
        var previousLocation = previousChosenLocations.first;
        previousLocation = previousLocation.copyWith(isChoosen: false);
        await locationServices.setLocation(previousLocation, currentUser.uid);
        await locationServices.setLocation(previousLocation, currentUser.uid);
      }
      selectedLocation = selectedLocation!.copyWith(isChoosen: true);
      await locationServices.setLocation(selectedLocation!, currentUser.uid);
      emit(ShippingMethodLoaded());
    } catch (e) {
      emit(ShippingMethodError(e.toString()));
    }
  }
}
