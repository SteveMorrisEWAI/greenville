import 'package:aiseek/core/commons/app_constants.dart';
import 'package:equatable/equatable.dart';

enum nextPageState { homeRouteName }

//ignore:must_be_immutable
class NextPageState extends Equatable {
  String nextPageState = AppConstants.promptPageRouteName;
  NextPageState({required this.nextPageState});
  @override
  List<Object?> get props => [nextPageState];
}
