import 'dart:io';

import 'package:app/constants/app_constants.dart';
import 'package:app/services/local_notifications.dart';
import 'package:app/widgets/change_language.dart';
import 'package:app/widgets/change_theme.dart';
import 'package:app/widgets/clear_app_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alerts_page.dart';
import 'my_places.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Languages _language = Languages.english;
  bool _smartNotification = false;
  bool _pushNotification = false;
  bool _dailyReports = false;
  bool _weeklyReports = false;
  bool _monthlyReports = false;
  bool _morningForecast = false;
  bool _eveningForecast = false;
  Themes _theme = Themes.lightTheme;
  final LocalNotifications _notifications = LocalNotifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: ColorConstants.appColor),
          title: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.appBarTitleColor,
            ),
          ),
        ),
        body: Container(
            color: ColorConstants.appBodyColor,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    // physics:  const BouncingScrollPhysics(
                    //     parent: AlwaysScrollableScrollPhysics()
                    // ),
                    children: <Widget>[
                      userPreferences(),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        color: ColorConstants.appColor,
                      ),
                      supportSection(),
                      footerSection()
                    ],
                  ),
                ),
              ],
            )));
  }

  @Deprecated('Old view')
  Widget buildSettings(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              // physics:  const BouncingScrollPhysics(
              //     parent: AlwaysScrollableScrollPhysics()
              // ),
              children: <Widget>[
                userPreferences(),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: ColorConstants.appColor,
                ),
                notifications(),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: ColorConstants.appColor,
                ),
                reports(),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: ColorConstants.appColor,
                ),
                support(),
                footer()
              ],
            ),
          ),
          // footer()
        ],
      )),
    );
  }

  void cancelNotification(int id) {
    _notifications.cancelNotifications(id);
  }

  EdgeInsets containerPadding() {
    return const EdgeInsets.fromLTRB(10, 10, 10, 0);
  }

  Widget footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.white.withOpacity(0.5),
            ColorConstants.appColor,
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _launchURL('airqo');
            },
            child: Image.asset(
              'assets/icon/airqo_logo.png',
              height: 50,
              width: 50,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: ColorConstants.facebookColor,
                  ),
                  onPressed: () {
                    _launchURL('facebook');
                  }),
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.twitter,
                    color: ColorConstants.twitterColor,
                  ),
                  onPressed: () {
                    _launchURL('twitter');
                  }),
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.youtube,
                    color: ColorConstants.youtubeColor,
                  ),
                  onPressed: () {
                    _launchURL('youtube');
                  }),
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    color: ColorConstants.linkedInColor,
                  ),
                  onPressed: () {
                    _launchURL('linkedin');
                  }),
            ],
          ),
          const Text(
            'v1.21.7',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget footerSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _launchURL('airqo');
            },
            child: Image.asset(
              'assets/icon/airqo_logo_tagline_transparent.png',
              height: 100,
              width: 100,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.facebook,
                    size: 30,
                    color: ColorConstants.facebookColor,
                  ),
                  onPressed: () {
                    _launchURL('facebook');
                  }),
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.twitter,
                    size: 30,
                    color: ColorConstants.twitterColor,
                  ),
                  onPressed: () {
                    _launchURL('twitter');
                  }),
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.youtube,
                    size: 30,
                    color: ColorConstants.youtubeColor,
                  ),
                  onPressed: () {
                    _launchURL('youtube');
                  }),
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    size: 30,
                    color: ColorConstants.linkedInColor,
                  ),
                  onPressed: () {
                    _launchURL('linkedin');
                  }),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '\u00a9 ${AppConfig.name} ${DateTime.now().year}',
            style: TextStyle(color: ColorConstants.appColor),
          ),
          Text(
            'Air Quality Initiative',
            style: TextStyle(color: ColorConstants.appColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${AppConfig.version}',
            style: TextStyle(color: ColorConstants.appColor),
          )
        ],
      ),
    );
  }

  TextStyle headerStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
    _notifications.initNotifications();
  }

  Future<void> loadPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString(PrefConstant.appTheme);
    print(theme);
    if (theme != null) {
      switch (theme) {
        case 'light':
          _theme = Themes.lightTheme;
          break;
        case 'dark':
          _theme = Themes.darkTheme;
          break;
        default:
          _theme = Themes.lightTheme;
          break;
      }
    }

    _language = Languages.english;
  }

  Widget notifications() {
    return Container(
      padding: containerPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Notifications',
            style: headerStyle(),
          ),
          ListTile(
            title: const Text('Smart Notifications'),
            subtitle: const Text('Receive air pollution alerts and '
                'recommendations for your saved places'),
            trailing: Switch(
              value: _smartNotification,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                if (value) {
                  showNotification(NotificationConfig.smartNotificationId);
                } else {
                  cancelNotification(NotificationConfig.smartNotificationId);
                }

                setState(() {
                  _smartNotification = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Get notifications about new features and '
                'blog posts from the AirQo team'),
            trailing: Switch(
              value: _pushNotification,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                if (value) {
                  showNotification(NotificationConfig.pushNotificationId);
                } else {
                  cancelNotification(NotificationConfig.pushNotificationId);
                }

                setState(() {
                  _pushNotification = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget preferencesWidget() {
    return Container(
      padding: containerPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'User Preferences',
            style: headerStyle(),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyPlaces();
              }));
            },
            child: ListTile(
              title: const Text('Manage My Places'),
              leading: Icon(
                Icons.favorite_outlined,
                color: ColorConstants.appColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeThemeDialog(
                      onValueChange: _onThemeValueChange,
                      initialValue: _theme,
                    );
                  });
            },
            child: ListTile(
              title: const Text('Appearance'),
              leading: FaIcon(
                FontAwesomeIcons.paintRoller,
                color: ColorConstants.appColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeLanguageDialog(
                      onValueChange: _onLanguageValueChange,
                      initialValue: _language,
                    );
                  });
            },
            child: ListTile(
              title: const Text('Language'),
              leading: FaIcon(
                FontAwesomeIcons.language,
                color: ColorConstants.appColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          // const ListTile(
          //   title: Text('System Permissions'),
          // ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ClearAppDialog();
                  });
            },
            child: ListTile(
              title: const Text('Clear All Data'),
              leading: Icon(
                Icons.delete,
                color: ColorConstants.appColor,
              ),
              subtitle: const Text('Clear all saved data including saved '
                  'places and preferences'),
            ),
          ),
        ],
      ),
    );
  }

  void pushNotification() {
    _notifications.showOngoingNotification();
  }

  Widget reports() {
    return Container(
      padding: containerPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Reports',
            style: headerStyle(),
          ),
          ListTile(
            title: const Text('Daily'),
            trailing: Switch(
              value: _dailyReports,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                setState(() {
                  _dailyReports = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Weekly'),
            trailing: Switch(
              value: _weeklyReports,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                setState(() {
                  _weeklyReports = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Monthly'),
            trailing: Switch(
              value: _monthlyReports,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                setState(() {
                  _monthlyReports = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Today\'s Forecast'),
            subtitle: const Text('The day\'s forecast received at 6AM'),
            trailing: Switch(
              value: _morningForecast,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                setState(() {
                  _morningForecast = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Tomorrow\'s Forecast'),
            subtitle: const Text('Tomorrow\'s forecast received at 8PM'),
            trailing: Switch(
              value: _eveningForecast,
              activeColor: ColorConstants.appColor,
              activeTrackColor: ColorConstants.appColor.withOpacity(0.6),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                setState(() {
                  _eveningForecast = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void showNotification(int id) {
    switch (id) {
      case NotificationConfig.persistentNotificationId:
        _notifications.showOngoingNotification();
        return;
      case NotificationConfig.progressNotificationId:
        _notifications.showProgressNotification();
        return;
      case NotificationConfig.smartNotificationId:
        _notifications.showSmartNotification();
        return;
      case NotificationConfig.pushNotificationId:
        _notifications.showPushNotification();
        return;
      default:
        return;
    }
  }

  Widget support() {
    return Container(
      padding: containerPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Support',
            style: headerStyle(),
          ),
          InkWell(
            onTap: () {
              _launchURL('faqs');
            },
            child: ListTile(
              title: const Text('FAQs'),
              leading: Icon(
                Icons.help_outline_outlined,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('Contact Us');
            },
            child: ListTile(
              title: const Text('Contact Us'),
              leading: Icon(
                Icons.contact_support_outlined,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('terms');
            },
            child: ListTile(
              title: const Text('Terms of Use & Privacy Policy'),
              leading: Icon(
                Icons.description,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('About');
            },
            child: ListTile(
              title: const Text('About AirQo'),
              leading: Icon(
                Icons.info_outline_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('rate');
            },
            child: ListTile(
              title: const Text('Rate App'),
              leading: Icon(
                Icons.rate_review_outlined,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchEmail('feedback');
            },
            child: ListTile(
              title: const Text('Feedback'),
              leading: Icon(
                Icons.feedback_outlined,
                color: ColorConstants.appColor,
              ),
              subtitle: const Text('Tell us which functionality is most '
                  'important to you and what you would like '
                  'to be improved in the app'),
            ),
          ),
        ],
      ),
    );
  }

  Widget supportSection() {
    return Container(
      padding: containerPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   'Support',
          //   style: headerStyle(),
          // ),
          InkWell(
            onTap: () {
              _launchURL('faqs');
            },
            child: ListTile(
              title: Text(
                'FAQs',
                style: TextStyle(color: ColorConstants.appColor),
              ),
              leading: Icon(
                Icons.help_outline_outlined,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('Contact Us');
            },
            child: ListTile(
              title: Text(
                'Contact Us',
                style: TextStyle(color: ColorConstants.appColor),
              ),
              leading: Icon(
                Icons.contact_support_outlined,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('terms');
            },
            child: ListTile(
              title: Text(
                'Terms of Use & Privacy Policy',
                style: TextStyle(color: ColorConstants.appColor),
              ),
              leading: Icon(
                Icons.description,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURL('About');
            },
            child: ListTile(
              title: Text(
                'About ${AppConfig.name}',
                style: TextStyle(color: ColorConstants.appColor),
              ),
              leading: Icon(
                Icons.info_outline_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     _launchURL('rate');
          //   },
          //   child: ListTile(
          //     title: Text(
          //       'Rate App',
          //       style: TextStyle(color: ColorConstants.appColor),
          //     ),
          //     leading: Icon(
          //       Icons.rate_review_outlined,
          //       color: ColorConstants.appColor,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget userPreferences() {
    return Container(
      padding: containerPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   'Preferences',
          //   style: headerStyle(),
          // ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyPlaces();
              }));
            },
            child: ListTile(
              title: const Text('My Places'),
              leading: FaIcon(
                FontAwesomeIcons.solidHeart,
                color: ColorConstants.red,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AlertPage();
              }));
            },
            child: ListTile(
              title: const Text('Alerts'),
              leading: FaIcon(
                FontAwesomeIcons.bell,
                color: ColorConstants.appColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorConstants.appColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String action) async {
    action = action.trim().toLowerCase();

    switch (action) {
      case 'feedback':
        final _emailFeedbackUri = Uri(
                scheme: 'mailto',
                path: '${Links.airqoFeedbackEmail}',
                queryParameters: {'subject': 'Mobile\bApplication\bFeedback!'})
            .toString();

        try {
          await canLaunch(_emailFeedbackUri)
              ? await launch(_emailFeedbackUri)
              : throw Exception(
                  'Could not launch faqs, try opening $_emailFeedbackUri');
        } catch (e) {
          print(e);
        }
        return;
      default:
        return;
    }
  }

  Future<void> _launchURL(String page) async {
    page = page.trim().toLowerCase();

    try {
      switch (page) {
        case 'faqs':
          await canLaunch(Links.faqsUrl)
              ? await launch(Links.faqsUrl)
              : throw Exception(
                  'Could not launch faqs, try opening ${Links.faqsUrl}');
          return;
        case 'about':
          await canLaunch(Links.aboutUsUrl)
              ? await launch(Links.aboutUsUrl)
              : throw Exception(
                  'Could not launch about, try opening ${Links.aboutUsUrl}');
          return;
        case 'contact us':
          await canLaunch(Links.contactUsUrl)
              ? await launch(Links.contactUsUrl)
              : throw Exception(
                  'Could not launch contact us, try opening ${Links.contactUsUrl}');
          return;
        case 'terms':
          await canLaunch(Links.termsUrl)
              ? await launch(Links.termsUrl)
              : throw Exception(
                  'Could not launch terms, try opening ${Links.termsUrl}');
          return;
        case 'rate':
          if (Platform.isAndroid) {
            await canLaunch(Links.playStoreUrl)
                ? await launch(Links.playStoreUrl)
                : throw Exception('Could not launch rate us, try opening'
                    ' ${Links.playStoreUrl}');
          } else if (Platform.isIOS) {
            await canLaunch(Links.iOSUrl)
                ? await launch(Links.iOSUrl)
                : throw Exception(
                    'Could not launch rate us, try opening ${Links.iOSUrl}');
          } else {
            await canLaunch(Links.playStoreUrl)
                ? await launch(Links.playStoreUrl)
                : throw Exception('Could not launch rate us, try opening'
                    ' ${Links.playStoreUrl}');
          }
          return;
        case 'facebook':
          await canLaunch(Links.facebookUrl)
              ? await launch(Links.facebookUrl)
              : throw Exception(
                  'Could not launch facebook, try opening ${Links.facebookUrl}');
          return;
        case 'twitter':
          await canLaunch(Links.twitterUrl)
              ? await launch(Links.twitterUrl)
              : throw Exception(
                  'Could not launch twitter, try opening ${Links.twitterUrl}');
          return;
        case 'linkedin':
          await canLaunch(Links.linkedinUrl)
              ? await launch(Links.linkedinUrl)
              : throw Exception(
                  'Could not launch linkedin, try opening ${Links.linkedinUrl}');
          return;
        case 'youtube':
          await canLaunch(Links.youtubeUrl)
              ? await launch(Links.youtubeUrl)
              : throw Exception(
                  'Could not launch youtube, try opening ${Links.youtubeUrl}');
          return;
        case 'airqo':
          await canLaunch(Links.websiteUrl)
              ? await launch(Links.websiteUrl)
              : throw Exception(
                  'Could not launch airqo, try opening ${Links.websiteUrl}');
          return;
        default:
          await canLaunch(Links.websiteUrl)
              ? await launch(Links.websiteUrl)
              : throw Exception(
                  'Could not launch airqo, try opening ${Links.websiteUrl}');
          return;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onLanguageValueChange(Languages value) async {
    setState(() {
      _language = value;
    });
  }

  Future<void> _onThemeValueChange(Themes value) async {
    setState(() {
      _theme = value;
    });

    var prefs = await SharedPreferences.getInstance();

    if (value == Themes.lightTheme) {
      await prefs.setString(PrefConstant.appTheme, 'light');
    } else {
      await prefs.setString(PrefConstant.appTheme, 'dark');
    }
  }
}