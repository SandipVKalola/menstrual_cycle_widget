import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import '../../menstrual_cycle_widget.dart';
import 'graph_util.dart';
import 'model/body_temperature_data.dart';

class MenstrualBodyTemperatureGraph extends StatefulWidget {
  final String loadingText;
  final BodyTemperatureUnits? bodyTemperatureUnits;
  final bool isShowMoreOptions;
  final Function? onDownloadImagePath;
  final Function? onDownloadPdfPath;
  final String xAxisTitle;
  final String yAxisTitle;
  final TextStyle xAxisTitleTextStyle;
  final TextStyle yAxisTitleTextStyle;
  final bool isShowXAxisTitle;
  final bool isShowYAxisTitle;

  const MenstrualBodyTemperatureGraph(
      {super.key,
      this.bodyTemperatureUnits = BodyTemperatureUnits.celsius,
      this.isShowMoreOptions = false,
      this.loadingText = Strings.loading,
      this.isShowXAxisTitle = true,
      this.isShowYAxisTitle = true,
      this.yAxisTitle = Strings.graphBodyTempTitle,
      this.onDownloadImagePath,
      this.xAxisTitle = Strings.graphBodyTempDate,
      this.xAxisTitleTextStyle =
          const TextStyle(color: Colors.black, fontSize: 10),
      this.yAxisTitleTextStyle =
          const TextStyle(color: Colors.black, fontSize: 10),
      this.onDownloadPdfPath});

  @override
  State<MenstrualBodyTemperatureGraph> createState() =>
      _MenstrualBodyTemperatureGraphState();
}

class _MenstrualBodyTemperatureGraphState
    extends State<MenstrualBodyTemperatureGraph> {
  ChartSeriesController<BodyTemperatureData, String>? seriesController;

  List<BodyTemperatureData> allBodyTemperatureData = [];
  late GlobalKey<SfCartesianChartState> _chartKey;
  late bool isLoadMoreView, isNeedToUpdateView, isDataUpdated;
  num? oldAxisVisibleMin, oldAxisVisibleMax;
  int pageNumber = 1;
  int itemsPerPage = 7;
  double minValue = 0;
  double maxValue = 0;
  bool isGetData = false;
  bool isLastRecord = false;
  String tempUnit = "C";
  TooltipBehavior? _tooltipBehavior;
  String fileName = "Body_temperature_graph_";
  late ZoomPanBehavior? _zoomPanBehavior;
  late GlobalKey<State> globalKey;

  @override
  void initState() {
    _initializeVariables();
    init();
    super.initState();
  }

  void _initializeVariables() async {
    _chartKey = GlobalKey();
    isLoadMoreView = false;
    isNeedToUpdateView = false;
    isDataUpdated = true;
    globalKey = GlobalKey<State>();
    _tooltipBehavior = TooltipBehavior(enable: true, canShowMarker: false);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      maximumZoomLevel: 0.3,
      zoomMode: ZoomMode.x,
    );
  }

  init() async {
    final instance = MenstrualCycleWidget.instance!;
    Map<String, double> minMaxTemp = await instance.getMinMaxBodyTemperature();
    minValue = minMaxTemp['min_temp']! - 10;
    maxValue = minMaxTemp['max_temp']! + 10;

    allBodyTemperatureData = await instance.getTemperatureLog(
        startDate: DateTime.now().add(const Duration(days: -1000)),
        endDate: DateTime.now(),
        bodyTemperatureUnits: widget.bodyTemperatureUnits,
        pageNumber: pageNumber,
        itemsPerPage: itemsPerPage);
    if (allBodyTemperatureData.length < 7) {
      isLastRecord = true;
    }

    tempUnit = (widget.bodyTemperatureUnits.toString() ==
            BodyTemperatureUnits.celsius.toString())
        ? "C"
        : "F";
    isGetData = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (allBodyTemperatureData.isNotEmpty) {
      return Stack(children: [
        _buildBodyTemperatureView(),
        (widget.isShowMoreOptions)
            ? getMenuWidget(
                fileName: fileName,
                onDownloadPdfPath: widget.onDownloadPdfPath,
                globalKey: _chartKey,
                onDownloadImagePath: widget.onDownloadImagePath)
            : const SizedBox(),
      ]);
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (isGetData)
              ? const Text(Strings.noDataFound)
              : Text(widget.loadingText),
        ),
      );
    }
  }

  /// Get the body temperature graph view
  SfCartesianChart _buildBodyTemperatureView() {
    return SfCartesianChart(
      key: _chartKey,
      zoomPanBehavior: _zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {},
      onActualRangeChanged: (ActualRangeChangedArgs args) {
        if (args.orientation == AxisOrientation.horizontal) {
          if (isLoadMoreView) {
            args.visibleMin = oldAxisVisibleMin;
            args.visibleMax = oldAxisVisibleMax;
          }
          oldAxisVisibleMin = args.visibleMin as num;
          oldAxisVisibleMax = args.visibleMax as num;
          isLoadMoreView = false;
        }
      },
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        rangePadding: ChartRangePadding.normal,
        labelRotation: -70,
        labelStyle: widget.xAxisTitleTextStyle,
        title: (widget.isShowXAxisTitle)
            ? AxisTitle(
                text: widget.xAxisTitle,
                textStyle: widget.xAxisTitleTextStyle,
              )
            : const AxisTitle(
                text: "",
              ),
        labelPlacement: LabelPlacement.onTicks,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}°$tempUnit',
          minimum: minValue,
          maximum: maxValue,
          interval: 20,
          axisLine: const AxisLine(width: 0),
          labelStyle: widget.yAxisTitleTextStyle,
          title: (widget.isShowYAxisTitle)
              ? AxisTitle(
                  text: widget.yAxisTitle,
                  textStyle: widget.yAxisTitleTextStyle,
                )
              : const AxisTitle(
                  text: "",
                ),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      tooltipBehavior: _tooltipBehavior,
      series: _getGradientComparisonSeries(),
      loadMoreIndicatorBuilder:
          (BuildContext context, ChartSwipeDirection direction) =>
              getLoadMoreIndicatorBuilder(context, direction),
    );
  }

  /// The method returns line series to chart.
  List<CartesianSeries<BodyTemperatureData, String>>
      _getGradientComparisonSeries() {
    return <CartesianSeries<BodyTemperatureData, String>>[
      ColumnSeries<BodyTemperatureData, String>(
        dataSource: allBodyTemperatureData,
        onCreateShader: (ShaderDetails details) {
          return ui.Gradient.linear(
              details.rect.topCenter,
              details.rect.bottomCenter,
              const <Color>[Colors.red, Colors.orange, Colors.yellow],
              <double>[0.3, 0.6, 0.9]);
        },
        onRendererCreated:
            (ChartSeriesController<BodyTemperatureData, String>? controller) {
          seriesController = controller;
        },
        name: 'Body Temperature',
        xValueMapper: (BodyTemperatureData sales, _) => sales.dateTime,
        yValueMapper: (BodyTemperatureData sales, _) => sales.bodyTemperature,
        animationDuration: 0,
        dataLabelSettings:
            const DataLabelSettings(isVisible: false, offset: Offset(0, -5)),
      ),
    ];
  }

  Widget getLoadMoreIndicatorBuilder(
      BuildContext context, ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      isNeedToUpdateView = true;
      globalKey = GlobalKey<State>();
      return StatefulBuilder(
          key: globalKey,
          builder: (BuildContext context, StateSetter stateSetter) {
            Widget widget;
            if (isNeedToUpdateView) {
              widget = getProgressIndicator();
              _updateView();
              isDataUpdated = true;
            } else {
              widget = Container();
            }
            return widget;
          });
    } else {
      return SizedBox.fromSize(size: Size.zero);
    }
  }

  Future<void> _updateView() async {
    await Future<void>.delayed(const Duration(seconds: 1), () {
      isNeedToUpdateView = false;
      if (isDataUpdated) {
        pageNumber = pageNumber + 1;
        _updateData();
        isDataUpdated = false;
      }

      if (globalKey.currentState != null) {
        (globalKey.currentState as dynamic).setState(() {});
      }
    });
  }

  void _updateData() async {
    final instance = MenstrualCycleWidget.instance!;
    List<BodyTemperatureData> bodyTemperatureData =
        await instance.getTemperatureLog(
            startDate: DateTime.now().add(const Duration(days: -1000)),
            endDate: DateTime.now(),
            bodyTemperatureUnits: widget.bodyTemperatureUnits,
            pageNumber: pageNumber,
            itemsPerPage: itemsPerPage);
    if (bodyTemperatureData.isEmpty) {
      isLastRecord = true;
    }
    allBodyTemperatureData.addAll(bodyTemperatureData);
    isLoadMoreView = true;
    seriesController?.updateDataSource(
        addedDataIndexes: getIndexes(bodyTemperatureData.length));
  }

  Widget getProgressIndicator() {
    return (isLastRecord)
        ? const SizedBox()
        : Align(
            alignment: Alignment.centerRight,
            child: Padding(
              // ignore: use_named_constants
              padding: const EdgeInsets.only(),
              child: Container(
                width: 30,
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(33, 33, 33, 0.0),
                    Color.fromRGBO(33, 33, 33, 0.74)
                  ], stops: <double>[
                    0.0,
                    1
                  ]),
                ),
                child: const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    backgroundColor: Colors.transparent,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          );
  }

  List<int> getIndexes(int length) {
    final List<int> indexes = <int>[];
    for (int i = length - 1; i >= 0; i--) {
      indexes.add(allBodyTemperatureData.length - 1 - i);
    }
    return indexes;
  }

  @override
  void dispose() {
    seriesController = null;
    super.dispose();
  }
}
