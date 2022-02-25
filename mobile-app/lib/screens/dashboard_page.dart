import 'package:app/constants/app_constants.dart';
import 'package:app/models/historicalMeasurement.dart';
import 'package:app/models/measurement.dart';
import 'package:app/models/predict.dart';
import 'package:app/models/site.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/native_api.dart';
import 'package:app/services/rest_api.dart';
import 'package:app/utils/date.dart';
import 'package:app/utils/settings.dart';
import 'package:app/widgets/current_location_readings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var measurementData;
  var historicalData = <HistoricalMeasurement>[];
  var forecastData = <Predict>[];

  @override
  Widget build(BuildContext context) {
    if (measurementData == null) {
      return Container(
          color: ColorConstants.appBodyColor,
          child: Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appColor,
            ),
          ));
    } else {
      return Container(
          color: ColorConstants.appBodyColor,
          child: RefreshIndicator(
              onRefresh: _getLatestMeasurements,
              color: ColorConstants.appColor,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            child: Text(
                              getGreetings(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          CurrentLocationCard(
                              measurementData: measurementData,
                              historicalData: historicalData,
                              forecastData: forecastData),
                        ],
                      ),
                    ),
                  ],
                ),
              )));
    }
  }

  void getLocationForecastMeasurements(Measurement measurement) async {
    try {
      await DBHelper()
          .getForecastMeasurements(measurement.site.id)
          .then((value) => {
                if (value.isNotEmpty)
                  {
                    if (mounted)
                      {
                        setState(() {
                          forecastData = value;
                        })
                      }
                  }
              });
    } on Error catch (e) {
      print('Getting forecast data locally error: $e');
    } finally {
      try {
        await AirqoApiClient(context)
            .fetchForecast(measurement.deviceNumber)
            .then((value) => {
                  if (value.isNotEmpty)
                    {
                      if (mounted)
                        {
                          setState(() {
                            forecastData = value;
                          }),
                        },
                      DBHelper().insertForecastMeasurements(
                          value, measurement.site.id)
                    },
                });
      } catch (e) {
        print('Getting forecast data from api error: $e');
      }
    }
  }

  void getLocationHistoricalMeasurements(Site site) async {
    try {
      await DBHelper().getHistoricalMeasurements(site.id).then((value) => {
            if (value.isNotEmpty)
              {
                if (mounted)
                  {
                    setState(() {
                      historicalData = value;
                    })
                  }
              }
          });
    } catch (e) {
      print('Historical data is currently not available.');
    } finally {
      try {
        await AirqoApiClient(context)
            .fetchSiteHistoricalMeasurements(site)
            .then((value) => {
                  if (value.isNotEmpty)
                    {
                      if (mounted)
                        {
                          setState(() {
                            historicalData = value;
                          }),
                        },
                      DBHelper()
                          .insertSiteHistoricalMeasurements(value, site.id)
                    }
                });
      } catch (e) {
        print('Historical data is currently not available.');
      }
    }

    try {
      await AirqoApiClient(context)
          .fetchSiteHistoricalMeasurements(site)
          .then((value) => {
                if (value.isNotEmpty)
                  {
                    if (mounted)
                      {
                        setState(() {
                          historicalData = value;
                        }),
                      },
                  }
              });
    } catch (e) {
      print('Historical data is currently not available.');
    }
  }

  Future<void> getLocationMeasurements() async {
    try {
      await Settings().dashboardMeasurement().then((value) => {
            if (value != null)
              {
                if (mounted)
                  {
                    setState(() {
                      measurementData = value;
                    }),
                    getLocationHistoricalMeasurements(value.site),
                    getLocationForecastMeasurements(value),
                    updateCurrentLocation()
                  },
              }
            else
              {}
          });
    } catch (e) {
      print('error getting data : $e');
    }
  }

  Future<void> initialize() async {
    await getLocationMeasurements();
    await _getLatestMeasurements();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void updateCurrentLocation() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var dashboardSite = prefs.getString(PrefConstant.dashboardSite) ?? '';

      if (dashboardSite == '') {
        await LocationApi().getCurrentLocationReadings().then((value) => {
              if (value != null)
                {
                  prefs.setStringList(PrefConstant.lastKnownLocation,
                      ['${value.site.getUserLocation()}', '${value.site.id}']),
                  if (mounted)
                    {
                      setState(() {
                        measurementData = value;
                      }),
                      getLocationHistoricalMeasurements(value.site),
                      getLocationForecastMeasurements(value),
                    }
                },
            });
      }
    } catch (e) {}
  }

  Future<void> updateLocationMeasurements() async {
    var prefs = await SharedPreferences.getInstance();
    var dashboardMeasurement =
        prefs.getString(PrefConstant.dashboardSite) ?? '';
    if (dashboardMeasurement != '') {}
    try {
      await Settings().dashboardMeasurement().then((value) => {
            if (value != null)
              {
                if (mounted)
                  {
                    setState(() {
                      measurementData = value;
                    }),
                    getLocationHistoricalMeasurements(value.site),
                    getLocationForecastMeasurements(value),
                  },
              }
          });
    } catch (e) {
      print('error getting data');
    }
  }

  Future<void> _getLatestMeasurements() async {
    await AirqoApiClient(context).fetchLatestMeasurements().then((value) => {
          if (value.isNotEmpty)
            {
              DBHelper()
                  .insertLatestMeasurements(value)
                  .then((value) => {getLocationMeasurements()})
            }
        });
  }
}