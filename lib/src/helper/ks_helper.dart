import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:uuid/uuid.dart';

class KSHelper {
  static Future<File?> pickImageFromGallery({bool cropTheImage = false}) async {
    File? myImageFile;

    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? imageXFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageXFile != null) {
      myImageFile = File(imageXFile.path);

      if (cropTheImage) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: myImageFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.png,
          maxHeight: 1080,
          maxWidth: 1080,
          compressQuality: 50,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioLockEnabled: true,
              aspectRatioLockDimensionSwapEnabled: false,
              aspectRatioPickerButtonHidden: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        );
        if (croppedFile != null) {
          myImageFile = File(croppedFile.path);
        }
      }
    } else {
      myImageFile = null;
    }

    return myImageFile;
  }

  static showSnackBar(text) {
    Get.showSnackbar(
      GetSnackBar(
        message: text,
        messageText: Text(
          text,
          style: KSTextStyle.dark(14),
        ),
        snackPosition: SnackPosition.TOP,
        borderRadius: 13,
        duration: 2.seconds,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
        boxShadows: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black38,
            offset: Offset(
              1,
              3,
            ),
          ),
        ],
      ),
    );
  }

  static Future<String?> uploadMedia(
    File myImageFile,
    String imagePath,
  ) async {
    var ref = FirebaseStorage.instance.ref().child(imagePath);

    var uploadFileName = "${const Uuid().v4()}.png";
    ref = ref.child(uploadFileName);

    try {
      await ref.putFile(myImageFile);
    } on FirebaseException catch (e) {
      print(e.message.toString());

      KSHelper.showSnackBar("Error while uploading the image");

      return null;
    }

    var downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }

  static String formatNumber(number, {String postfix = ""}) {
    if (number == null) {
      return "";
    }

    if (number is int || number is double) {
      return NumberFormat("#,###").format(number) + postfix;
    }

    return number.toString() + postfix;
  }

  static Widget ksTextfield({
    String? hintText,
    IconData? icon,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool isEnabled = true,
    bool isMultiLine = false,
    bool isPassword = false,
    List<TextInputFormatter>? inputFormatters,
    Function(String text)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          onChanged: onChanged,
          obscureText: isPassword,
          maxLines: isMultiLine ? null : 1,
          maxLength: isMultiLine ? 255 : null,
          inputFormatters: inputFormatters,
          enabled: isEnabled,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  static List<String> iraqCities = [
    'Baghdad',
    'Mosul',
    'Basra',
    'Erbil',
    'Sulaymaniyah',
    'Kirkuk',
    'Najaf',
    'Karbala',
    'Ramadi',
    'Fallujah',
    'Tikrit',
    'Kut',
    'Diwaniyah',
    'Nasiriyah',
    'Amara',
    'Duhok',
    'Samawah',
    'Baqubah',
    'Hilla',
    'Kufa',
    'Hillah',
    'Halabja',
    'Zakho',
    'Sinjar',
    'Rania',
    'Rawah',
    'Haditha',
    'Al-Qa\'im',
    'Al-Rutbah',
    'Al-Qaim',
    'Al-Qadisiyah',
    'Al-Mahawil',
    'Al-Mada\'in',
    'Al-Kut',
    'Al-Hamdaniya',
    'Al-Fallujah',
    'Al-Diwaniyah',
    'Al-Dhuluiya',
    'Al-Basrah',
    'Al-Amarah',
    'Al-Anbar',
    'Al-Hilla',
    'Al-Khalis',
    'Al-Kifl',
    'Al-Mawsil',
    'Al-Musayyib',
    'Al-Najaf',
    'Al-Qurnah',
    'Al-Samawah',
    'Al-Sulaymaniyah',
    'Al-Taji',
    'Al-Talafar',
    'Al-Zubair',
    'An-Nasiriyah',
    'Ar-Ramadi',
    'As-Samawah',
    'Az Zubayr',
    'Badrah',
    'Balad',
    'Baquba',
    'Bayji',
    'Halabjah',
    'Hit',
    'Husaybah',
    'Karbala',
    'Khanaqin',
    'Kufah',
    'Kut',
    'Mahmudiyah',
    'Mandali',
    'Maysan',
    'Najaf',
    'Nasiriyah',
    'Nineveh',
    'Qal\'at Sukkar',
    'Qaraqosh',
    'Qayyarah',
    'Quds',
    'Ramadi',
    'Rawah',
    'Rawa',
    'Rumaythah',
    'Rutbah',
    'Samarra',
    'Sinjar',
    'Sulaimaniyah',
    'Tal Afar',
    'Tarmiyah',
    'Tikrit',
    'Umm Qasr',
    'Zakho',
  ];
  static Map<String, int> iraqCitiesPrice = {
    'Baghdad': 2000,
    'Mosul': 2000,
    'Basra': 2000,
    'Erbil': 2000,
    'Sulaymaniyah': 2000,
    'Kirkuk': 2000,
    'Najaf': 2000,
    'Karbala': 2000,
    'Ramadi': 2000,
    'Fallujah': 2000,
    'Tikrit': 2000,
    'Kut': 2000,
    'Diwaniyah': 2000,
    'Nasiriyah': 2000,
    'Amara': 2000,
    'Duhok': 5000,
    'Samawah': 2000,
    'Baqubah': 2000,
    'Hilla': 2000,
    'Kufa': 2000,
    'Hillah': 2000,
    'Halabja': 2000,
    'Zakho': 2000,
    'Sinjar': 2000,
    'Rania': 2000,
    'Rawah': 2000,
    'Haditha': 2000,
    'Al-Qa\'im': 2000,
    'Al-Rutbah': 2000,
    'Al-Qaim': 2000,
    'Al-Qadisiyah': 2000,
    'Al-Mahawil': 2000,
    'Al-Mada\'in': 2000,
    'Al-Kut': 2000,
    'Al-Hamdaniya': 2000,
    'Al-Fallujah': 2000,
    'Al-Diwaniyah': 2000,
    'Al-Dhuluiya': 2000,
    'Al-Basrah': 2000,
    'Al-Amarah': 2000,
    'Al-Anbar': 2000,
    'Al-Hilla': 2000,
    'Al-Khalis': 2000,
    'Al-Kifl': 2000,
    'Al-Mawsil': 2000,
    'Al-Musayyib': 2000,
    'Al-Najaf': 2000,
    'Al-Qurnah': 2000,
    'Al-Samawah': 2000,
    'Al-Sulaymaniyah': 2000,
    'Al-Taji': 2000,
    'Al-Talafar': 2000,
    'Al-Zubair': 2000,
    'An-Nasiriyah': 2000,
    'Ar-Ramadi': 2000,
    'As-Samawah': 2000,
    'Az Zubayr': 2000,
    'Badrah': 2000,
    'Balad': 2000,
    'Baquba': 2000,
    'Bayji': 2000,
    'Halabjah': 2000,
    'Hit': 2000,
    'Husaybah': 2000,
    'Khanaqin': 2000,
    'Kufah': 2000,
    'Mahmudiyah': 2000,
    'Mandali': 2000,
    'Maysan': 2000,
    'Nineveh': 2000,
    'Qal\'at Sukkar': 2000,
    'Qaraqosh': 2000,
    'Qayyarah': 2000,
    'Quds': 2000,
    'Rawa': 2000,
    'Rumaythah': 2000,
    'Rutbah': 2000,
    'Samarra': 2000,
    'Sulaimaniyah': 2000,
    'Tal Afar': 2000,
    'Tarmiyah': 2000,
    'Umm Qasr': 2000,
  };

  static String formatDate(Timestamp? createAt) {
    if (createAt == null) {
      return "";
    }

    return DateFormat('dd/MM/yyyy hh:mm a').format(createAt.toDate());
  }

  ///length must be 5 or more
  static String generateRandomString(int length) {
    // C48F45651531
    // [0] [A-Z]
    // [1..2] [0-9]
    // [3] [A-Z]
    // [4..length] [0-9]

    String randomString = "";

    for (var i = 0; i < length; i++) {
      if (i == 0 || i == 3) {
        randomString += String.fromCharCode(Random().nextInt(26) + 65);
        continue;
      }
      randomString += Random().nextInt(10).toString();
    }

    return randomString;
  }

  static String? formatTracingNumber(String? trackingNumber) {
    if (trackingNumber == null) {
      return null;
    }

    String mString = trackingNumber;

    mString =
        "${mString.substring(0, 3)}-${mString.substring(3, mString.length)}";

    return mString;
  }
}
