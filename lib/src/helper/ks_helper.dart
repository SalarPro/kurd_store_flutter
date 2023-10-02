import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
      return "n";
    }

    if (number is int || number is double) {
      return NumberFormat("#,###").format(number) + postfix;
    }

    return number.toString() + postfix;
  }
}
