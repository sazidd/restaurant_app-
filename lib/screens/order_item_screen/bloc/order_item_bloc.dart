import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapptestpush/sqlite/order.dart';

part 'order_item_event.dart';
part 'order_item_state.dart';

class OrderItemBloc extends Bloc<OrderItemEvent, OrderItemState>
    with ChangeNotifier {
  OrderItemBloc() : super(OrderItemInitial());

  @override
  Stream<OrderItemState> mapEventToState(
    OrderItemEvent event,
  ) async* {
    if (event is OrderIncrement) {
      yield OrderItemSuccess(
        quantity: int.parse(event.order.menuQuantity) + 1,
        price: int.parse(event.order.menuPrice) + 1,
      );
    }

    if (event is OrderDecrement) {
      yield OrderItemSuccess(
        quantity: int.parse(event.order.menuQuantity) - 1,
        price: int.parse(event.order.menuPrice) - 1,
      );
    }
  }
}

// Stream<TodosState> _mapTodosLoadedToState() async* {
//   try {
//     final todos = await this.todosRepository.loadTodos();
//     yield TodosLoadSuccess(
//       todos.map(Todo.fromEntity).toList(),
//     );
//   } catch (_) {
//     yield TodosLoadFailure();
//   }
// }
