import 'dart:convert';

import 'package:candle_chart/components/kprint.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<KLineEntity>? datas;
  bool showLoading = true;

  List<DepthEntity>? _bids, _asks;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    super.initState();
    getData('1min');
    rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      final tick = parseJson['tick'] as Map<String, dynamic>;
      final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
          .map<DepthEntity>(
              (item) => DepthEntity(item[0] as double, item[1] as double))
          .toList();
      final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
          .map<DepthEntity>(
              (item) => DepthEntity(item[0] as double, item[1] as double))
          .toList();
      initDepth(bids, asks);
    });
  }

  void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    for (var item in bids.reversed) {
      amount += item.vol;
      item.vol = amount;
      _bids!.insert(0, item);
    }

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    for (var item in asks) {
      amount += item.vol;
      item.vol = amount;
      _asks!.add(item);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  KChartWidget(
                    datas,
                    chartStyle,
                    onSelectTimeFrame: (frame) async {
                      await getData(_period(frame));
                    },
                    chartColors,
                    isTrendLine: false,
                    // mainState: _mainState,
                    // volHidden: _volHidden,
                    // secondaryStateLi: _secondaryStateLi.toSet(),
                    fixedLength: 2,
                    timeFormat: TimeFormat.YEAR_MONTH_DAY,
                  ),
                  if (showLoading)
                    Container(
                      width: double.infinity,
                      height: 450,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _period(CandleTimeFormat format) {
    switch (format) {
      case CandleTimeFormat.M1:
        return '1min';
      case CandleTimeFormat.M5:
        return '5min';
      case CandleTimeFormat.M15:
        return '15min';
      case CandleTimeFormat.M30:
        return '30min';
      case CandleTimeFormat.H1:
        return '60min';
      case CandleTimeFormat.H4:
        return '4hour';
      case CandleTimeFormat.D1:
        return '1day';
      case CandleTimeFormat.W1:
        return '1week';
      case CandleTimeFormat.MN:
        return '1mon';
      default:
        return '4hour';
    }
  }

  Future<void> getData(String period) async {
    try {
      showLoading = true;
      setState(() {});
      final String value = await getChatDataFromInternet(period);
      //final Future<String> future = getChatDataFromJson();
      solveChatData(value);
    } catch (e) {
      debugPrint('### datas error $e');
    }
    showLoading = false;
    setState(() {});
  }

  Future<String> getChatDataFromInternet(String? period) async {
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=400&symbol=btcusdt';
    late String result;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      debugPrint('Failed getting IP address');
    }
    return result;
  }

  Future<String> getChatDataFromJson() async {
    return rootBundle.loadString('assets/chatData.json');
  }

  void solveChatData(String result) {
    final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
    final list = parseJson['data'] as List<dynamic>;
    datas = list
        .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();

    showLoading = false;
    setState(() {});
  }
}
