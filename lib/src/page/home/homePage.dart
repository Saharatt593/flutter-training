import 'package:flutter/material.dart';
import 'package:flutter_app2/src/conf/appRount.dart';
import 'package:flutter_app2/src/constants/api.dart';
import 'package:flutter_app2/src/constants/asset.dart';
import 'package:flutter_app2/src/modul/productResponse.dart';
import 'package:flutter_app2/src/page/login/backGroundTheme.dart';
import 'package:flutter_app2/src/service/network.dart';
import 'package:flutter_app2/src/viewmodels/menuViewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app2/src/constants/appSetting.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: CommonDrawer(),
      body: FutureBuilder<List<ProductResponse>>(
        future: NetworkService().productAll(),
        builder: (context, snapshort) {
          if (!snapshort.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshort.hasError) {
            return Text(snapshort.error.toString());
          }
          final productList = snapshort.data;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, item) => LayoutBuilder(
                builder: (context, constraint) =>
                    ShopListItem(constraint.maxHeight,productList[item], press: () {})),
            itemCount: 5,
            // itemCount: productList.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Name'),
            accountEmail: Text('Email'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/cdgs_logo.png"),
            ),
            decoration: BoxDecoration(gradient: BackGroundTheme.gradient),
          ),
          ...MenuViewModel()
              .items
              .map((e) => ListTile(
                    onTap: () {
                      e.onTap(context);
                    },
                    leading: Icon(
                      e.icon,
                      color: e.iconColor,
                    ),
                    title: Text(e.title),
                  ))
              .toList(),
          Spacer(),
          ListTile(
            onTap: () async {
              SharedPreferences tokenPreferences =
                  await SharedPreferences.getInstance();
              await tokenPreferences.remove(AppSetting.tokenSetting);
              await tokenPreferences.remove(AppSetting.usernameString);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRount.loginRount, (route) => false);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}

class ShopListItem extends StatelessWidget {
  final Function press;
  final double maxHeight;
  final ProductResponse product;

  const ShopListItem(this.maxHeight,this.product, {Key key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _buildImage(),
            Expanded(
              child: _buildInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildInfo() => Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ชื่อสินค้า ${product.name}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$ ราคาสินค้า ${product.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'จำนวน ${product.stock}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Stack _buildImage() {
    final height = maxHeight * 0.7;
    final productImage = product.image;
    return Stack(
      children: [
        productImage != null && productImage.isNotEmpty
            ? Image.network(
                "${API.IMAGE_URL}/${productImage}",
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.asset(
                Asset.noPhotoImage,
                height: height,
                width: double.infinity,
              ),
        if (product.stock <= 0)
          Positioned(
            top: 1,
            right: 1,
            child: Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.box,
                      size: 15.0,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'out of stock',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
