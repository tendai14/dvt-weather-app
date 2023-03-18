part of 'login_bloc_bloc.dart';

abstract class LoginBlocState extends Equatable {
  const LoginBlocState();
  
  @override
  List<Object> get props => [];
}

class LoginBlocInitial extends LoginBlocState {}
