import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/const/text-style.dart';
import 'package:ecommerce/model/categories_model.dart';
import 'package:ecommerce/service/custom_http.dart';
import 'package:ecommerce/toast/logintoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Editcategory extends StatefulWidget {
  Editcategory({super.key, required this.categoryModel});

  CategoryModel categoryModel;

  @override
  State<Editcategory> createState() => _EditcategoryState();
}

class _EditcategoryState extends State<Editcategory> {
  TextEditingController? nameController;

  final _formkey = GlobalKey<FormState>();

  String? fild;

  File? icon, image;

  final _picker = ImagePicker();

  Future getIconFromgallary() async {
    final pickImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      print('icon loaded');

      setState(() {
        icon = File(pickImage.path);

        isIcon = true;
      });

      print("$icon");
    } else {
      print('Image not found');
    }
  }

  Future getImageFromgallary() async {
    final pickimage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickimage != null) {
      print('Image loaded');

      setState(() {
        image = File(pickimage.path);
        isImage = true;
      });
      print('$image');
    } else {
      print('Image not found');
    }
  }

  bool isIcon = false;
  bool isImage = false;
  bool isProgress = false;

  @override
  void initState() {
    // TODO: implement initState

    nameController = TextEditingController(text: widget.categoryModel.name);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Categories'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        progressIndicator: spinkit,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          width: double.infinity,
          child: SingleChildScrollView(
              child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category Name',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nameController,
                  onSaved: (name) {
                    fild = name;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write category name';
                    }
                    if (value.length < 3) {
                      return 'More than three word';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Category Name',
                      hintStyle: myStyle(clr: Colors.grey, fs: 16),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Category Icon',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        getIconFromgallary();
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(8)),
                        child: icon == null
                            ? Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://apihomechef.antopolis.xyz/images/${widget.categoryModel.icon}'))),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(icon!))),
                              ),
                      ),
                    ),
                    Positioned(
                        bottom: -30,
                        left: width * 0.12,
                        child: Visibility(
                          visible: isIcon,
                          child: TextButton(
                              onPressed: () {
                                getIconFromgallary();
                              },
                              child: Icon(Icons.add_a_photo_outlined,
                                  size: 50, color: Colors.teal)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Category Image',
                  style:
                      myStyle(clr: Colors.black, fs: 18, fw: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        getImageFromgallary();
                      },
                      child: Container(
                        width: double.infinity,
                        height: height * 0.3,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(8)),
                        child: image == null
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://apihomechef.antopolis.xyz/images/${widget.categoryModel.image}'))),
                              )
                            : Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: FileImage(image!))),
                              ),
                      ),
                    ),
                    Positioned(
                        bottom: -30,
                        left: width * 0.35,
                        child: Visibility(
                          visible: isImage,
                          child: TextButton(
                              onPressed: () {
                                getImageFromgallary();
                              },
                              child: Icon(Icons.add_a_photo_outlined,
                                  size: 50, color: Colors.teal)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.black,
                      //  border: Border.all(color: aTextColor, width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        updateCategory();
                      },
                      child: Text(
                        'Update category',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future updateCategory() async {
    try {
      var uri = Uri.parse(
          'https://apihomechef.antopolis.xyz/api/admin/category/${widget.categoryModel.id}/update');

      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(await CustomeHttp().getheaderWithToken());

      request.fields['name'] = nameController!.text.toString();

      if (icon != null) {
        var iconImage = await http.MultipartFile.fromPath('icon', icon!.path);

        request.files.add(iconImage);
      }

      if (image != null) {
        var photoImage =
            await http.MultipartFile.fromPath('image', image!.path);

        request.files.add(photoImage);
      }

      setState(() {
        isProgress = true;
      });

      var respons = await request.send();

      print('status code ${respons.statusCode}');
      var responseData = await respons.stream.toBytes();

      var responsString = String.fromCharCodes(responseData);
      print('respons Stringgggggg $responsString');

      var data = jsonDecode(responsString);

      print("jsondata isssssssss${data['message']}");

      if (respons.statusCode == 200) {
        print('Repons okkkkkkkkkkkk code is  ${respons.statusCode}');

        showIntoast('${data['message']}');
        Navigator.of(context).pop();
      }
    } catch (e) {
      showIntoast('Try again');
      setState(() {
        isProgress = false;
      });
    }
  }
}
