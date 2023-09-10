part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddDeleteUpdatePostState extends AddUpdateDeletePostState {

}

class ErrorAddDeleteUpdatePostState extends AddUpdateDeletePostState {
  final String message;

  const ErrorAddDeleteUpdatePostState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessAddDeleteUpdatePostState extends AddUpdateDeletePostState {
  final String message;
  const SuccessAddDeleteUpdatePostState(this.message);

  @override
  List<Object> get props => [message];
}
