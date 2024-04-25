import 'package:bloc/bloc.dart';
import 'package:aiseek/business_logic/cubits/next_page_state.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
//import 'package:equatable/equatable.dart';

class NextPageCubit extends Cubit<NextPageState> {
//  String newStateX = AppConstants.homeRouteName;
  NextPageCubit() : super(NextPageState(nextPageState: AppConstants.promptPageRouteName));
  void nextPage(newState) {
    Globals.printDebug(inText: "Current State is ${state.nextPageState}");
    emit(NextPageState(nextPageState: newState));
    Globals.newState = newState;
    Globals.printDebug(inText: "Next State should be ${Globals.newState}");
  }
}
