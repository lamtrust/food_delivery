import 'package:flutter/material.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/modules/shop/models/address_type.dart';
import 'package:food_delivery/modules/shop/pages/pick_exact_location.dart';
import 'package:food_delivery/utils/extensions/index.dart';
import 'package:localregex/localregex.dart';
import 'package:relative_scale/relative_scale.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  AddressType _type = AddressType.Personal;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Add Address',
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
            child: Form(
              child: ListView(
                children: [
                  SizedBox(
                    height: sy(20),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                      vertical: sy(2),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Contact Person Name",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(9),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? name) {
                        if (name!.isEmpty) {
                          return "Name is required!";
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                      vertical: sy(2),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Contact Person Number",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(9),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? phone) {
                        if (phone!.isEmpty) {
                          return "Phone Number is required!";
                        }

                        if (!LocalRegex.isValidZimMobile(phone)) {
                          return "Invalid Phone Number!";
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                      vertical: sy(2),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Address",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(9),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? address) {
                        if (address!.isEmpty) {
                          return "Address is required!";
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  Text(
                    "Address Type",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: sy(9),
                    ),
                  ),
                  SizedBox(
                    height: sy(3),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sx(20),
                      vertical: sy(2),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField(
                      value: _type,
                      items: AddressType.values.map((AddressType type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList(),
                      onChanged: (AddressType? type) {
                        _type = type!;
                      },
                      decoration: InputDecoration(
                        hintText: "Address Type",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(9),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  GestureDetector(
                    onTap: () => context.routeTo(
                      page: const PickExactLocationPage(),
                    ),
                    child: Container(
                      width: context.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: sy(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Text(
                        "Pick Exact Location",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sy(20),
                  ),
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      width: context.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: sy(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Text(
                        "Save Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
