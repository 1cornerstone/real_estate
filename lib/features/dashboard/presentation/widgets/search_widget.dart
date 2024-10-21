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
import 'package:widget_to_marker/widget_to_marker.dart';



class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Completer<GoogleMapController> mapController = Completer();

  late GoogleMapController googleMapController;

  final duration = 800;

  Set<Marker> markers = {};

  initMarkers() {

     WidgetsBinding.instance.addPostFrameCallback((_) async {
      markers = {};

      final latlongs = [
        const LatLng(6.616865, 0.708472),
        const LatLng(6.586465, 0.508472),
        const LatLng(6.416865, 0.478072),
        const LatLng(6.316565, 0.578072),
      ];

      for(int i =0; i < latlongs.length; i++ ){
        markers.add(Marker(
            markerId: MarkerId("$i"),
            position: latlongs[i],
            icon: await markerWidget().toBitmapDescriptor(
            logicalSize: const Size(40, 40), imageSize: const Size(100, 100)),
        ));
    }
      setState(() {});
    });
  }

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

  int selectedMenuIndex = 1;

  @override
  void initState() {
    initMarkers();
    super.initState();
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


  Widget markerWidget(){
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          )
      ),
      child: const Icon(
        Icons.list_alt_rounded,
        color: Colors.white,
        size: 25,
      ),
    );
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
            target: LatLng(6.616865, 0.508072),
            zoom: 10,
          ),
          markers: markers
        ),

        Positioned(
          left: 20,
          right: 20,
          top: kToolbarHeight,
          child: Row(
            children: [
              Expanded(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 200, end: 0.w, ),
                  duration: const Duration(milliseconds: 600),
                  builder: (ctx, value, __){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: value),
                        height: 50,
                        child: const AppTextField());
                  },
                ),
              ),
              const SizedBox(width: 10,),

              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 12, ),
                duration:  Duration(milliseconds: duration),
                builder: (ctx, value, __){
                  return RoundContainer(
                      color: Colors.white, padding: value ,
                      child: SvgPicture.asset(
                        AppStrings.filterIcon,
                        height: value * 2,
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
                      tween: Tween<double>(begin: 0, end: 15, ),
                      duration:  Duration(milliseconds: duration),
                      builder: (ctx, value, __){
                        return RoundContainer(
                            color: Colors.white38,
                            padding: value,
                            child: PopupMenuButton<int>(
                              // padding: EdgeInsets.zero,
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
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              ),
                              // padding: EdgeInsets.zero,
                              child: SvgPicture.asset(
                                option[selectedMenuIndex]['icon'],
                                color: Colors.white,
                                height: value * 1.5,
                              ),
                            )
                        );
                      },
                    ),
                    const SizedBox(height: 5,),
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 15, ),
                      duration:  Duration(milliseconds: duration),
                      builder: (ctx, value, __){
                        return GestureDetector(
                          onTap: (){
                            initMarkers();
                          },
                          child: RoundContainer(
                              color: Colors.white38,
                              padding: value,
                              child: SvgPicture.asset(
                                AppStrings.navigatorIcon,
                                color: Colors.white70,
                                height: value * 1.5,
                              )),
                        );
                      },
                    ),
                  ],
                ),

                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 14, ),
                  duration:  Duration(milliseconds: duration),
                  builder: (ctx, value, __){
                    return  Container(
                        padding: EdgeInsets.all(value),
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.format_align_left_outlined,
                              color: Colors.white54,
                              size: value * 1.6,
                            ),
                            const SizedBox(width: 7,),
                            Text(
                              AppStrings.listOfVariantText,
                              style: TextStyle(
                                  color: Colors.white70,
                                fontSize: value
                              ),
                            )
                          ],
                        ));
                  },
                ),

              ],
            ))

      ],
    );
  }

}
