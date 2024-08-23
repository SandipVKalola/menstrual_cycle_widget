import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../menstrual_cycle_widget.dart';
import 'model/display_symptoms_data.dart';
import 'model/log_report.dart';

// ignore: must_be_immutable
class MenstrualLogPeriodView extends StatefulWidget {
  DateTime? symptomsLogDate;
  Function? onSuccess;
  Function? onError;
  bool? isRequiredWaterView;
  bool? isRequiredBodyTemperatureView;
  bool? isRequiredWeightView;
  bool? isRequiredSleepView;
  DisplaySymptomsData? displaySymptomsData;
  bool? isRequiredMeditationView;

  MenstrualLogPeriodView(
      {super.key,
      this.symptomsLogDate,
      required this.onSuccess,
      required this.onError,
      required this.displaySymptomsData,
      this.isRequiredWaterView = true,
      this.isRequiredBodyTemperatureView = true,
      this.isRequiredMeditationView = true,
      this.isRequiredSleepView = true,
      this.isRequiredWeightView = true});

  @override
  State<MenstrualLogPeriodView> createState() => _MenstrualLogPeriodViewState();
}

class _MenstrualLogPeriodViewState extends State<MenstrualLogPeriodView> {
  List<Symptoms> symptomsList = [];
  final dbHelper = MenstrualCycleDbHelper.instance;
  final mInstance = MenstrualCycleWidget.instance!;

  List<LogReport> logReportList = [
    LogReport(type: "weight", mainValue: 20, subValue: 0),
    LogReport(type: "bodyTemp", mainValue: 35, subValue: 1),
    LogReport(type: "sleepBedTime", mainValue: 0, subValue: 0),
    LogReport(type: "meditation", mainValue: 0, subValue: 0),
    LogReport(type: "water"),
    LogReport(type: "sleepWakeUpTime", mainValue: 0, subValue: 0),
  ];
  String currentDate = "";
  String logDate = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  /// Regenerate list for symptoms data
  regenerateData() {
    for (int index = 0; index < defaultSymptomsData.length; index++) {
      Symptoms defaultData = defaultSymptomsData[index];
      bool isVisible = isVisibleSymptoms(defaultData.categoryName!);
      if (isVisible) {
        Symptoms symptoms = Symptoms(symptomsData: []);
        symptoms.categoryId = defaultData.categoryId;
        symptoms.categoryName = defaultData.categoryName;
        symptoms.categoryColor = defaultData.categoryColor;
        List<SymptomsData> listSymptomsData = [];
        for (int indexJ = 0;
            indexJ < defaultSymptomsData[index].symptomsData!.length;
            indexJ++) {
          SymptomsData deSymptomsData =
              defaultSymptomsData[index].symptomsData![indexJ];
          SymptomsData symptomsData = SymptomsData();
          symptomsData.symptomName = deSymptomsData.symptomName;
          symptomsData.symptomId = deSymptomsData.symptomId;
          symptomsData.isSelected = false;
          listSymptomsData.add(symptomsData);
        }
        symptoms.symptomsData!.addAll(listSymptomsData);
        symptomsList.add(symptoms);
      }
    }
  }

  init() async {
    if (widget.symptomsLogDate == null) {
      var now = DateTime.now();
      logDate = defaultDateFormat.format(now);
    } else {
      try {
        logDate = defaultDateFormat.format(widget.symptomsLogDate!);
      } catch (e) {
        throw Strings.errorInvalidSymptomsDate;
      }
    }

    currentDate = currentDateFormat.format(DateTime.now());
    regenerateData();
    setState(() {
      isLoading = false;
    });
  }

  bool isVisibleSymptoms(String symptomName) {
    DisplaySymptomsData displaySymptomsData = widget.displaySymptomsData!;
    if (symptomName == Strings.categoryFeelings) {
      return displaySymptomsData.isRequiredFeelings;
    } else if (symptomName == Strings.categoryMind) {
      return displaySymptomsData.isRequiredMind;
    } else if (symptomName == Strings.categorySexualLife) {
      return displaySymptomsData.isRequiredSexualLife;
    } else if (symptomName == Strings.categoryEnergy) {
      return displaySymptomsData.isRequiredEnergy;
    } else if (symptomName == Strings.categoryPeriod) {
      return displaySymptomsData.isRequiredPeriod;
    } else if (symptomName == Strings.categorySymptoms) {
      return displaySymptomsData.isRequiredSymptoms;
    } else if (symptomName == Strings.categoryPain) {
      return displaySymptomsData.isRequiredPain;
    } else if (symptomName == Strings.categoryVaginalDischarge) {
      return displaySymptomsData.isRequiredVaginalDischarge;
    } else if (symptomName == Strings.categoryDigestion) {
      return displaySymptomsData.isRequiredDigestion;
    } else if (symptomName == Strings.categoryActivity) {
      return displaySymptomsData.isRequiredActivity;
    } else if (symptomName == Strings.categoryCravings) {
      return displaySymptomsData.isRequiredCravings;
    } else if (symptomName == Strings.categoryTests) {
      return displaySymptomsData.isRequiredTests;
    } else if (symptomName == Strings.categoryAilments) {
      return displaySymptomsData.isRequiredAilments;
    } else if (symptomName == Strings.categoryAppointments) {
      return displaySymptomsData.isRequiredAppointments;
    } else if (symptomName == Strings.categoryBirthControlPill) {
      return displaySymptomsData.isRequiredBirthControlPill;
    } else if (symptomName == Strings.categoryIUD) {
      return displaySymptomsData.isRequiredIUD;
    } else if (symptomName == Strings.categorySupplements) {
      return displaySymptomsData.isRequiredSupplements;
    } else if (symptomName == Strings.categoryUrine) {
      return displaySymptomsData.isRequiredUrine;
    } else if (symptomName == Strings.categoryOther) {
      return displaySymptomsData.isRequiredOther;
    }
    return false;
  }

  /// Save body temperature data
  saveBodyTempLog() {
    if (logReportList[1].subValue! > 0) {
      if (logReportList[1].subValue! > 9) {
        logReportList[1].finalValue =
            "${logReportList[1].mainValue}.${logReportList[1].subValue}";
      } else {
        logReportList[1].finalValue =
            "${logReportList[1].mainValue}.0${logReportList[1].subValue}";
      }
    } else {
      logReportList[1].finalValue = "${logReportList[1].mainValue}";
    }
    setState(() {});
  }

  /// save meditation data
  saveMeditationLog() {
    String hour = "00";
    String min = "00";
    if (logReportList[3].mainValue! > 9) {
      hour = "${logReportList[3].mainValue!}";
    } else {
      hour = "0${logReportList[3].mainValue!}";
    }
    if (logReportList[3].subValue! > 9) {
      min = "${logReportList[3].subValue!}";
    } else {
      min = "0${logReportList[3].subValue!}";
    }
    logReportList[3].finalValue = "$hour h : $min m";
    logReportList[3].totalMin =
        (logReportList[3].mainValue! * 60) + logReportList[3].subValue!;
    setState(() {});
  }

  /// save sleep data
  saveSleepLog({bool isWakeUpTime = false}) {
    int index = 2;
    if (isWakeUpTime) {
      index = 5;
    }
    String hour = "00";
    String min = "00";
    if (logReportList[index].mainValue! > 9) {
      hour = "${logReportList[index].mainValue!}";
    } else {
      hour = "0${logReportList[index].mainValue!}";
    }
    if (logReportList[index].subValue! > 9) {
      min = "${logReportList[index].subValue!}";
    } else {
      min = "0${logReportList[index].subValue!}";
    }
    logReportList[index].finalValue = "$hour h : $min m";
    logReportList[index].totalMin =
        (logReportList[index].mainValue! * 60) + logReportList[index].subValue!;
    setState(() {});
  }

  saveSleepWackUpLog() {
    int index = 5;
    String hour = "00";
    String min = "00";
    if (logReportList[index].mainValue! > 9) {
      hour = "${logReportList[index].mainValue!}";
    } else {
      hour = "0${logReportList[index].mainValue!}";
    }
    if (logReportList[index].subValue! > 9) {
      min = "${logReportList[index].subValue!}";
    } else {
      min = "0${logReportList[index].subValue!}";
    }
    logReportList[index].finalValue = "$hour h : $min m";
    logReportList[index].totalMin =
        (logReportList[index].mainValue! * 60) + logReportList[index].subValue!;
    setState(() {});
  }

  /// save drink water data
  saveWaterLog() {
    if (logReportList[4].mainValue! > 9) {
      logReportList[4].finalValue = "${logReportList[4].mainValue}";
    } else {
      logReportList[4].finalValue = "0${logReportList[4].mainValue}";
    }
    setState(() {});
  }

  /// save weight data
  saveWeightLog() {
    if (logReportList[0].subValue! > 0) {
      logReportList[0].finalValue =
          "${logReportList[0].mainValue}.${logReportList[0].subValue}00";
    } else {
      logReportList[0].finalValue = "${logReportList[0].mainValue}";
    }
    setState(() {});
  }

  /// save today logs to database
  saveTodayLogs() async {
    List<SymptomsData> userLogData = [];
    for (int index = 0; index < symptomsList.length; index++) {
      for (int j = 0; j < symptomsList[index].symptomsData!.length; j++) {
        SymptomsData symptomsData = symptomsList[index].symptomsData![j];
        if (symptomsData.isSelected) {
          //printLogs("Selected  Name: ${symptomsData.symptomName}");
          userLogData.add(symptomsData);
        }
      }
    }
    final instance = MenstrualCycleWidget.instance!;
    instance.saveSymptomsLogs(
        userSymptomsData: userLogData,
        onError: widget.onError,
        symptomsLogDate: widget.symptomsLogDate,
        onSuccess: widget.onSuccess,
        waterValue: (logReportList[4].finalValue!.isNotEmpty)
            ? logReportList[4].finalValue.toString()
            : "0",
        bodyTemperature: (logReportList[1].finalValue!.isNotEmpty)
            ? logReportList[1].finalValue.toString()
            : "0",
        weight: (logReportList[0].finalValue!.isNotEmpty)
            ? logReportList[0].finalValue.toString()
            : "0",
        meditationTime: logReportList[3].totalMin!.toString(),
        sleepBedTime: TimeOfDay(
            hour: logReportList[2].mainValue!.toInt(),
            minute: logReportList[2].subValue!.toInt()),
        sleepWakeUpTime: TimeOfDay(
            hour: logReportList[5].mainValue!.toInt(),
            minute: logReportList[5].subValue!.toInt()));

    Navigator.pop(context);
  }

  /// open bottom sheet view for perform operation
  void _showBottomSheetView(
      {required BuildContext context,
      required String title,
      required String type,
      required Function onClick,
      required Widget childView}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  childView,
                  Text(
                    type,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  onClick.call();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                    color: Colors.green,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      Strings.lblDone,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// build water picker view
  Widget _buildWaterPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          value: logReportList[4].mainIndex!,
          minValue: 0,
          maxValue: 20,
          onSelectedItemChanged: (index) {
            logReportList[4].mainValue = 0 + index;
            logReportList[4].mainIndex = index;
          },
        ),
      ],
    );
  }

  /// build body temperature view
  Widget _buildTemperaturePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          value: logReportList[1].mainIndex!,
          minValue: 35,
          maxValue: 40,
          onSelectedItemChanged: (index) {
            logReportList[1].mainValue = 35 + index;
            logReportList[1].mainIndex = index;
          },
        ),
        const Text(
          '.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        _buildPicker(
          value: logReportList[1].subIndex!,
          minValue: 1,
          maxValue: 99,
          onSelectedItemChanged: (index) {
            logReportList[1].subValue = 1 + index;
            logReportList[1].subIndex = index;
          },
        ),
      ],
    );
  }

  /// build sleep picker view
  Widget _buildSleepPicker({bool isWakeUpTime = false}) {
    int logIndex = 2;
    if (isWakeUpTime) {
      logIndex = 5;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          value: logReportList[logIndex].mainIndex!,
          minValue: 0,
          maxValue: 23,
          onSelectedItemChanged: (index) {
            logReportList[logIndex].mainValue = 0 + index;
            logReportList[logIndex].mainIndex = index;
          },
        ),
        const Text(
          'h',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        _buildPicker(
          value: logReportList[logIndex].subIndex!,
          minValue: 0,
          maxValue: 60,
          onSelectedItemChanged: (index) {
            logReportList[logIndex].subValue = 0 + index;
            logReportList[logIndex].subIndex = index;
          },
        ),
        const Text(
          'm',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// build meditation picker view
  Widget _buildMeditationPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          value: logReportList[3].mainIndex!,
          minValue: 0,
          maxValue: 23,
          onSelectedItemChanged: (index) {
            logReportList[3].mainValue = 0 + index;
            logReportList[3].mainIndex = index;
          },
        ),
        const Text(
          'h',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        _buildPicker(
          value: logReportList[3].subIndex!,
          minValue: 0,
          maxValue: 60,
          onSelectedItemChanged: (index) {
            logReportList[3].subValue = 0 + index;
            logReportList[3].subIndex = index;
          },
        ),
        const Text(
          'm',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// build weight picker view
  Widget _buildWeightPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPicker(
          value: logReportList[0].mainIndex!,
          minValue: 20,
          maxValue: 300,
          onSelectedItemChanged: (index) {
            logReportList[0].mainValue = 20 + index;
            logReportList[0].mainIndex = index;
          },
        ),
        const Text(
          '.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        _buildPicker(
          value: logReportList[0].subIndex!,
          minValue: 0,
          isForWeight: true,
          maxValue: 9,
          onSelectedItemChanged: (index) {
            logReportList[0].subValue = 0 + index;
            logReportList[0].subIndex = index;
          },
        ),
      ],
    );
  }

  /// Build picker view
  Widget _buildPicker({
    required int value,
    required int minValue,
    required int maxValue,
    required ValueChanged<int> onSelectedItemChanged,
    bool isForWeight = false,
  }) {
    return SizedBox(
      height: 150,
      width: 80,
      child: CupertinoPicker(
        magnification: 1.4,
        squeeze: 0.8,
        useMagnifier: true,
        scrollController: FixedExtentScrollController(initialItem: value),
        itemExtent: 32.0,
        onSelectedItemChanged: onSelectedItemChanged,
        children: List.generate(maxValue - minValue + 1, (index) {
          return Center(
            child: (isForWeight)
                ? Text(
                    (minValue + index).toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : ((minValue + index) > 9)
                    ? Text(
                        (minValue + index).toString(),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "0${(minValue + index)}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
          );
        }),
      ),
    );
  }

  Widget sleepView({
    required String image,
    required String title,
    required String startTimeHintText,
    required String endTimeHintText,
    required Widget removeIcon,
    required Function onStartTimeClick,
    required Function onEndTimeClick,
    required Function onRemoveClick,
    required String typeString,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        image,
                        package: flutterPackageName,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: Material(
                          color: const Color(0xFFD6D6D6), // Button color
                          child: InkWell(
                            splashColor: Colors.black26, // Splash color
                            onTap: () {
                              onRemoveClick.call();
                            },
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: removeIcon,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bedtime",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(),
                  Text(
                    "Wake-up time",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      onStartTimeClick.call();
                    },
                    child: Text(
                      startTimeHintText,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(),
                  GestureDetector(
                    onTap: () {
                      onEndTimeClick.call();
                    },
                    child: Text(
                      endTimeHintText,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Design log view for water, body temperature, weight etc
  Widget logView({
    required String image,
    required String title,
    required String hintText,
    required Widget addIcon,
    required Widget removeIcon,
    required Function onAddClick,
    required Function onRemoveClick,
    required String typeString,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        image,
                        package: flutterPackageName,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: Material(
                          color: const Color(0xFFD6D6D6), // Button color
                          child: InkWell(
                            splashColor: Colors.black26, // Splash color
                            onTap: () {
                              onRemoveClick.call();
                            },
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: removeIcon,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ClipOval(
                        child: Material(
                          color: const Color(0xFFD6D6D6), // Button color
                          child: InkWell(
                            splashColor: Colors.black26, // Splash color
                            onTap: () {
                              onAddClick.call();
                            },
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: addIcon,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      onAddClick.call();
                    },
                    child: Text(
                      hintText,
                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      typeString,
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      logDate,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                (isLoading)
                    ? const SizedBox(
                        height: 150,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: symptomsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.white,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${symptomsList[index].categoryName}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Wrap(
                                      children: symptomsList[index]
                                          .symptomsData!
                                          .map((chip) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          FilterChip(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                            key: ValueKey(chip),
                                            side: chip.isSelected
                                                ? BorderSide(
                                                    color: Color(
                                                      int.parse(
                                                          "0xff${symptomsList[index].categoryColor}"),
                                                    ),
                                                  )
                                                : BorderSide.none,
                                            label: Text("${chip.symptomName}"),
                                            padding: const EdgeInsets.all(1),
                                            backgroundColor: chip.isSelected
                                                ? Colors.white
                                                : Color(
                                                    int.parse(
                                                        "0x0D${symptomsList[index].categoryColor}"),
                                                  ),
                                            onSelected: (bool value) {
                                              setState(() {
                                                chip.isSelected =
                                                    !chip.isSelected;
                                              });
                                            },
                                          ),
                                          (chip.isSelected)
                                              ? Icon(Icons.check_circle_rounded,
                                                  color: Color(
                                                    int.parse(
                                                        "0xff${symptomsList[index].categoryColor}"),
                                                  ),
                                                  size: 16)
                                              : const SizedBox(),
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                (widget.isRequiredWeightView!)
                    ? logView(
                        title: Strings.lblWeight,
                        addIcon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        hintText: (logReportList[0].finalValue!.isNotEmpty)
                            ? logReportList[0].finalValue!
                            : "000",
                        image: weightImage,
                        onAddClick: () {
                          _showBottomSheetView(
                              context: context,
                              type: Strings.weightKg,
                              onClick: saveWeightLog,
                              childView: _buildWeightPicker(),
                              title: Strings.lblWeightTitle);
                        },
                        onRemoveClick: () {},
                        removeIcon: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        typeString: "/ ${Strings.weightKg}")
                    : const SizedBox(),
                (widget.isRequiredBodyTemperatureView!)
                    ? logView(
                        title: Strings.lblBodyTemp,
                        addIcon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        hintText: (logReportList[1].finalValue!.isNotEmpty)
                            ? logReportList[1].finalValue!
                            : "000",
                        image: temperatureImage,
                        onAddClick: () {
                          _showBottomSheetView(
                              context: context,
                              title: Strings.lblBodyTempTitle,
                              childView: _buildTemperaturePicker(),
                              onClick: saveBodyTempLog,
                              type: "°${Strings.bodyTempC}");
                        },
                        onRemoveClick: () {},
                        removeIcon: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        typeString: "/ °${Strings.bodyTempC}")
                    : const SizedBox(),
                (widget.isRequiredSleepView!)
                    ? sleepView(
                        title: Strings.lblSleep,
                        /* addIcon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),*/
                        startTimeHintText:
                            (logReportList[2].finalValue!.isNotEmpty)
                                ? logReportList[2].finalValue!
                                : "00 h : 00 m",
                        endTimeHintText:
                            (logReportList[5].finalValue!.isNotEmpty)
                                ? logReportList[5].finalValue!
                                : "00 h : 00 m",
                        image: sleepImage,
                        onEndTimeClick: () {
                          _showBottomSheetView(
                              context: context,
                              type: "",
                              onClick: saveSleepWackUpLog,
                              childView: _buildSleepPicker(isWakeUpTime: true),
                              title: "Log your wake-up time");
                        },
                        onStartTimeClick: () {
                          _showBottomSheetView(
                              context: context,
                              type: "",
                              onClick: saveSleepLog,
                              childView: _buildSleepPicker(),
                              title: " Log your bedtime");
                        },
                        onRemoveClick: () {},
                        removeIcon: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        typeString: "")
                    : const SizedBox(),
                (widget.isRequiredMeditationView!)
                    ? logView(
                        title: Strings.lblMeditation,
                        addIcon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        hintText: (logReportList[3].finalValue!.isNotEmpty)
                            ? logReportList[3].finalValue!
                            : "00 h : 00 m",
                        image: yogaImage,
                        onAddClick: () {
                          _showBottomSheetView(
                              context: context,
                              type: "",
                              onClick: saveMeditationLog,
                              childView: _buildMeditationPicker(),
                              title: Strings.lblMeditationTitle);
                        },
                        onRemoveClick: () {},
                        removeIcon: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        typeString: "")
                    : const SizedBox(),
                (widget.isRequiredWaterView!)
                    ? logView(
                        title: Strings.lblWater,
                        addIcon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        hintText: (logReportList[4].finalValue!.isNotEmpty)
                            ? logReportList[4].finalValue!
                            : "00",
                        image: drinkWaterImage,
                        onAddClick: () {
                          _showBottomSheetView(
                              context: context,
                              title: Strings.lblWaterTitle,
                              childView: _buildWaterPicker(),
                              onClick: saveWaterLog,
                              type: Strings.graphWaterUnitLiter);
                        },
                        onRemoveClick: () {},
                        removeIcon: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        typeString: "/ ${Strings.graphWaterUnitLiter}")
                    : const SizedBox(),
                GestureDetector(
                  onTap: () {
                    saveTodayLogs();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                      color: Colors.green,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        Strings.saveLogs,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
