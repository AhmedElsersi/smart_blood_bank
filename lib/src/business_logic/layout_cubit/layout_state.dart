part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class PagedChanged extends LayoutState {}

class DrawerOpened extends LayoutState {}

class ChangeActiveDot extends LayoutState {}

class ChangeCategory extends LayoutState {}

class GetAdsLoading extends LayoutState {}

class GetAdsSuccess extends LayoutState {}

class GetAdsFailure extends LayoutState {}

class GetServicesLoading extends LayoutState {}

class GetServicesSuccess extends LayoutState {}

class GetServicesFailure extends LayoutState {}

class GetFeaturedSuppliersLoading extends LayoutState {}

class GetFeaturedSuppliersSuccess extends LayoutState {}

class GetFeaturedSuppliersFailure extends LayoutState {}

class GetServiceLoading extends LayoutState {}

class GetServiceSuccess extends LayoutState {}

class GetServiceFailure extends LayoutState {}

class GetSearchPlacesLoading extends LayoutState {}

class GetSearchPlacesSuccess extends LayoutState {}

class GetSearchPlacesFailure extends LayoutState {}
