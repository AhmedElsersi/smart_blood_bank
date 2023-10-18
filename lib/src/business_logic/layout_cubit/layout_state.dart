part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class PagedChanged extends LayoutState {}

class DrawerOpened extends LayoutState {}
