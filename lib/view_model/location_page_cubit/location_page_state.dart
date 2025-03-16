part of 'location_page_cubit.dart';

sealed class ChooseLocationState {}

final class ChooseLocationInitial extends ChooseLocationState {}

final class FetchingLocations extends ChooseLocationState {}

final class FetchedLocations extends ChooseLocationState {
  final List<LocationItemModel> locations;

  FetchedLocations(this.locations);
}

final class FetchLocationsFailure extends ChooseLocationState {
  final String errorMessage;

  FetchLocationsFailure(this.errorMessage);
}

final class AddingLocation extends ChooseLocationState {}

final class LocationAdded extends ChooseLocationState {}

final class LocationAddingFailure extends ChooseLocationState {
  final String errorMessage;

  LocationAddingFailure(this.errorMessage);
}

final class LocalSelectedLocation extends ChooseLocationState {
  final LocationItemModel location;

  LocalSelectedLocation(this.location);
}

final class ShippingMethodLoading extends ChooseLocationState {}

final class ShippingMethodLoaded extends ChooseLocationState {
  final List<LocationItemModel> locations;

  ShippingMethodLoaded({required this.locations});
}

final class ShippingMethodError extends ChooseLocationState {
  final String message;

  ShippingMethodError({required this.message});
}
