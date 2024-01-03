part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class PagedChanged extends LayoutState {}

class DrawerOpened extends LayoutState {}

class GetNotificationsLoading extends LayoutState {}

class GetNotificationsSuccess extends LayoutState {}

class GetNotificationsFailure extends LayoutState {}
