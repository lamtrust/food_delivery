import 'package:flutter/material.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/index.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class ManageAddressesPage extends StatefulWidget {
  const ManageAddressesPage({Key? key}) : super(key: key);

  @override
  _ManageAddressesPageState createState() => _ManageAddressesPageState();
}

class _ManageAddressesPageState extends State<ManageAddressesPage> {
  Future<List<Map<String, dynamic>>?>? _future;

  @override
  void initState() {
    _future = Provider.of<ShopProvider>(context, listen: false).getAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Manage Addresses',
            style: TextStyle(
              color: AppColors.darkBlue,
            ),
          ),
          iconTheme: IconThemeData(
            color: AppColors.darkBlue,
          ),
        ),
        body: SafeArea(
          child: Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.symmetric(
              horizontal: sx(20),
            ),
            child: FutureBuilder(
              future: _future,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
                while (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                List<Map<String, dynamic>>? data = snapshot.data;

                print("Returned Data: ${data}");

                if (data == null) {
                  return const Center(
                    child: Text('No addresses found'),
                  );
                }

                return ListView(
                  children: data.map((Map<String, dynamic> address) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sx(20),
                        vertical: sy(10),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: sy(7),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1.0,
                            spreadRadius: 0.5,
                            offset: const Offset(
                              1.0,
                              1.0,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${address['contact_person_name']} (${address['address_type']})",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(10),
                            ),
                          ),
                          SizedBox(
                            height: sy(3),
                          ),
                          Text(
                            "📱 ${address['contact_person_number']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: sy(10),
                            ),
                          ),
                          SizedBox(
                            height: sy(3),
                          ),
                          Text(
                            "📍 ${address['address']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: sy(10),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
