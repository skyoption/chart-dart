import 'dart:convert';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/l10n/chart_localizations.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KChart.openDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      supportedLocales: ChartLocalizations.supportedLocales,
      locale: const Locale('en'),
      localizationsDelegates: const [
        ChartLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
  bool showLoading = false;

  List<DepthEntity>? _bids, _asks;

  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    super.initState();
    // rootBundle.loadString('assets/depth.json').then((result) {
    //   final parseJson = json.decode(result);
    //   final tick = parseJson['tick'] as Map<String, dynamic>;
    //   final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
    //       .map<DepthEntity>(
    //           (item) => DepthEntity(item[0] as double, item[1] as double))
    //       .toList();
    //   final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
    //       .map<DepthEntity>(
    //           (item) => DepthEntity(item[0] as double, item[1] as double))
    //       .toList();
    //   initDepth(bids, asks);
    // });
    getData(_period(CandleTimeFormat.H1)).then(
      (value) {
        key.currentState!.updateDefaultSettings(
          frame: CandleTimeFormat.H1,
          symbol: 'btcusdt',
        );
        key.currentState!.setLoadedCandles(candles: datas!);
        // key.currentState!.updateAskAndBid(
        //   LineEntity(
        //     id: -10,
        //     color: Colors.red,
        //     value: 96880.50,
        //   ),
        // );
        key.currentState!.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: 10000,
            type: 'SL',
            color: Colors.red,
            value: 96780.50,
            title: 'SL',
            editable: true,
          ),
        );
        key.currentState!.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: 10001,
            type: 'TP',
            color: Colors.red,
            value: 96446.50,
            title: 'TP',
            editable: true,
          ),
        );
        key.currentState!.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: 10002,
            type: 'Position',
            color: Colors.blue,
            value: 95430.50,
            title: 'Buy 0.1',
            editable: false,
          ),
        );
      },
    );
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

  final GlobalKey<KChartWidgetState> key = GlobalKey<KChartWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: const Icon(Icons.data_object),
                    onTap: () {
                      key.currentState?.openObjects();
                    },
                  ),
                  const SizedBox(width: 21.0),
                  InkWell(
                    child: const Icon(Icons.format_indent_decrease),
                    onTap: () {
                      key.currentState?.openIndicators();
                    },
                  ),
                ],
              ),
              KChartWidget(
                key: key,
                hideGrid: false,
                chartStyle: ChartStyle(areaLineWidth: 1),
                chartColors: chartColors,
                graphStyle: GraphStyle.candles,
                onGettingSettings: (frame, symbol) {},
                onUpdatePosition: (position, newValue) {
                  kPrint(
                      '${position.id} ${position.type} OldValue : ${position.value} NewValue : $newValue');
                },
                onZoomingStart: (bool value) {},
                fixedLength: 2,
                timeFormat: TimeFormat.YEAR_MONTH_DAY,
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
      case CandleTimeFormat.MN1:
        return '1mon';
      default:
        return '4hour';
    }
  }

  Future<void> getData(String period) async {
    showLoading = true;
    try {
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
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '4hour'}&size=400&symbol=btcusdt';
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

  void solveChatData(String result) async {
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
