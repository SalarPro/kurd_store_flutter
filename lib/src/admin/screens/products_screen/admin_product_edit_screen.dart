// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/category_model.dart';
import 'package:kurd_store/src/models/product_model.dart';
import 'package:uuid/uuid.dart';

class AdminProductEditScreen extends StatefulWidget {
  const AdminProductEditScreen({super.key, this.wProduct});

  final KSProduct? wProduct;

  @override
  State<AdminProductEditScreen> createState() => _AdminProductEditScreenState();
}

class _AdminProductEditScreenState extends State<AdminProductEditScreen> {
  bool isLoading = true;

  List<KSCategory> categories = [];

  bool isUpdate = false;
  KSProduct? product;

  File? imageFile;

  var nameTVC = TextEditingController();
  var descriptionTVC = TextEditingController();
  var maxQuantityTVC = TextEditingController();
  var priceTVC = TextEditingController();
  var priceDiscountTVC = TextEditingController();
  List<int> colors = [];
  List<String> sizes = [];
  KSCategory? selectedCategory;

  // Define custom colors. The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  Color dialogPickerColor = Colors.blue;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    if (widget.wProduct != null) {
      isUpdate = true;
      product = widget.wProduct;
      nameTVC.text = product!.name ?? "";
      descriptionTVC.text = product!.description ?? "";
      maxQuantityTVC.text = (product!.maxQuantity ?? 0).toString();
      priceTVC.text = product!.price.toString();
      if (product!.priceDiscount != null) {
        priceDiscountTVC.text = product!.priceDiscount!.toString();
      }
      colors = product!.colors ?? [];
      sizes = product!.sizes ?? [];
    }

    categories = await KSCategory.getAll();

    if (isUpdate) {
      if ((product!.categoriesIds?.isNotEmpty ?? false) &&
          categories.isNotEmpty) {
        var isContaing = categories
            .where((element) => element.uid == product!.categoriesIds!.first)
            .isNotEmpty;

        if (isContaing) {
          selectedCategory = categories.firstWhere(
              (element) => element.uid == product!.categoriesIds!.first);
        }
      }
    }

    setState(() {});

    1.delay(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Screen"),
      ),
      body: _bodyLayout,
    );
  }

  get _bodyLayout => Stack(
        children: [
          body(),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              width: Get.width,
              height: Get.height,
              child: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            ),
        ],
      );

  SingleChildScrollView body() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                60),
        child: Column(
          children: [
            imageSelect(),
            selectImageBTN(),
            ksTextfield(
              title: 'Name',
              icon: Icons.text_fields_rounded,
              controller: nameTVC,
              keyBoardType: TextInputType.text,
            ),
            ksTextfield(
              title: 'Description',
              icon: Icons.description_outlined,
              controller: descriptionTVC,
              keyBoardType: TextInputType.text,
            ),
            ksTextfield(
              title: 'Available Quantity',
              icon: Icons.description_outlined,
              controller: maxQuantityTVC,
              keyBoardType: TextInputType.number,
            ),
            ksTextfield(
              title: 'Price',
              icon: Icons.price_change_rounded,
              controller: priceTVC,
              keyBoardType: TextInputType.number,
            ),
            ksTextfield(
              title: 'Discount Price',
              icon: Icons.price_change_rounded,
              controller: priceDiscountTVC,
              keyBoardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
            itemColors(),
            Divider(),
            SizedBox(
              height: 30,
            ),
            itemSizes(sizes),
            ElevatedButton(
              onPressed: () {
                sizePicker();
              },
              child: Text(
                "Add Size",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            dropDown(),
            SizedBox(
              height: 30,
            ),
            navigationBar(),
          ],
        ),
      ),
    );
  }

  Widget itemSizes(List<String> sizes) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < sizes.length; i++) sizeCell(i),
      ],
    );
  }

  Widget sizeCell(int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Delete! Size"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Do you want to remove the ${sizes[index]} size?"),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            sizes.removeAt(index);
                          });
                          Get.back();
                        },
                        child: Text("Yes!")),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("NO"))
                  ],
                ));
      },
      onLongPress: () {
        setState(() {
          sizes.removeAt(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber.withOpacity(0),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          sizes[index],
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget imageSelect() {
    Widget imageWidget;

    if (imageFile != null) {
      imageWidget = Image.file(
        imageFile!,
        fit: BoxFit.cover,
        width: 250,
        height: 250,
      );
    } else if (product?.imageUrl != null) {
      imageWidget = CachedNetworkImage(
        imageUrl: product!.imageUrl!,
        errorWidget: (context, url, error) {
          return Icon(Icons.error);
        },
        fit: BoxFit.cover,
        width: 250,
        height: 250,
      );
    } else {
      imageWidget = Padding(
        padding: const EdgeInsets.all(75.0),
        child: Image.asset(
          Assets.assetsIconsSelectImage,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          color: Color.fromARGB(67, 139, 139, 139),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imageWidget,
      )),
    );
  }

  Widget ksTextfield({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyBoardType,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            keyboardType: keyBoardType,
            decoration: InputDecoration(
              label: Text(title),
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget navigationBar(
      // String? iconPath,
      ) {
    return GestureDetector(
      onTap: () {
        if (isUpdate) {
          update();
        } else {
          save();
        }
      },
      child: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Image.asset(Assets.assetsIconsSave),
                  ),
                ),
                Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            )),
      ),
    );
  }

  Widget selectImageBTN(
      // String? iconPath,
      ) {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Image.asset(Assets.assetsIconsSelectImage),
                    ),
                  ),
                  Text(
                    "Select Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget rachit(
      // String? iconPath,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    '100,000 IQD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '40,000 IQD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    '60,000 IQD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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

  Widget itemColors() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 4,
      spacing: 4,
      children: [
        for (var i = 0; i < colors.length; i++) colorCell(i),
        SizedBox(
          width: 25,
        ),
        GestureDetector(
          onTap: () {
            colorPicker();
          },
          child: KSWidget.iconFrame(Assets.assetsDummyImagesPlus, size: 25),
        )
      ],
    );
  }

  Widget colorCell(int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Delete! Color"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Do you want to remove the Color?"),
                      Container(
                        height: 30,
                        width: 100,
                        padding: EdgeInsets.all(3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (Color(colors[index])).withOpacity(1),
                          border: Border.all(color: Colors.white54, width: 3),
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            colors.removeAt(index);
                          });
                          Get.back();
                        },
                        child: Text("Yes!")),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("NO"))
                  ],
                ));
      },
      child: Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (Color(colors[index])).withOpacity(1),
          border: Border.all(color: Colors.white54, width: 3),
        ),
      ),
    );
  }

  void pickImage() async {
    var tempFile = await KSHelper.pickImageFromGallery(cropTheImage: true);
    if (tempFile != null) {
      setState(() {
        imageFile = tempFile;
      });
    }
  }

  colorPicker() async {
    final Color colorBeforeDialog = dialogPickerColor;

    var result = await ColorPicker(
      // Use the dialogPickerColor as start color.
      color: dialogPickerColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) => setState(() {
        dialogPickerColor = color;
      }),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );

    if (result == false) {
      dialogPickerColor = colorBeforeDialog;
    } else {
      colors.add(dialogPickerColor.value);
      setState(() {});
    }
  }

  sizePicker() async {
    var tec = TextEditingController();

    FocusNode focusNode = FocusNode();
    focusNode.requestFocus();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Type Size"),
        content: ksTextfield(
          title: "Size",
          icon: Icons.stacked_bar_chart_rounded,
          controller: tec,
          focusNode: focusNode,
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (tec.text.isNotEmpty) {
                  setState(() {
                    sizes.add(tec.text);
                  });
                }
                Get.back();
              },
              child: Text("Add")),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"))
        ],
      ),
    );
  }

  Widget dropDown() {
    if (categories.isEmpty) {
      return CircularProgressIndicator();
    }
    return DropdownMenu<KSCategory>(
      initialSelection: selectedCategory ?? categories.first,
      onSelected: (KSCategory? value) {
        setState(() {
          selectedCategory = value;
        });
      },
      dropdownMenuEntries:
          categories.map<DropdownMenuEntry<KSCategory>>((KSCategory value) {
        return DropdownMenuEntry<KSCategory>(
            value: value, label: value.name ?? "N/A");
      }).toList(),
    );
  }

  void save() async {
    //data validation

    if (imageFile == null) {
      KSHelper.showSnackBar("Please select product image");
      return;
    }

    if (nameTVC.text.trim().isEmpty) {
      KSHelper.showSnackBar("Please enter product name");
      return;
    }

    var productName = nameTVC.text.trim();
    var productDesc = descriptionTVC.text.trim();

    if (int.tryParse(maxQuantityTVC.text.trim()) == null) {
      KSHelper.showSnackBar("Please enter valid product quantity");
      return;
    }

    var productQuantity = int.parse(maxQuantityTVC.text.trim());

    if (int.tryParse(priceTVC.text.trim()) == null) {
      KSHelper.showSnackBar("Please enter product price");
      return;
    }

    int productPrice = int.parse(priceTVC.text.trim());
    int? productPriceDiscount;

    if (priceDiscountTVC.text.trim().isNotEmpty) {
      if (int.tryParse(priceDiscountTVC.text.trim()) == null) {
        KSHelper.showSnackBar("Please enter valid product discount price");
        return;
      }
      productPriceDiscount = int.parse(priceDiscountTVC.text.trim());
    }

    if (selectedCategory == null) {
      KSHelper.showSnackBar("Please select category");
      return;
    }

    product = KSProduct(
      uid: Uuid().v4(),
      colors: colors,
      description: productDesc,
      maxQuantity: productQuantity,
      name: productName,
      price: productPrice,
      priceDiscount: productPriceDiscount,
      sizes: sizes,
      categoriesIds: [selectedCategory!.uid ?? "N/A"],
    );

    setState(() {
      isLoading = true;
    });

    //upload media
    product!.imageUrl = await KSHelper.uploadMedia(imageFile!, 'products');

    //save data

    await product!.save();

    Get.back();

    setState(() {
      isLoading = false;
    });
  }

  void update() async {
    //data validation

    if (imageFile == null && product?.imageUrl == null) {
      KSHelper.showSnackBar("Please select product image");
      return;
    }

    if (nameTVC.text.trim().isEmpty) {
      KSHelper.showSnackBar("Please enter product name");
      return;
    }

    var productName = nameTVC.text.trim();
    var productDesc = descriptionTVC.text.trim();

    if (int.tryParse(maxQuantityTVC.text.trim()) == null) {
      KSHelper.showSnackBar("Please enter valid product quantity");
      return;
    }

    var productQuantity = int.parse(maxQuantityTVC.text.trim());

    if (int.tryParse(priceTVC.text.trim()) == null) {
      KSHelper.showSnackBar("Please enter product price");
      return;
    }

    int productPrice = int.parse(priceTVC.text.trim());
    int? productPriceDiscount;

    if (priceDiscountTVC.text.trim().isNotEmpty) {
      if (int.tryParse(priceDiscountTVC.text.trim()) == null) {
        KSHelper.showSnackBar("Please enter valid product discount price");
        return;
      }
      productPriceDiscount = int.parse(priceDiscountTVC.text.trim());
    }

    if (selectedCategory == null && (product!.categoriesIds?.isEmpty ?? true)) {
      KSHelper.showSnackBar("Please select category");
      return;
    }

    product!.colors = colors;
    product!.description = productDesc;
    product!.maxQuantity = productQuantity;
    product!.name = productName;
    product!.price = productPrice;
    product!.priceDiscount = productPriceDiscount;
    product!.sizes = sizes;
    if (selectedCategory != null) {
      product!.categoriesIds = [selectedCategory!.uid ?? "N/A"];
    }

    setState(() {
      isLoading = true;
    });

    if (imageFile != null) {
      //upload media
      product!.imageUrl = await KSHelper.uploadMedia(imageFile!, 'products');
    }
    //save data

    await product!.update();

    Get.back();

    setState(() {
      isLoading = false;
    });
  }
}
