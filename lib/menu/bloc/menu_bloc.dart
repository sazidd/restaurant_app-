import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../menu.dart';
import '../repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> with ChangeNotifier {
  final Repository repository;

  MenuBloc({this.repository}) : super(MenuInitial());

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchNotes && !_hasReachedMax(state)) {
      if (currentState is MenuInitial) {
        yield MenuLoading();
        final notes = await repository.fetchNotes(event.id);
        if (notes != null) {
          yield MenuSuccess(
            notes: notes,
            hasReachedMax: false,
          );
        } else {
          yield MenuFailure(errorMessage: 'No more data');
        }
      }
      if (currentState is MenuSuccess) {
        final notes = await repository.fetchNotes(event.id + 1);
        if (notes != null) {
          yield MenuSuccess(
            notes: currentState.notes + notes,
            hasReachedMax: false,
          );
        } else {
          yield MenuSuccess(
            notes: currentState.notes,
            hasReachedMax: true,
          );
        }
      }
    }
  }
}

bool _hasReachedMax(MenuState state) =>
    state is MenuSuccess && state.hasReachedMax;
