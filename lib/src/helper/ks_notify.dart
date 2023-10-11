import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kurd_store/src/helper/ks_helper.dart';

class KSNotify {
  static Future snedNotificatoinToTopic(
      String titleText, String bodyText, String topic) async {
    var url = Uri.https('fcm.googleapis.com', 'fcm/send');

    var hedders = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAdCHEWq8:APA91bGp9dQOzyMriu3rtB-J6-EC49Y6SxFWWZdMf1Fd75zJbypEIIdHJeeWM0_l2rst0ieLEpOJuC0HTHF6wvHUae9XA0YMEZaqQCDmL6iVRDdJ87c_uT2HVmVVcdAqP8oFtArZPvVp",
    };

    var body = {
      "to": "/topics/$topic",
      "notification": {
        "title": titleText,
        "body": bodyText,
        'sound': 'default',
      },
      "data": {"open_page": "cart_screen"}
    };

    var response = await http.post(
      url,
      headers: hedders,
      body: jsonEncode(body),
    );
    print(response.body);

    if (response.statusCode == 200) {
      print("Notification sent");
      KSHelper.showSnackBar("Notification sent");
    } else {
      print("Notification not sent");
      KSHelper.showSnackBar("Notification not sent");
    }
  }

  static Future snedNotificatoinToUser(
      String titleText, String bodyText, String token) async {
    var url = Uri.https('fcm.googleapis.com', 'fcm/send');

    var hedders = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAdCHEWq8:APA91bGp9dQOzyMriu3rtB-J6-EC49Y6SxFWWZdMf1Fd75zJbypEIIdHJeeWM0_l2rst0ieLEpOJuC0HTHF6wvHUae9XA0YMEZaqQCDmL6iVRDdJ87c_uT2HVmVVcdAqP8oFtArZPvVp",
    };

    var body = {
      "to": token,
      "notification": {
        "title": titleText,
        "body": bodyText,
        'sound': 'default',
      },
      "data": {"open_page": "cart_screen"}
    };

    var response = await http.post(
      url,
      headers: hedders,
      body: jsonEncode(body),
    );
    print(response.body);

    if (response.statusCode == 200) {
      print("Notification sent");
      KSHelper.showSnackBar("Notification sent");
    } else {
      print("Notification not sent");
      KSHelper.showSnackBar("Notification not sent");
    }
  }
}
