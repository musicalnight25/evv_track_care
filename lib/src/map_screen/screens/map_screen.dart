
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/custom_image.dart';
import '../../../core/utils/gap.dart';
import '../../auth/providers/auth_provider.dart';

class MapRoute extends AppScaffoldRoute {
  const MapRoute({required this.clientLat, required this.clientLong,required this.address,required this.imageUrl});

  final double? clientLat;
  final double? clientLong;
  final String? address;
  final String? imageUrl;

  @override
  Widget get screen => MapScreen(params: this);

  @override
  Routes get routeName => Routes.map;
}

class MapScreen extends StatefulWidget {
  final MapRoute params;

  const MapScreen({super.key, required this.params});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with AutomaticKeepAliveClientMixin<MapScreen> {
  @override
  bool get wantKeepAlive => true;
  late final MapController mapController;
  RoadInfo? roadInfo;
  GeoPoint? currentLocation;
  double? distance;
  String? duration;

  @override
  void initState() {
    super.initState();
    // mapController = MapController(
    //   initPosition: GeoPoint(latitude: widget.params.clientLat!.toDouble(), longitude: widget.params.clientLong!.toDouble()),
    //   areaLimit: BoundingBox(
    //     east: 10.4922941,
    //     north: 47.8084648,
    //     south: 45.817995,
    //     west:  5.9559113,
    //   ),
    // );

    _requestPermission();

    mapController = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        await mapController.enableTracking(enableStopFollow:false,);

        await _drawPolyline();


      });
    });

    /// Update Location

  }

  Future<void> _requestPermission() async {
    if (await Permission.location.request().isGranted) {
      // Once permission is granted, get the current location
      _getCurrentLocation();
    } else {
      print("Location permission not granted.");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: Scaffold(
          body: SafeArea(
            child: Consumer<AuthProvider>(builder: (context, auth,_) {
                return Stack(
                  children: [
                    OSMFlutter(
                        controller: mapController,
                        osmOption: OSMOption(
                          userTrackingOption: const UserTrackingOption(
                            enableTracking: true,
                            unFollowUser: false,
                          ),
                          zoomOption: const ZoomOption(
                            initZoom: 8,
                            minZoomLevel: 3,
                            maxZoomLevel: 19,
                            stepZoom: 1.0,
                          ),
                          userLocationMarker: UserLocationMaker(
                            personMarker: const MarkerIcon(
                              icon: Icon(
                                Icons.location_history_rounded,
                                color: Colors.red,
                                size: 48,
                              ),
                            ),
                            directionArrowMarker: const MarkerIcon(
                              icon: Icon(
                                Icons.person_pin_circle,
                                size: 56,
                              ),
                            ),
                          ),
                          roadConfiguration: const RoadOption(
                            roadColor: Colors.yellowAccent,
                          ),
                        /*  markerOption: MarkerOption(
                              defaultMarker: MarkerIcon(
                            icon: Icon(
                              Icons.person_pin_circle,
                              color: Colors.blue,
                              size: 56,
                            ),
                          )),*/
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 3.4.h,
                              width: 3.4.h,
                              color: AppColors.Primary,
                              child: const Icon(Icons.keyboard_arrow_left,color: Colors.white,),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.popUntil((route) => route.settings.name == Routes.home.path);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: Icon(
                                Icons.home_filled,
                                size: 4.h,
                                color: AppColors.Primary,
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(right: 1.w),
                          //   child: SvgImage(SvgIcons.notification),
                          // )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Container(
                            height: 18.h,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w), color: AppColors.white),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Row(
                                children: [
                                  CustomImage(
                                    url:widget.params.imageUrl  != "" ? "${auth.getImageBaseUrl().toString()}/images/avatars/${widget.params.imageUrl}" : "${auth.getImageBaseUrl().toString()}/avatars.jpg",height: 10.h,width: 10.h,fit: BoxFit.fill,
                                  ),
                                 /* Image.asset(
                                    AppImages.ic_demo_img,
                                    height: 10.h,
                                    width: 10.h,
                                    fit: BoxFit.fill,
                                  ),*/
                                  HGap(2.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppColors.theme,
                                              size: 2.5.h,
                                            ),
                                            HGap(1.w),
                                            Expanded(child: Txt(widget.params.address == "null,null,null,null" ? "--": widget.params.address.toString(), fontSize: 2.t, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Txt("Distance:" ?? "", textColor: AppColors.grey, fontSize: 1.8.t, fontWeight: FontWeight.w400),
                                            Txt(distance == null ? "--": " ${distance?.toStringAsFixed(2)} KM" ?? "-", textColor: AppColors.Primary, fontSize: 2.t, fontWeight: FontWeight.w600),
                                          ],
                                        ),
                                        Row(
                                          children: [

                                            Txt("Time:" ?? "", textColor: AppColors.grey, fontSize: 1.8.t, fontWeight: FontWeight.w400),
                                            Txt(duration == null ?"--" :" $duration" ?? "", textColor: AppColors.black, fontSize: 1.8.t, fontWeight: FontWeight.w400),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _drawPolyline(),
            child: const Icon(Icons.directions),
          )),
    );
  }

  _drawPolyline() async {
    final List<GeoPoint> points = [
      GeoPoint(latitude: 52.5200, longitude: 13.4050), // Start point (Paris example)
      GeoPoint(latitude: widget.params.clientLat == null ? 48.1351 : widget.params.clientLat?.toDouble() ?? 48.1351, longitude: widget.params.clientLong == null ? 11.5820 : widget.params.clientLong?.toDouble() ?? 11.5820), // End point (Eiffel Tower example)
    ];

    // Drawing a polyline between points
    await mapController.drawRoad(points.first, points.last,
        roadType: RoadType.car, // Optional: type of road (car, foot, bike, etc.)
        roadOption: const RoadOption(roadColor: AppColors.Primary, roadWidth: 8, zoomInto: true)
        // roadColor: Colors.blue,
        // showMarkerOfPOI: false,
        );

     roadInfo = await mapController.drawRoad(
       points.first, points.last,
       roadType: RoadType.car,
    //   intersectPoint : [ GeoPoint(latitude: 47.4361, longitude: 8.6156), GeoPoint(latitude: 47.4481, longitude: 8.6266)],
       roadOption: const RoadOption(
       roadWidth: 10,
       roadColor: Colors.blue,
       zoomInto: true,
     ),
    );

    duration = convertTime(roadInfo?.duration ?? 0.0);
     print("Road data  $duration");


    distance = calculateDistance(52.5200, 13.4050, 48.1351, 11.5820) / 1000;
    await mapController.removeMarkers([GeoPoint(latitude: 52.5200, longitude: 13.4050),GeoPoint(latitude: 48.1351, longitude: 11.5820)]);
    await mapController.addMarker(GeoPoint(latitude: 52.5200, longitude: 13.4050),
        markerIcon:const MarkerIcon(icon:Icon(Icons.location_on_outlined) ,) ,
        //angle:pi/3,
        iconAnchor:IconAnchor(anchor: Anchor.top,)
    );

    await mapController.addMarker(GeoPoint(latitude: 48.1351, longitude: 11.5820),
      markerIcon:const MarkerIcon(icon:Icon(Icons.location_on_outlined) ,) ,
      //angle:pi/3,
      iconAnchor:IconAnchor(anchor: Anchor.top,)
    );

    //   distance = calculateDistance(22.29161, 70.79322, widget.params.clientLat?.toDouble() ?? 23.0225, widget.params.clientLong?.toDouble() ?? 72.5714) / 1000;
    setState(() {});
  }

  _getCurrentLocation() async {
    try {
      // Fetch the current location's latitude and longitude
      GeoPoint location = await mapController.myLocation();
      print("Current Location: 1234");
      setState(() {
        currentLocation = location;
      });
      print("Current Location: ${location.latitude}, ${location.longitude}");
    } catch (e) {
      print("Failed to get current location: $e");
    }
  }

  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  String convertTime(double seconds) {
    if (seconds < 3600) {
      // If less than an hour, return minutes
      int minutes = seconds ~/ 60; // Use integer division for minutes
      return '$minutes Minute${minutes > 1 ? 's' : ''}';
    } else {
      // If 3600 seconds or more, return hours and minutes
      int hours = seconds ~/ 3600; // Integer division for hours
      int minutes = (seconds % 3600) ~/ 60; // Remaining minutes
      return '$hours hr${hours > 1 ? 's' : ''} $minutes min${minutes > 1 ? 's' : ''}';
    }
  }

}
