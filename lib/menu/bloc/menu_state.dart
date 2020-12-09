part of 'menu_bloc.dart';

@immutable
abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuSuccess extends MenuState {
  final List<Menu> notes;

  final bool hasReachedMax;

  const MenuSuccess({
    this.notes = const <Menu>[],
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [notes, hasReachedMax];
}

class MenuFailure extends MenuState {
  final String errorMessage;
  const MenuFailure({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
