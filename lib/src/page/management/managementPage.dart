import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/src/modul/productResponse.dart';
import 'package:flutter_app2/src/page/management/productImage.dart';
import 'package:flutter_app2/src/service/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  File _image;
  final picker = ImagePicker();
  final _form = GlobalKey<FormState>();
  bool _editMode;
  ProductResponse _product;

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  callback(File image){
    _image = image;
  }

  @override
  void initState() {
    _editMode = false;
    _product = ProductResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Object productData = ModalRoute.of(context).settings.arguments;
    if(productData is ProductResponse) {
      _product = productData;
      _editMode = true;
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                _buildNameInput(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Flexible(
                      child: _buildPriceInput(),
                      flex: 1,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: _buildStockInput(),
                      flex: 1,
                    )
                  ],
                ),
                ProductImage(callback, image: _product.image)
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputStyle({String label}) =>
      InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        labelText: label,
      );

  TextFormField _buildNameInput() =>
      TextFormField(
        initialValue: _product.name ?? "",
        decoration: inputStyle(label: "name"),
        onSaved: (String value) {
          _product.name = value;
        },
      );

  TextFormField _buildPriceInput() =>
      TextFormField(
        initialValue: _product.price == null ? '0':_product.price.toString(),
        decoration: inputStyle(label: "price"),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          _product.price = int.parse(value ?? '0');
        },
      );

  TextFormField _buildStockInput() =>
      TextFormField(
        initialValue: _product.stock == null ? '0':_product.stock.toString(),
        decoration: inputStyle(label: "stock"),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          _product.stock = int.parse(value ?? '0');
        },
      );

  AppBar _buildAppBar() =>
      AppBar(
        title: Text(_editMode ? 'Edit Product' : 'Add Product'),
        actions: [
          TextButton(
            onPressed: () async {
              _form.currentState.save();
              FocusScope.of(context).requestFocus(FocusNode());
              if (_editMode) {
                try {
                  final message =
                  await NetworkService().editProduct(_image, _product);
                  Navigator.pop(context);
                  showAlertBar(
                    message,
                  );
                }catch (ex){
                  showAlertBar(
                    ex.toString(),
                    color: Colors.red,
                    icon: FontAwesomeIcons.cross,
                  );
                }
              } else {
                try {
                  final message =
                  await NetworkService().addProduct(_image, _product);
                  Navigator.pop(context);
                  showAlertBar(
                    message,
                  );
                } catch (ex) {
                  showAlertBar(
                    ex.toString(),
                    color: Colors.red,
                    icon: FontAwesomeIcons.cross,
                  );
                }
              }
            },
            child: Text(
              'submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      );

  void showAlertBar(String message, {
    IconData icon = FontAwesomeIcons.checkCircle,
    MaterialColor color = Colors.green,
  }) {
    Flushbar(
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )
      ..show(context);
  }
}