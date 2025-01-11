class Strings {
  static const String pkgUrl =
      "https://pub.dev/packages/menstrual_cycle_widget";
  /* static const String secretKeyLabel =
      "Must required secretKey for data encryption";
  static const String ivKeyLabel = "Must required ivKey for data encryption";
  static const String totalCycleDaysLabel =
      "totalCycleDays size must be greater than 0";
  static const String totalPeriodDaysLabel =
      "totalPeriodDays size must be greater than 0";
  static const String printLogLabel = "LOG FROM MENSTRUAL CYCLE";
  static const String saveLabel = "Save";
  static const String cancelLabel = "Cancel";
  static const String editPeriodDateLabel = "Edit Period dates";
  static const String periodLabel = "Period";
  static const String predictOvulationDateLabel = "Predict ovulation date";
  static const String predictPeriodDateLabel = "Predict period date";
  static const String selectedDateLabel = "Selected date";
  static const String todayLabel = "Today";
  static const String menstruationLabel = "Menstruation";
  static const String follicularPhaseLabel = "Follicular phase";
  static const String ovulationLabel = "Ovulation";
  static const String lutealPhaseLabel = "Luteal phase";
  static const String dayLabel = "Day";
  static const String logPeriodLabel = "Log Period";

  static const String saveLogs = "Apply";

  /// Messages for circle text
  static const String pastCycleLabel = "Your period is";
  static const String circleDaysLateLabel = "Days late";
  static const String circleDayLateLabel = "Day late";
  static const String lateLabel = "Log your period for better predictions";
  static const String timeForPregnancyTestLabel = "Time for pregnancy test";
  static const String timeForPregnancyTestTitleLabel = "Today &";
  static const String timeForPregnancyTestTitleLabel2 = "more day";
  static const String timeForPregnancyTestTitleLabel4 = "more days";
  static const String timeForPregnancyTestTitleLabel3 = "Last day";
  static const String predictPeriodLabel = "Predict period day: ";
  static const String conceiveLabel = "Best chance to conceive is in";
  static const String conceiveLabel2 = "Best chance to conceive is";
  static const String periodPhaseLabel = "Period Day: ";
  static const String phaseDayLabel = "Day";
  static const String phaseDaysLabel = "Days";
  static const String pregnancyChanceMsg1 = "Medium chance of getting pregnant";
  static const String pregnancyChanceMsg2 = "High chance of getting pregnant";
  static const String pregnancyChanceMsg3 = "Last fertile day of this cycle";
  static const String pregnancyChanceMsg4 = "Low chance of getting pregnant";
  static const String ovulationDayMsg1 = "Prediction";
  static const String ovulationDayTitle = "Ovulation Day";
  static const String predictPeriodDayStartLabel = "Predict period start is in";
  static const String predictPeriodDayStartLabel2 =
      "May be your period start will be";
  static const String predictPeriodDayStartLabel1 = "Tomorrow";

  /// Error
  static const String errorInvalidSize =
      "Invalid 'MenstrualCyclePhaseView' widget size. Size must be greater than or equal to 200. See ";
  static const String errorInvalidCount =
      "Invalid 'totalCycleDays' count. Count must be greater than or equal to 10. See ";
  static const String errorInvalidMenstruationDayCount =
      "Invalid 'menstruationDayCount' count. Count must be greater than or equal to 0. See ";
  static const String errorInvalidFollicularDayCount =
      "Invalid 'follicularDayCount' count. Count must be greater than or equal to 0. See ";
  static const String errorInvalidOvulationDayCount =
      "Invalid 'ovulationDayCount' count. Count must be greater than or equal to 0. See ";
  static const String errorInvalidSymptomsLogDate =
      "Invalid symptoms log date. Date format is yyyy-MM-dd";
  static const String graphCycleTitle = "Cycle History";
  static const String graphCycleDaysPeriod = "days period";
  static const String graphCycleDaysCycle = "days cycle";
  static const String graphCycleNowTitle = "Now";
  static const String graphCycleViewAllTitle = "View All";
  static const String graphCycleStartDate = "Cycle start date";
  static const String loading = "Loading...";
  static const String graphCycleTrends = "Cycle trends";
  static const String graphCycleLengthDays = "Cycle length (in days)";
  static const String graphCycleNormalDays = "";
  static const String graphCyclePeriodDay = "Period days";
  static const String graphCycleOtherDay = "Other cycle days";
  static const String optionsDownloadImage = "Download Image";
  static const String optionsDownloadPDF = "Download PDF";
  static const String optionsViewLandscape = "Landscape mode";
  static const String toolTip = "Show menu";
  static const String noDataFound = "No data found";
  static const String graphBodyTempDate = "Body temperature log date";
  static const String graphBodyTempTitle = "Temperature unit";
  static const String graphWaterDrinkDate = "Water drinking date";
  static const String graphWaterUnitTitle = "Water unit";
  static const String graphWaterUnitLiter = "Liters";
  static const String bodyTempC = "C";
  static const String weightKg = "kg";
  static const String bodyTempF = "F";
  static const String errorInvalidSymptomsDate =
      "Invalid symptoms log date. Date format is yyyy-MM-dd";
  static const String lblDone = "Done";
  static const String lblWeight = "Weight";
  static const String lblWeightTitle = "Log your weight";
  static const String lblBodyTemp = "Body Temperature";
  static const String lblBodyTempTitle = "Log body temperature";
  static const String lblSleep = "Sleep";
  static const String lblSleepAm = "AM";
  static const String lblSleepPm = "PM";
  static const String lblSleepTitle = "Log your sleep time";
  static const String lblMeditation = "Meditation";
  static const String lblMeditationTitle = "Log your meditation time";
  static const String lblWater = "Water";
  static const String lblWaterTitle = "Log your drink water";
  static const String graphSleepTitle = "Time";
  static const String graphSleepDate = "Sleep log date";
  static const String graphWeightUnitTitle = "Weight unit";
  static const String graphWeightLogDate = "Weight log date";
  static const String categoryFeelings = "Feelings";
  static const String categoryMind = "Mind";
  static const String categorySexualLife = "Sexual Life";
  static const String categoryEnergy = "Energy";
  static const String categoryPeriod = "Menstrual flow";
  static const String categorySymptoms = "Symptoms";
  static const String categoryPain = "Pain";
  static const String categoryVaginalDischarge = "Vaginal discharge";
  static const String categoryDigestion = "Digestion";
  static const String categoryActivity = "Activity";
  static const String categoryCravings = "Cravings";
  static const String categoryTests = "Tests";
  static const String categoryAilments = "Ailments";
  static const String categoryAppointments = "Appointments";
  static const String categoryBirthControlPill = "Birth control pill";
  static const String categoryIUD = "IUD";
  static const String categorySupplements = "Supplements";
  static const String categoryUrine = "Urine";
  static const String categoryOther = "Other";
  static const String graphMeditationTitle = "Meditation time";
  static const String graphMeditationDate = "Meditation date";
  static const String graphMeditationMin = "in minutes";
  static const String graphMeditationMinTitle = "min";
  static const String graphWaterUnitCup = "Cups";
  static const String graphWaterUnitFlOz = "flOz";
  static const String graphWaterUnitImperialGallons = "Imperial Gallons";
  static const String graphWaterUnitUSGallon = "US Gallon";
  static const String graphWaterUnitMl = "ml";
  static const String graphWeightKg = "kg";
  static const String graphWeighLb = "lb";
  static const String logPeriodBedtime = "Bedtime";
  static const String logPeriodWakeUpTime = "Wake-up time";
  static const String logPeriodWakeUpTimeLog = "Log your wake-up time";
  static const String logPeriodBedTimeLog = " Log your bedtime";

  static const String symptomsNameLight = "Light";
  static const String symptomsNameMedium = "Medium";
  static const String symptomsNameHeavy = "Heavy";
  static const String symptomsNameSuperHeavy = "Super heavy";
  static const String symptomsNameDontKnow = "Don't know";
  static const String symptomsNameExhausted = "Exhausted";
  static const String symptomsNameTired = "Tired";
  static const String symptomsNameOK = "OK";
  static const String symptomsNameEnergetic = "Energetic";
  static const String symptomsNameFullyEnergized = "Fully energized";
  static const String symptomsNameSensitive = "Sensitive";
  static const String symptomsNameNotInControl = "Not in control";
  static const String symptomsNameHappy = "Happy";
  static const String symptomsNameFrisky = "Frisky";
  static const String symptomsNameMoodSwings = "Mood swings";
  static const String symptomsNameIrritated = "Irritated";
  static const String symptomsNameSad = "Sad";
  static const String symptomsNameTension = "Tension";
  static const String symptomsNameAngry = "Angry";
  static const String symptomsNameConfident = "Confident";
  static const String symptomsNameInsecure = "Insecure";
  static const String symptomsNameGrateful = "Grateful";
  static const String symptomsNameAnxiety = "Anxiety";
  static const String symptomsNameExcited = "Excited";
  static const String symptomsNameCalm = "Calm";
  static const String symptomsNameDistracted = "Distracted";
  static const String symptomsNameFocused = "Focused";
  static const String symptomsNameDepressed = "Depressed";
  static const String symptomsNameConfused = "Confused";
  static const String symptomsNameStressed = "Stressed";
  static const String symptomsNameMotivated = "Motivated";
  static const String symptomsNameUnmotivated = "Unmotivated";
  static const String symptomsNameCreative = "Creative";
  static const String symptomsNameProductive = "Productive";
  static const String symptomsNameUnproductive = "Unproductive";
  static const String symptomsNameNoSex = "No sex";
  static const String symptomsNameProtectedSex = "Protected sex";
  static const String symptomsNameUnprotectedSex = "Unprotected sex";
  static const String symptomsNameOralSex = "Oral sex";
  static const String symptomsNameAnalSex = "Anal sex";
  static const String symptomsNameMasturbation = "Masturbation";
  static const String symptomsNameHighSexDrive = "High sex drive";
  static const String symptomsNameNeutralSexDrive = "Neutral sex drive";
  static const String symptomsNameLowSexDrive = "Low sex drive";
  static const String symptomsNameSexToys = "Sex toys";
  static const String symptomsNameOrgasm = "Orgasm";
  static const String symptomsNameNoOrgasm = "No orgasm";
  static const String symptomsNameEverythingWell = "Everything well";
  static const String symptomsNameCramps = "Cramps";
  static const String symptomsNameTenderBreasts = "Tender breasts";
  static const String symptomsNameHeadache = "Headache";
  static const String symptomsNameAcne = "Acne";
  static const String symptomsNameBackache = "Backache";
  static const String symptomsNameAbdominalPain = "Abdominal pain";
  static const String symptomsNameFatigue = "Fatigue";
  static const String symptomsNamePainFree = "Pain free";
  static const String symptomsNamePeriodCramps = "Period cramps";
  static const String symptomsNameOvulation = "Ovulation";
  static const String symptomsNameBreastTenderness = "Breast tenderness";
  static const String symptomsNameMigraine = "Migraine";
  static const String symptomsNameMigraineWithAura = "Migraine with aura";
  static const String symptomsNameLowerBack = "Lower back";
  static const String symptomsNameLeg = "Leg";
  static const String symptomsNameJoint = "Joint";
  static const String symptomsNameNoDischarge = "No discharge";
  static const String symptomsNameLightDischarge = "Light discharge";
  static const String symptomsNameCreamy = "Creamy";
  static const String symptomsNameWatery = "Watery";
  static const String symptomsNameUnusual = "Unusual";
  static const String symptomsNameSpotting = "Spotting";
  static const String symptomsNameSticky = "Sticky";
  static const String symptomsNameEggWhite = "Egg white";
  static const String symptomsNameGray = "Gray";
  static const String symptomsNameGassy = "Gassy";
  static const String symptomsNameBloating = "Bloating";
  static const String symptomsNameHeartburn = "Heartburn";
  static const String symptomsNameNauseous = "Nauseous";
  static const String symptomsNameVomiting = "Vomiting";
  static const String symptomsNameYoga = "Yoga";
  static const String symptomsNameRunning = "Running";
  static const String symptomsNameGym = "Gym";
  static const String symptomsNameSwimming = "Swimming";
  static const String symptomsNameCycling = "Cycling";
  static const String symptomsNameWalking = "Walking";
  static const String symptomsNamePilates = "Pilates";
  static const String symptomsNameStrengthTraining = "Strength training";
  static const String symptomsNameStretching = "Stretching";
  static const String symptomsNameRestDay = "Rest day";
  static const String symptomsNameMeditation = "Meditation";
  static const String symptomsNameSweet = "Sweet";
  static const String symptomsNameSalty = "Salty";
  static const String symptomsNameGreasy = "Greasy";
  static const String symptomsNameSpicy = "Spicy";
  static const String symptomsNameCarbs = "Carbs";
  static const String symptomsNameDontTakeTest = "Don't take test";
  static const String symptomsNameNegative = "Negative";
  static const String symptomsNamePositive = "Positive";
  static const String symptomsNameColdOrFlu = "Cold or flu";
  static const String symptomsNameAllergy = "Allergy";
  static const String symptomsNameFever = "Fever";
  static const String symptomsNameUTI = "UTI";
  static const String symptomsNameSTI = "STI";
  static const String symptomsNameGYN = "GYN";
  static const String symptomsNamePAPSmear = "PAP smear";
  static const String symptomsNameSTICheckUp = "STI check-up";
  static const String symptomsNameGeneralCheckUp = "General check-up";
  static const String symptomsNameVaccination = "Vaccination";
  static const String symptomsNameTaken = "Taken";
  static const String symptomsNameMissed = "Missed";
  static const String symptomsNameLate = "Late";
  static const String symptomsNameDoubleDose = "Double dose";
  static const String symptomsNameVaccinationDuplicate = "Vaccination";
  static const String symptomsNameThreadChecked = "Thread checked";
  static const String symptomsNameInserted = "Inserted";
  static const String symptomsNameRemoved = "Removed";
  static const String symptomsNameMultivitamin = "Multivitamin";
  static const String symptomsNameMagnesium = "Magnesium";
  static const String symptomsNameIron = "Iron";
  static const String symptomsNameVitaminD = "Vitamin D";
  static const String symptomsNameCalcium = "Calcium";
  static const String symptomsNameFolicAcid = "Folic acid";
  static const String symptomsNamePrenatalVitamins = "Prenatal vitamins";
  static const String symptomsNameFrequentUrination = "Frequent urination";
  static const String symptomsNameBurningSensation = "Burning sensation";
  static const String symptomsNameLeaksOrDribbles = "Leaks or dribbles";
  static const String symptomsNameTravel = "Travel";
  static const String symptomsNameStress = "Stress";
  static const String symptomsNameAlcohol = "Alcohol";
  static const String symptomsNameJournaling = "Journaling";*/

  /*static const String weekTitlesSun = "Sun";
  static const String weekTitlesMon = "Mon";
  static const String weekTitlesTue = "Tue";
  static const String weekTitlesWed = "Wed";
  static const String weekTitlesThu = "Thu";
  static const String weekTitlesFri = "Fri";
  static const String weekTitlesSat = "Sat";*/

  /*static const String cycleDayTitle = "Cycle Day";
  static const String feelingTodayTitle = "What are you feeling today?";
  static const String todayTitle = "Today";
  static const String yesterdayTitle = "Yesterday";
  static const String protectedData = "Your data is protected";
  static const String regularTitle = "Regular";
  static const String normalTitle = "Normal";*/
//  static const String irregularTitle = "Irregular";
}
