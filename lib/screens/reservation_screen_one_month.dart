import 'package:flutter/material.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/ReservationTable.dart';

class ReservationOneMonth extends StatefulWidget {
  @override
  _ReservationOneMonth createState() => _ReservationOneMonth();
}

class _ReservationOneMonth extends State<ReservationOneMonth> {
  List<ReservationTable> reservationList;
  bool DataLoad=false;

  @override
  void initState() {


    _getEmployees();

    super.initState();
  }

  _getEmployees() {
    Services.getReservationOneMonthData().then((reservation) {
      setState(() {
        reservationList = reservation;
        print("reservation: ${reservation}");
        if(reservationList.length=='null'){
          DataLoad=false;
          print("nullnullnullnull");
          }else{
          DataLoad=true;
          print("value...................");
         }
      });

      print("Length ${reservationList.length}");
    });
  }

  // Let's create a DataTable and show the employee list in it.
  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('Number Of table'),
            ),
            DataColumn(
              label: Text('Start Time'),
            ),
            DataColumn(
              label: Text('End Time'),
            ),
            DataColumn(
              label: Text('Start Date'),
            ),
            DataColumn(
              label: Text('End Date'),
            ),
          ],
          rows: reservationList
              .map(
                (resvation) => DataRow(cells: [
              DataCell(
                Text(resvation.id.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),
              DataCell(
                Text(resvation.numberOfTable.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),

              DataCell(
                Text(resvation.startTime.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),
              DataCell(
                Text(resvation.endTime.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),

              DataCell(
                Text(resvation.startDate.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),
              DataCell(
                Text(resvation.startDate.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),


            ]),
          )
              .toList(),
        ),
      ),
    );
  }



  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "One Month Reservation",
        ),
      ),*/
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: DataLoad==false ? Center(child: Text("There are No Reservation")) : _dataBody(),


            ),
          ],
        ),
      ),
    );
  }
}
