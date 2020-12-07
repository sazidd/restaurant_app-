import 'package:flutter/material.dart';
import 'package:flutterapptestpush/menu/bloc/menu_bloc.dart';
import 'package:flutterapptestpush/util/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapptestpush/widgets/smooth_star_rating.dart';
import '../screens/details_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreen createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> {
  ScrollController _scrollController = ScrollController();
  int id = 1;
  MenuBloc _menuBloc;
  // final _scrollThreshold = 200.0;

  MenuSuccess menuSuccess;

  // void _onScroll() {
  //   final maxScrollPosts = _scrollController.position.maxScrollExtent;
  //   final currentScrollPosts = _scrollController.position.pixels;

  //   if (maxScrollPosts - currentScrollPosts <= _scrollThreshold) {
  //     _menuBloc.add(FetchNotes(id: id++));
  //   }
  // }

  void _onScroll() {
    // final maxScrollPosts = _scrollController.position.maxScrollExtent;
    // final currentScrollPosts = _scrollController.position.pixels;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //id++;
      _menuBloc.add(FetchNotes(id: id++));
    }
    if (menuSuccess.hasReachedMax == true) {
      _menuBloc.toastShow();
    }
  }

  @override
  void initState() {
    _menuBloc = context.read<MenuBloc>();
    _menuBloc.add(FetchNotes(id: id));
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // toastShow() {
  //   Fluttertoast.showToast(
  //       msg: "There is no more Data Availabel",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state is MenuInitial) {
            _menuBloc.add(FetchNotes(id: id));
          }
        },
        builder: (context, state) {
          if (state is MenuLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // if (state is MenuFailure) {
          //   return Center(
          //     child:,
          //   );
          // }
          if (state is MenuSuccess) {
            if (state.notes.isEmpty) {
              return Center(
                child: Text("No More data"),
              );
            }
            return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.notes.length
                    : state.notes.length + 1,
                itemBuilder: (context, index) {
                  print("_notes.length ${state.notes.length}");
                  print("index ${index}");

                  return index >= state.notes.length
                      ? CupertinoActivityIndicator()
                      : _menuItem(
                          context,
                          state.notes[index].id,
                          state.notes[index].imageSource,
                          state.notes[index].name,
                          state.notes[index].price,
                          state.notes[index].quantity);
                });
          }
          return Container(
            child: Center(
              child: Text("Something went wrong"),
            ),
          );
        },
      ),
    );
  }
}

_menuItem(BuildContext context, String id, String img, String name,
    String price, String quantity) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailsItem(id, img);
            },
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 6.0, right: 6.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "$img",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "blank_image_itesm.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "$name",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 1,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: 5.0,
                    size: 12.0,
                  ),
                  SizedBox(width: 2.0),
                  Text(
                    "5.0 (23 Reviews)",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    " $price",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                "Quantity: $quantity",
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
