// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  // ignore: non_constant_identifier_names
  var weatherForecastDescription = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];
  var weatherForecastTemp = [
    0.0,
    1.0,
    2.0,
    3.0,
    4.0,
  ];
  var weatherForecastHumidity = [
    0,
    1,
    2,
    3,
    4,
  ];
  var weatherForecastPressure = [
    0,
    1,
    2,
    3,
    4,
  ];
  var forecastDateTime = [
    '',
    '',
    '',
    '',
    '',
  ];
  var forecastIcon = [
    '01d',
    '01d',
    '01d',
    '01d',
    '01d',
  ];
  var i = 0;
  var cityNameRequest = 'Cebu';
  var icons = '01d';
  var cityName;
  var weatherDescription;
  var weatherTemp;
  var weatherHumidity;
  var weatherPressure;
  var weatherLat;
  var weatherLon;
  var Error;
  int r = 0;
  int g = 0;
  int b = 255;
  double o = 0.5;

  @override
  void initState() {
    super.initState();
    getWeather();
    getWeatherForecast();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter city",
              errorText: Error,
              fillColor: Color.fromRGBO(r, g, b, o),
              filled: true,
            ),
            onSubmitted: (value) {
              cityNameRequest = value;
              getWeather();
              getWeatherForecast();
            },
            textInputAction: TextInputAction.send,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      cityName.toString().toUpperCase(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.deepPurpleAccent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2))
                            ]),
                        child: Image.network(
                          'http://openweathermap.org/img/wn/$icons@2x.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Icon(
                            WeatherIcons.cloud,
                            size: 32,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(height: 15, width: 15),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text("Weather                     "),
                              Text(
                                weatherDescription.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Icon(
                            WeatherIcons.thermometer,
                            size: 32,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(height: 15, width: 15),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text("Temperature        "),
                              Text(
                                weatherTemp.toString() + "°C         ",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Icon(
                            WeatherIcons.humidity,
                            size: 32,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(height: 15, width: 15),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text("Humidity       "),
                              Text(
                                weatherHumidity.toString() + "%          ",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 50),
                          Icon(
                            WeatherIcons.wind_deg_0,
                            size: 32,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(height: 15, width: 15),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text("Pressure      "),
                              Text(
                                weatherPressure.toString() + " hPa",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            CupertinoIcons.location,
                            size: 32,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(height: 15, width: 15),
                          Column(
                            children: [
                              Text("Longitude"),
                              Text(
                                weatherLon.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            CupertinoIcons.location,
                            size: 32,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(height: 15, width: 15),
                          Column(
                            children: [
                              Text("Latitude      "),
                              Text(
                                weatherLat.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 450,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      height: 100,
                      width: 400,
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(children: [
                        SizedBox(height: 10),
                        Image.network(
                          'http://openweathermap.org/img/wn/${forecastIcon[0]}@2x.png',
                        ),
                        Text(
                          weatherForecastDescription[0]
                              .toString()
                              .toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.clock,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 50, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 0)),
                                Text("Date and Time           "),
                                Text(
                                  forecastDateTime[0].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.thermometer,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Temperature        "),
                                Text(
                                  weatherForecastTemp[0].toString() +
                                      "°C                ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.humidity,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Humidity "),
                                Text(
                                  weatherForecastHumidity[0].toString() +
                                      "%          ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.wind_deg_0,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Pressure "),
                                Text(
                                  weatherForecastPressure[0].toString() +
                                      " hPa",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),

                    //2nd Image of Slider
                    Container(
                      height: 100,
                      width: 400,
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(children: [
                        SizedBox(height: 10),
                        Image.network(
                          'http://openweathermap.org/img/wn/${forecastIcon[1]}@2x.png',
                        ),
                        Text(
                          weatherForecastDescription[1]
                              .toString()
                              .toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.clock,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 50, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 0)),
                                Text("Date and Time           "),
                                Text(
                                  forecastDateTime[1].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.thermometer,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Temperature        "),
                                Text(
                                  weatherForecastTemp[1].toString() +
                                      "°C                ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.humidity,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Humidity "),
                                Text(
                                  weatherForecastHumidity[1].toString() +
                                      "%          ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.wind_deg_0,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Pressure "),
                                Text(
                                  weatherForecastPressure[1].toString() +
                                      " hPa",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),

                    //3rd Image of Slider
                    Container(
                      height: 100,
                      width: 400,
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(children: [
                        SizedBox(height: 10),
                        Image.network(
                          'http://openweathermap.org/img/wn/${forecastIcon[2]}@2x.png',
                        ),
                        Text(
                          weatherForecastDescription[2]
                              .toString()
                              .toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.clock,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 50, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 0)),
                                Text("Date and Time           "),
                                Text(
                                  forecastDateTime[2].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.thermometer,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Temperature        "),
                                Text(
                                  weatherForecastTemp[2].toString() +
                                      "°C                ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.humidity,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Humidity "),
                                Text(
                                  weatherForecastHumidity[2].toString() +
                                      "%          ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.wind_deg_0,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Pressure "),
                                Text(
                                  weatherForecastPressure[2].toString() +
                                      " hPa",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),

                    //4th Image of Slider
                    Container(
                      height: 100,
                      width: 400,
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(children: [
                        SizedBox(height: 10),
                        Image.network(
                          'http://openweathermap.org/img/wn/${forecastIcon[3]}@2x.png',
                        ),
                        Text(
                          weatherForecastDescription[3]
                              .toString()
                              .toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.clock,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 50, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 0)),
                                Text("Date and Time           "),
                                Text(
                                  forecastDateTime[3].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.thermometer,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Temperature        "),
                                Text(
                                  weatherForecastTemp[3].toString() +
                                      "°C                ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.humidity,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Humidity "),
                                Text(
                                  weatherForecastHumidity[3].toString() +
                                      "%          ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.wind_deg_0,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Pressure "),
                                Text(
                                  weatherForecastPressure[3].toString() +
                                      " hPa",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),

                    //5th Image of Slider
                    Container(
                      height: 100,
                      width: 400,
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(children: [
                        SizedBox(height: 10),
                        Image.network(
                          'http://openweathermap.org/img/wn/${forecastIcon[4]}@2x.png',
                        ),
                        Text(
                          weatherForecastDescription[4]
                              .toString()
                              .toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.clock,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 50, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 0)),
                                Text("Date and Time           "),
                                Text(
                                  forecastDateTime[4].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.thermometer,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Temperature        "),
                                Text(
                                  weatherForecastTemp[4].toString() +
                                      "°C                ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.humidity,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Humidity "),
                                Text(
                                  weatherForecastHumidity[4].toString() +
                                      "%          ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              WeatherIcons.wind_deg_0,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15, width: 15),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text("Pressure "),
                                Text(
                                  weatherForecastPressure[4].toString() +
                                      " hPa",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),
                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 400,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityNameRequest&appid=48d191651fc9cfceb346a5d544ae2108&units=metric"));
    var output = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        cityName = output['name'];
        weatherDescription = output['weather'][0]['description'];
        weatherTemp = output['main']['temp'];
        weatherHumidity = output['main']['humidity'];
        weatherPressure = output['main']['pressure'];
        weatherLat = output['coord']['lon'];
        weatherLon = output['coord']['lat'];
        icons = output['weather'][0]['icon'];
        r = 0;
        g = 0;
        b = 255;
        Error = null;
      });
    } else {
      setState(() {
        r = 255;
        g = 0;
        b = 0;
        Error = 'Location not found!';
      });
    }
  }

  Future getWeatherForecast() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityNameRequest&appid=48d191651fc9cfceb346a5d544ae2108&units=metric"));
    var output = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        for (int x = 5; x < 39; x += 8) {
          print(x);
          weatherForecastDescription[i] =
              output['list'][x]['weather'][0]['description'];
          weatherForecastTemp[i] = output['list'][x]['main']['temp'];
          weatherForecastHumidity[i] = output['list'][x]['main']['humidity'];
          weatherForecastPressure[i] = output['list'][x]['main']['pressure'];
          forecastIcon[i] = output['list'][x]['weather'][0]['icon'];
          forecastDateTime[i] = output['list'][x]['dt_txt'];
          if (i == 4) {
            i = 4;
          } else {
            i++;
          }
        }
      });
    } else {
      setState(() {
        r = 255;
        g = 0;
        b = 0;
        Error = 'Location not found!';
      });
    }
    i = 0;
  }
}
