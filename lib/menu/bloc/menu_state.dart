part of 'menu_bloc.dart';

@immutable
abstract class MenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuLoading extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuSuccess extends MenuState {
  final List<Menu> notes;

  final bool hasReachedMax;

  MenuSuccess({
    this.notes,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [notes, hasReachedMax];
}

// class MenuFailure extends MenuState {}
