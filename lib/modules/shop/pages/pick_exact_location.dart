import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/services/location.service.dart';
import 'package:food_delivery/utils/extensions/index.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class PickExactLocationPage extends StatefulWidget {
  const PickExactLocationPage({Key? key}) : super(key: key);

  @override
  _PickExactLocationPageState createState() => _PickExactLocationPageState();
}

class _PickExactLocationPageState extends State<PickExactLocationPage> {
  LatLng? _pickedLocation;

  Future<LocationData?>? _future;

  @override
  initState() {
    _future = locator<LocationService>().getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: context.height,
            width: context.width,
            child: FutureBuilder(
                future: _future,
                builder: (BuildContext context,
                    AsyncSnapshot<LocationData?> snapshot) {
                  while (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  LocationData? locationData = snapshot.data;

                  if (locationData == null) {
                    return const Center(
                      child: Text('Failed to get location'),
                    );
                  }

                  return FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                          locationData.latitude!, locationData.longitude!),
                      zoom: 13.0,
                      onPositionChanged: (position, coordinates) {
                        if (coordinates == false) {
                          _pickedLocation = position.center;
                        } else {
                          setState(() {
                            _pickedLocation = position.center;
                          });
                        }
                      },
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      _pickedLocation != null
                          ? MarkerLayerOptions(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: _pickedLocation!,
                                  builder: (ctx) => Image(
                                    image: AssetImage("assets/icons/pin.png"),
                                  ),
                                ),
                              ],
                            )
                          : MarkerLayerOptions(),
                    ],
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.darkBlue,
          child: const Text("Done"),
          onPressed: () {
            Provider.of<ShopProvider>(context, listen: false).setLocation =
                _pickedLocation;
            context.goBack();
          },
        ),
      );
    });
  }
}
