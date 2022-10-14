import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/const/text-style.dart';
import 'package:ecommerce/service/custom_http.dart';
import 'package:ecommerce/toast/logintoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  String? fildName;
  bool isVisibility = false;
  bool isImageVisible = false;
  bool isBool = false;

  File? icon, image;
  final _picker = ImagePicker();

  Future getIconfromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        print('Image found');
        icon = File(pickedImage.path);
        isVisibility = true;

        print('$icon');
      } else {
        print('image not found');
      }
    });
  }

  Future getImagefromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        print('Image found');
        image = File(pickedImage.path);
        isImageVisible = true;

        print('$image');
      } else {
        print('image not found');
      }
    });
  }

  Future createcategory() async {
    try {
      final uri = Uri.parse(
          "https://apihomechef.antopolis.xyz/api/admin/category/store");
      // var link = 'https://apihomechef.antopolis.xyz/api/admin/category/store';

      // var request = http.MultipartRequest('POST', uri);
      var request = http.MultipartRequest("POST", uri);

      final token =
          request.headers.addAll(await CustomeHttp().getheaderWithToken());
      print('push header');

      request.fields['name'] = nameController.text.toString();
      print('push name');

      var iconImage = await http.MultipartFile.fromPath('icon', icon!.path);
      print('push icon');

      request.files.add(iconImage);

      var photoImage = await http.MultipartFile.fromPath('image', image!.path);
      print('push image');

      request.files.add(photoImage);

      setState(() {
        isBool = true;
      });

      var respons = await request.send();

      print('status code   ${respons.statusCode}');

      var responseData = await respons.stream.toBytes();

      var responsString = String.fromCharCodes(responseData);

      print('responsString = $responsString');

      var data = jsonDecode(responsString);

      print("the message isssssssssss \"${data['message']}\"");

      setState(() {
        isBool = false;
      });

      if (respons.statusCode == 201) {
        showIntoast('${data['message']}');
        Navigator.of(context).pop();
      }
    } catch (e) {
      showIntoast('Try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isBool,
      blur: 0.1,
      dismissible: true,
      progressIndicator: spinkit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add category'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      fildName = name;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Write Category Name';
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
                          getIconfromGallery();
                        },
                        child: Container(
                          height: height * 0.2,
                          width: width * 0.4,
                          decoration: BoxDecoration(color: Color(0xffEBEBEB)),
                          child: icon == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: Color(0xffF0BFAD),
                                    ),
                                    Text(
                                      'Upload',
                                      style: myStyle(
                                          clr: Color(0xffF0BFAD), fs: 16),
                                    )
                                  ],
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(icon!))),
                                ),
                        ),
                      ),
                      Positioned(
                          bottom: -20,
                          left: width * 0.1,
                          child: Visibility(
                              visible: isVisibility,
                              child: Container(
                                width: 50,
                                height: 50,
                                child: TextButton(
                                    onPressed: () {
                                      getIconfromGallery();
                                    },
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 50,
                                      color: Colors.teal,
                                    )),
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('320x320 is the Recommended Size',
                      style: myStyle(
                        clr: Colors.grey,
                      )),
                  SizedBox(
                    height: 15,
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
                          getImagefromGallery();
                        },
                        child: Container(
                          height: height * 0.3,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Color(0xffEBEBEB)),
                          child: image == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: Color(0xffF0BFAD),
                                    ),
                                    Text(
                                      'Upload',
                                      style: myStyle(
                                          clr: Color(0xffF0BFAD), fs: 16),
                                    )
                                  ],
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(
                                      image!,
                                    ),
                                  )),
                                ),
                        ),
                      ),
                      Positioned(
                          bottom: -20,
                          left: width * 0.35,
                          child: Visibility(
                              visible: isImageVisible,
                              child: Container(
                                width: 50,
                                height: 50,
                                child: TextButton(
                                    onPressed: () {
                                      getImagefromGallery();
                                    },
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 50,
                                      color: Colors.teal,
                                    )),
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 40,
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
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            if (icon == null) {
                              showIntoast(
                                  'Please upload category icon from your mobile');
                            } else if (image == null) {
                              showIntoast(
                                  'Please upload category image from your mobile');
                            } else {
                              createcategory();
                            }
                          }
                        },
                        child: Text(
                          'Publish Category',
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
            ),
          ),
        ),
      ),
    );
  }
}
