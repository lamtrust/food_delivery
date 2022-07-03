import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/controllers/products.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({Key? key}) : super(key: key);

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  Future<Response>? _future;

  @override
  void initState() {
    _future = ProductsController.getOrders(
        access: "${Provider.of<ShopProvider>(context, listen: false).token}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Manage Orders",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: sy(12),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: Container(
            height: context.height,
            width: context.width,
            child: FutureBuilder(
              future: _future,
              builder:
                  (BuildContext context, AsyncSnapshot<Response> snapshot) {
                while (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }

                Response response = snapshot.data!;

                return ListView(
                  shrinkWrap: true,
                  children: const [],
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
