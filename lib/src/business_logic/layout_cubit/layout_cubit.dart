import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/home_page.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/more_page.dart';

import '../../constants/const_methods.dart';
import '../../constants/end_points.dart';
import '../../services/dio_helper.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int pageIndex = 1;

  void changePageIndex(int index) {
    pageIndex = index;
    emit(PagedChanged());
  }

  List<Widget> layoutPages = [
    const MorePage(),
    const HomePage(),
  ];
  List<dynamic> notifications = [];

  Future getNotifications() async {
    notifications.clear();
    try {
      emit(GetNotificationsLoading());
      await DioHelper.getData(
        url: EndPoints.epGetNotifications,
      ).then((value) {
        logSuccess('getNotifications Response : ${value.data}');
        // final response = PlacesModel.fromJson(value.data);
        // notifications = response.data ?? [];
        emit(GetNotificationsSuccess());
      });
    } catch (e) {
      emit(GetNotificationsFailure());
    }
  }
}
