import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/home_page.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/noyifications_page.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/profile_page.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int pageIndex = 3;

  void changePageIndex(int index) {
    pageIndex = index;
    emit(PagedChanged());
  }

  List<Widget> layoutPages = [
    const HomePage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  void openDrawer() {
    emit(DrawerOpened());
  }
}
