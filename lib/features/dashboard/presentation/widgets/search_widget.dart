import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate/core/constant/strings.dart';
import 'package:real_estate/core/shared_widget/app_texfield.dart';
import 'package:real_estate/core/shared_widget/round_container.dart';



class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Completer<GoogleMapController> mapController = Completer();

  late GoogleMapController googleMapController;

  Map<MarkerId, Marker> markers = {};

  BitmapDescriptor fromMaker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor toMaker = BitmapDescriptor.defaultMarker;

  List<Map<String, dynamic>> option = [
    {
      'icon': AppStrings.securityIcon,
      'label': 'Cosy areas'
    },{
      'icon': AppStrings.walletIcon,
      'label': 'Price'
    },
    {
      'icon': AppStrings.bucketIcon,
      'label': 'Infrastructure'
    },
    {
      'icon': AppStrings.stackIcon,
      'label': 'Without any layer'
    },
  ];

  int selectedMenuIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  setMakerIcon() async{
    // BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 2.0), AppStrings.fromIndicatorImage).then((value){
    //   setState(() {
    //     fromMaker = value;
    //   });
    // });
    //
    // BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 2.0), AppStrings.toIndicatorImage).then((value){
    //   setState(() {
    //     toMaker = value;
    //   });
    // });

  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    mapController.future.then((value) {
      googleMapController = controller;
      googleMapController.setMapStyle('''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''');
    });

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        GoogleMap(
          onMapCreated: _onMapCreated,
          // mapType: MapType.satellite,
          // tiltGesturesEnabled: true,
          compassEnabled: false,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(6.616865,.508072),
            zoom: 10,
          ),
          // markers: {
            // Marker(
            //     markerId: const MarkerId('to'),
            //     icon: toMaker,
            //     position: toPosition),
          // },
        ),

        Positioned(
          left: 20,
          right: 20,
          top: kToolbarHeight,
          child: Row(
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 260.w, ),
                duration: const Duration(seconds: 1),
                builder: (ctx, value, __){
                  return SizedBox(
                      height: 50,
                      width: value,
                      child: const AppTextField());
                },
              ),
              const SizedBox(width: 10,),

              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 27, ),
                duration: const Duration(seconds: 1),
                builder: (ctx, value, __){
                  return RoundContainer(
                      color: Colors.white, padding: 10,
                      child: SvgPicture.asset(
                        AppStrings.filterIcon,
                        height: value,
                        // color: ,
                      ));
                },
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 130,
          left: 20,
          right: 20,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 20, ),
                      duration: const Duration(seconds: 1),
                      builder: (ctx, value, __){
                        return RoundContainer(
                            color: Colors.white38,
                            padding: 0,
                            child: PopupMenuButton<int>(
                              icon: SvgPicture.asset(
                                option[selectedMenuIndex]['icon'],
                                color: Colors.white,
                                height: value,
                              ),
                              onSelected: (index) {
                                selectedMenuIndex = index;
                                setState(() {});
                              },
                              itemBuilder: (context) => List.generate(
                                option.length,
                                    (index) => PopupMenuItem(
                                  value: index,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        option[index]['icon'],
                                        height: 20,
                                        width: 20,
                                        color: selectedMenuIndex == index ? Theme.of(context).colorScheme.primary : Colors.grey,
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(
                                        option[index]['label'],
                                        style: TextStyle(
                                          color: selectedMenuIndex == index ? Theme.of(context).colorScheme.primary : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              offset: const Offset(10,-160),
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                              ),
                            )
                        );
                      },
                    ),
                    const SizedBox(height: 5,),
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 20, ),
                      duration: const Duration(seconds: 1),
                      builder: (ctx, value, __){
                        return RoundContainer(
                            color: Colors.white38,
                            padding: 13,
                            child: SvgPicture.asset(
                              AppStrings.navigatorIcon,
                              color: Colors.white70,
                              height: value,
                            ));
                      },
                    ),
                  ],
                ),

                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.format_align_left_outlined,
                          color: Colors.white54,
                        ),
                        SizedBox(width: 7,),
                        Text(
                          AppStrings.listOfVariantText,
                          style: TextStyle(
                              color: Colors.white70
                          ),
                        )
                      ],
                    ))

              ],
            ))

      ],
    );
  }

}
