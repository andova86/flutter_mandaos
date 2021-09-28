
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/modules/cart/models/buy.dart';
import 'package:mandaos/modules/cart/models/cart_product.dart';

import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<SalesData> dataSales = [];
  late TooltipBehavior _tooltipBehavior;

  bool showAvg = false;
  String dropdownValue = Mes(DateTime.now().month);
  DateTime date = DateTime.now();
  int selectedValue = DateTime.now().month;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
         const HeaderM(title: 'Gastos', ico: Icons.home),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showPicker();
                    // print("*********************");
                    // print(DateFormat('dd/MM/yyyy').format(date));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kSecondaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ))),
                  child: Text(
                    Mes(selectedValue) + ' de ' + date.year.toString(),
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontFamily: 'UbuntuRegular',
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: _tooltipBehavior,


                    title: ChartTitle(


                        text: 'Compras del mes ( CUP )',
                        textStyle: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor)),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    series: <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                        // Bind data source
                        dataSource: dataSales,


                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,

                        dataLabelSettings: DataLabelSettings(isVisible: true),

                        name: 'Precio total por día',
                        markerSettings: MarkerSettings(isVisible: true),

                        enableTooltip: true,
                        animationDuration: 300,
                      ),
                    ])
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getBuys();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        borderColor: kotherColor,
        borderWidth: 5,
        color: kPrimaryColor,
        tooltipPosition: TooltipPosition.auto,
        header: 'Precio',
       // format: '3 po',
        activationMode: ActivationMode.singleTap);


  }

  @override
  void dispose() {
    super.dispose();
  }

  _getBuys() async {
    var dataFL3 = await getDataList(selectedValue);
    setState(() {
      //print('**-*-LISTAAAAAAA*-****-**-jlk');
      dataSales = dataFL3;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      //initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime(DateTime.now().year + 20),
      helpText: 'Seleccione el mes a visualizar las compras',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // header background color
              onPrimary: kSecondaryColor, // header text color
              onSurface: kPrimaryColor.withOpacity(.8), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kPrimaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null && selected != date) {
      setState(() {
        date = selected;
      });
    }
  }

  static const TextStyle? style = TextStyle(color: Colors.white, fontSize: 30);

  _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            child: CupertinoPicker(
              backgroundColor: kPrimaryColor,
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedValue = value + 1;
                  print(selectedValue);

                  _getBuys();

                });
              },
              itemExtent: 40.0,
              children: const [
                Text('Enero', style: style),
                Text('Febrero', style: style),
                Text('Marzo', style: style),
                Text('Abril', style: style),
                Text('Mayo', style: style),
                Text('Junio', style: style),
                Text('Julio', style: style),
                Text('Agosto', style: style),
                Text('Septiembre', style: style),
                Text('Octubre', style: style),
                Text('Noviembre', style: style),
                Text('Diciembre', style: style),
              ],
            ),
          );
        });
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

String Mes(int month) {
  String result = '';

  switch (month) {
    case 1:
      result = 'Enero';
      break;
    case 2:
      result = 'Febrero';
      break;
    case 3:
      result = 'Marzo';
      break;
    case 4:
      result = 'Abril';
      break;
    case 5:
      result = 'Mayo';
      break;
    case 6:
      result = 'Junio';
      break;
    case 7:
      result = 'Julio';
      break;
    case 8:
      result = 'Agosto';
      break;
    case 9:
      result = 'Septiembre';
      break;
    case 10:
      result = 'Octubre';
      break;
    case 11:
      result = 'Noviembre';
      break;
    case 12:
      result = 'Diciembre';
      break;

    default: '';
  }

 return result;
}

Future<List<SalesData>> getDataList(int month) async {

  List<String> list = [];
  List<SalesData> list2 = [];

  DateTime daterec = new DateTime(DateTime.now().year,month, 1 );
  String first = findFirstDateOfTheMonth(daterec).toIso8601String();
  String last = findLastDateOfTheMonth(daterec).toIso8601String();



  int total = 0;
  print('El mes recibido es: ${month}' );
  print('Empieza: ${first}' );
  print('Termina: ${last}' );
  final allRows = await getBuybyDates(first, last, tableCartProducts);
  print('La cantidad de elementos es: ${allRows.length}');

  for (int i = 0; i < allRows.length; i++) {
    //print(allRows[i]);
    CartProduct b = CartProduct.fromJson(allRows[i]);
    b.id = allRows[i][BuyFields.id] as int;
    //print(b.toJson());
    if (list.contains(b.date) == false) {
      list.add(b.date);
    }
    //print(p.id);

  }
  list.sort();
  print(list);

  for (int j = 0; j < list.length; j++) {
    var allRows = await listCartProductBuy(list[j]);
    double cant = 0;
    for (int k = 0; k < allRows.length; k++) {
      double t = allRows[k].price * allRows[k].cuota * allRows[k].cant;
      cant = cant + t.round();
    }

    if (cant > 0) {
      DateTime d = DateFormat('dd/MM/yyy').parse(list[j]);
      SalesData data = new SalesData( d.day.toString()+ " "+DateFormat('MMM').format(d), cant);
      list2.add(data);
    }
  }
  // print('**-*-LISTAAAAAAA*-****-**-jlk');
  //print(list2);
  return list2;
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 7));
}

DateTime findFirstDateOfTheMonth(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, 1);
}

DateTime findLastDateOfTheMonth(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month + 1, 0);
}

DateTime getWeek(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month + 1, 0);
}

List<DateTime> weekDays(DateTime date, int numberOfweek) {
  List<DateTime> list = [];

  bool verify = false;

  DateTime dateSelect = findFirstDateOfTheWeek(date);

  for (int i = 0; i < 7; i++) {
    DateTime newDate =
        new DateTime(dateSelect.year, dateSelect.month, dateSelect.day + i);
    print("La fecha es ${newDate}");

    if (newDate.month == date.month) {
      list.add(newDate);
    }
  }

  return list;
}
