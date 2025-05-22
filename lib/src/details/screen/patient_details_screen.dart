import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/common/widgets/custom_elevated_button.dart';
import 'package:healthcare/core/common/widgets/custom_image.dart';
import 'package:healthcare/core/common/widgets/svg_image.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/data/models/response/clients_details_response.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/src/auth/providers/auth_provider.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:healthcare/src/details/provider/patient_details_provider.dart';
import 'package:healthcare/src/details/screen/sign_or_record_screen.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import '../../../config/routes/routes.dart';
import '../../../core/data/models/requests/visits_reqs/clients_list_response.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/helper/loader.dart';
import '../../../core/helper/permission_helper.dart';
import '../../../core/utils/bottom_sheet_utils.dart';
import '../../../core/utils/gap.dart';
import '../../demo/screens/thanks_screen.dart';
import '../../home/providers/home_provider.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;

class PatientDetailsScreenRoute implements BaseRoute {
  const PatientDetailsScreenRoute(
      {required this.id,
      required this.clientId,
      required this.companyId,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.clientListResponse,
      required this.status,
      required this.imageUrl});

  final String id;
  final String clientId;
  final String companyId;
  final String name;
  final String imageUrl;
  final String startTime;
  final String endTime;
  final bool status;
  final ClientListResponse clientListResponse;

  @override
  Widget get screen => PatientDetailsScreen(params: this);

  @override
  Routes get routeName => Routes.patient;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class PatientDetailsScreen extends StatefulWidget {
  final PatientDetailsScreenRoute params;

  const PatientDetailsScreen({super.key, required this.params});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> with AutomaticKeepAliveClientMixin<PatientDetailsScreen> {
  @override
  bool get wantKeepAlive => true;

  bool firstBox = false;
  bool secondBox = false;
  bool thirdBox = false;
  bool fourthBox = false;

  bool firstBoxCheck = false;
  bool secondBoxCheck = false;
  bool thirdBoxCheck = false;
  bool fourthBoxCheck = false;

  String? time1 = "07:30";
  String? time2 = "08:30";
  String? time3 = "09:00";
  String? time4 = "10:15";
  String? finalTime = "";

  List<ClientDetails> allClientsDetails = [];

  // ClientDetails? clientDetails;
  ClientListResponse? clientDetails;
  String? endTime;
  int? isSelectedSingAudio = 0;

  final SignatureController _signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 5,
    exportBackgroundColor: Colors.transparent,
  );

  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool isPlaying = false;
  String _audioFilePath = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((p) async {
      showLoader(context);
      await Provider.of<PatientDetailsProvider>(context, listen: false).clearData(widget.params.status);
      await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id);
      if (widget.params.endTime.isNotEmpty) {
        endTime = widget.params.endTime;
      }
      hideLoader();
    });
    _initRecorder();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _audioRecorder.closeRecorder(); // closeAudioSession();
    _audioPlayer.closePlayer();
    super.dispose();
  }

  Future<void> configureAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  // Initialize the recorder
  Future<void> _initRecorder() async {
    if (Platform.isIOS) await configureAudioSession();
    await _audioRecorder.openRecorder();
    await _audioPlayer.openPlayer();

    // Request microphone permission
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    // await _audioRecorder.openRecorder(); // openAudioSession();
    // await Permission.microphone.request();
  }

  // Function to save the signature to a file
  Future<File?> saveSignature() async {
    try {
      // Convert signature to PNG bytes
      final signatureBytes = await _signatureController.toPngBytes();
      if (signatureBytes == null) {
        print("No signature to save.");
        return null;
      }

      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/signature${widget.params.id}.png';
      final signatureFile = File(filePath);

      // Write the bytes to the file
      await signatureFile.writeAsBytes(signatureBytes);

      print("Signature saved at: $filePath");
      return signatureFile;
    } catch (e) {
      print("Error saving signature: $e");
      return null;
    }
  }

  Future<void> _startRecording(StateSetter setStates) async {
    try {
      // Get the documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Define the file path for storing the recording
      _audioFilePath = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
      print("Recording will be saved at: $_audioFilePath");

      // Start the recorder
      await _audioRecorder.startRecorder(
        toFile: _audioFilePath,
        codec: fs.Codec.aacADTS,
      );

      setState(() {
        _isRecording = true;
      });
      setStates(() {});
      print("Recording started...");
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording(StateSetter setStates) async {
    try {
      // Stop the recorder
      await _audioRecorder.stopRecorder();
      print("Recording stopped. File saved at: $_audioFilePath");

      // Verify if the file exists
      final fileExists = await File(_audioFilePath).exists();
      print("File exists: $fileExists");

      setState(() {
        _isRecording = false;
      });
      setStates(() {});
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> togglePlayPause(StateSetter setStates) async {
    if (isPlaying) {
      await _audioPlayer.pausePlayer();
      // await _audioPlayers.pause();
    } else {
      // if (Platform.isAndroid) {
      await _audioPlayer.startPlayer(
        fromURI: _audioFilePath,
        codec: fs.Codec.aacADTS,
        whenFinished: () {
          setState(() {
            isPlaying = false;
          });
          setStates(() {});
        },
      );
      // }else{
      //   await _audioPlayer.startPlayer(
      //     fromURI: _audioFilePath,
      //     codec: Platform.isAndroid ?  fs.Codec.aacADTS : fs.Codec.aacADTS,
      //     whenFinished: () {
      //       setState(() {
      //         isPlaying = false;
      //       });
      //     },
      //   )
      // }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
    setStates(() {});
  }

  ClientDetails? getClientDetails(List<ClientDetails> clients, String clientId) {
    return clients.firstWhere((client) => client.clientID == clientId);
  }

  Future<List<ClientDetails>> loadClientsDetails() async {
    // Load the JSON file
    final String response = await rootBundle.loadString('assets/json/clients_details.json');
    // Decode the JSON data
    final List<dynamic> data = json.decode(response);
    // Map the JSON data to Client objects
    print("Data of Client  ${data.first}");
    return data.map((client) => ClientDetails.fromJson(client)).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: PopScope(canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          DemoProvider visit = Provider.of<DemoProvider>(context, listen: false);
          PatientDetailsProvider patient = Provider.of<PatientDetailsProvider>(context, listen: false);
          if(visit.taskDataTemp != null){
            visit.taskDataTemp = null;
            visit.notifyListeners();
          }
          if(!didPop){
            Future.delayed(Duration.zero,() {
              Navigator.pop(context);
            },);
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Consumer4<PatientDetailsProvider, DemoProvider, HomeProvider, AuthProvider>(builder: (context, patient, visit, home, auth, _) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if(visit.taskDataTemp != null){
                                    visit.taskDataTemp = null;
                                  }
                                Future.delayed(Duration.zero,() {
                                  Navigator.pop(context);
                                },);
                                },
                                child: Container(
                                  height: 3.4.h,
                                  width: 3.4.h,
                                  color: AppColors.bgColor,
                                  child: const Icon(Icons.keyboard_arrow_left),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     context.popUntil((route) => route.settings.name == Routes.home.path);
                              //   },
                              //   child: Padding(
                              //     padding: EdgeInsets.only(right: 1.w),
                              //     child: Icon(
                              //       Icons.home_filled,
                              //       size: 3.h,
                              //       color: AppColors.Primary,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        CustomImage(
                          url: widget.params.imageUrl != ""
                              ? "${auth.getImageBaseUrl().toString()}/images/avatars/${widget.params.imageUrl}"
                              : "${auth.getImageBaseUrl().toString()}/avatars.jpg",
                          height: 92,
                          width: 92,
                          fit: BoxFit.cover,
                        ),
                        /*  Image.asset(
                          AppImages.ic_demo_img,
                          height: 13.h,
                          width: 13.h,
                          fit: BoxFit.cover,
                        ),*/
                        VGap(2.h),
                        // Txt("${clientDetails?.client?.clientFirstName} ${clientDetails?.client?.clientMiddleInitial} ${clientDetails?.client?.clientLastName}", fontSize: 2.2.t, fontWeight: FontWeight.w600),
                        Txt(widget.params.name,
                            fontSize: 21, fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                        ),
                        VGap(0.3.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.hint_text_color_dark,
                              size: 2.2.h,
                            ),
                            HGap(1.w),
                            /*  Txt(clientDetails?.visitTime?.firstOrNull?.scheduleStartTime == null ? "--" :"${Formatter.stringDateFromString(clientDetails?.visitTime?.firstOrNull?.scheduleStartTime.toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "HH:mm:a")} - ${Formatter.stringDateFromString(clientDetails?.visitTime?.firstOrNull?.scheduleEndTime.toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "HH:mm:a")}",
                                  fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),*/
                            Txt(
                                patient.startTime == null
                                    ? "--"
                                    : "${Formatter.stringDateFromString(patient.startTime.toString().toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "hh:mm:a")} ${patient.endTime == null ? "-" : Formatter.stringDateFromString(patient.endTime.toString().toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "hh:mm:a")}",
                                fontSize: 12,
                                textColor: AppColors.hint_text_color_dark,
                                fontWeight: FontWeight.w400),
                          ],
                        ),
                        VGap(2.h),
                        //  if(home.clientData[0].providerIdentification?.name != null)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.bgColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Txt(
                                "Agency : ",
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              Expanded(
                                child: Txt(
                                  home.companyName ?? "",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.black,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 5.w),
                            ],
                          ),
                        ),
                        VGap(1.2.h),
                        if (patient.service != null)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.bgColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Txt(
                                "Service : ",
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              Expanded(
                                child: Txt(
                                  patient.service?.name ?? "",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.black,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 5.w),
                            ],
                          ),
                        ),

                        VGap(0.8.h),

                        VGap(2.h),
                        Visibility(
                          visible: patient.taskData.isNotEmpty,
                          child: Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...List.generate(
                                      patient.taskData.length,
                                      (index) => Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3.w),
                                                color: const Color(0xffF7F8F9),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 82,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.bgColor,
                                                      borderRadius: BorderRadius.circular(18),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 49,
                                                            height: 49,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(11),
                                                              color: AppColors.theme,
                                                            ),),
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),
                                                          Expanded(
                                                            child: Txt(
                                                              patient.taskData[index].taskReading ?? "",
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w400,
                                                              textColor: Colors.black,
                                                              maxLines: 2,
                                                              overFlow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  /*Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w), color: AppColors.home_card_color),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          HGap(1.w),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Txt(
                                                                  patient.taskData[index].taskReading ?? "",
                                                                  fontSize: 2.2.t,
                                                                  fontWeight: FontWeight.w600,
                                                                  maxLines: 2,
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                                VGap(0.5.h),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.watch_later_outlined,
                                                                      color: AppColors.hint_text_color_dark,
                                                                      size: 2.2.h,
                                                                    ),
                                                                    HGap(1.w),
                                                                    Txt("${Formatter.stringDateFromString(patient.taskData[index].createdAt.toString(), reqFormat: "yyyy-MM-dd' 'HH:mm:ss.SSS", resFormat: "hh:mm:a")}",
                                                                        fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),
                                                                  ],
                                                                ),
                                                                //   VGap(0.5.h),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),*/
                                                  AnimatedSize(
                                                    duration: const Duration(milliseconds: 300),
                                                    child: Visibility(
                                                      visible: firstBox,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 1.5.h,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(2.5.w),
                                                              border: Border.all(width: 0, color: const Color(0xff009DE0).withOpacity(0.06)),
                                                              color: const Color(0xff009DE0).withOpacity(0.06),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.all(3.5.h),
                                                              child: SvgImage(
                                                                SvgIcons.bathroom,
                                                                fit: BoxFit.fill,
                                                                size: 0.5.h,
                                                                color: AppColors.Primary,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 1.5.h,
                                                          ),
                                                          Txt(
                                                            time1 ?? "",
                                                            textColor: AppColors.grey,
                                                          ),
                                                          SizedBox(
                                                            height: 1.5.h,
                                                          ),
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                width: 30.w,
                                                                decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.grey), borderRadius: BorderRadius.circular(8.w)),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                                                  child: const Icon(
                                                                    Icons.close,
                                                                    color: AppColors.grey,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () async {
                                                                  if (!firstBoxCheck) {
                                                                    showLoader(context);
                                                                    await Future.delayed(const Duration(milliseconds: 600));
                                                                    hideLoader();
                                                                  }

                                                                  firstBoxCheck = true;
                                                                  setState(() {});
                                                                },
                                                                child: Container(
                                                                  width: 30.w,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(width: 1, color: firstBoxCheck ? AppColors.Primary : AppColors.grey), borderRadius: BorderRadius.circular(8.w)),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                                                    child: Icon(
                                                                      Icons.done,
                                                                      color: firstBoxCheck ? AppColors.Primary : AppColors.grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  firstBox
                                                      ? SizedBox(
                                                          height: 3.h,
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                          )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if(patient.taskData.isEmpty && visit.taskDataTemp != null)...[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                color: const Color(0xffF7F8F9),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 82,
                                    decoration: BoxDecoration(
                                      color: AppColors.bgColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 49,
                                            height: 49,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(11),
                                              color: AppColors.theme,
                                            ),),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: Txt(
                                              visit.taskDataTemp!.taskName ?? "",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black,
                                              maxLines: 2,
                                              overFlow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Visibility(
                                      visible: firstBox,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2.5.w),
                                              border: Border.all(width: 0, color: const Color(0xff009DE0).withOpacity(0.06)),
                                              color: const Color(0xff009DE0).withOpacity(0.06),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(3.5.h),
                                              child: SvgImage(
                                                SvgIcons.bathroom,
                                                fit: BoxFit.fill,
                                                size: 0.5.h,
                                                color: AppColors.Primary,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Txt(
                                            time1 ?? "",
                                            textColor: AppColors.grey,
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 30.w,
                                                decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.grey), borderRadius: BorderRadius.circular(8.w)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (!firstBoxCheck) {
                                                    showLoader(context);
                                                    await Future.delayed(const Duration(milliseconds: 600));
                                                    hideLoader();
                                                  }

                                                  firstBoxCheck = true;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 1, color: firstBoxCheck ? AppColors.Primary : AppColors.grey), borderRadius: BorderRadius.circular(8.w)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                                    child: Icon(
                                                      Icons.done,
                                                      color: firstBoxCheck ? AppColors.Primary : AppColors.grey,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  firstBox
                                      ? SizedBox(
                                    height: 3.h,
                                  )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.6.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !patient.statusData
                                    && (patient.taskData.isEmpty
                                    ? visit.taskDataTemp != null
                                    : patient.taskData.isNotEmpty),
                                child: Expanded(
                                  child: CustomElevatedButton(
                                    height: 58,
                                    alignment: Alignment.center,
                                    onTap: () async {
                                      if (patient.statusData) {
                                        showToast("Visit is already completed");
                                      } else {
                                        await PermissionHelper.askLocationPermission();
                                        bool isCheckLocation = await PermissionHelper.checkLocationPermission();
                                        log('isCheckLocation: $isCheckLocation');
                                        if(isCheckLocation){
                                         if(patient.taskData.isEmpty){
                                           await visit.visitTaskAddApi(context,
                                               clientId: widget.params.clientId,
                                               companyId: widget.params.companyId.toString(),
                                               visitId: widget.params.id);
                                         }
                                         if (patient.startTime == null) {
                                           Map<String, dynamic> location = await getCurrentLocation();
                                           showDateTimeBottomSheetstart(context,location);
                                         } else if (patient.endTime == null) {
                                           Map<String, dynamic> location = await getCurrentLocation();
                                           showDateTimeBottomSheet(context, patient.startTime,location);
                                         } else if (patient.startTime != null && patient.endTime != null) {
                                           _signatureController.clear();
                                           isSelectedSingAudio = 0;
                                           setState(() {});
                                           showSignOrRecordBottomSheet(context,visit);
                                           // await context.pushNamed(SignOrRecordRoute(id: widget.params.id, clientid: widget.params.clientId, endTime: patient.endTime.toString()));
                                         }
                                        }
                                      }
                                    },
                                    color: patient.statusData ? Colors.green.shade800 : AppColors.Primary,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(patient.startTime == null || patient.endTime == null)...[
                                          const AppImageAsset(image: AppIcons.ic_clock,
                                            height: 24,
                                            width: 24,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                        Txt(
                                          patient.startTime == null
                                              ? "Start Time"
                                              : patient.endTime == null
                                                  ? "End Time"
                                                  : "Visit Complete",
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if(patient.statusData && patient.taskData.isNotEmpty)...[
                                HGap(2.w),
                                Expanded(
                                  child: CustomElevatedButton(
                                    height: 58,
                                    alignment: Alignment.center,
                                    onTap: () async {
                                      if (patient.statusData) {
                                        showToast("Visit Already Completed");
                                      }
                                    },
                                    border: ButtonBorder(width: 1, color: patient.statusData ? Colors.green.shade800 : AppColors.lightSeaGreen,),
                                    color: patient.statusData ? Colors.green.shade800 : AppColors.lightSeaGreen,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add,color: AppColors.white,
                                          size: 25,
                                        ),
                                        HGap(2.w),
                                        const Txt("Visit Completed",
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              if(patient.taskData.isEmpty)...[
                                HGap(2.w),
                                Expanded(
                                  child: CustomElevatedButton(
                                    height: 58,
                                    alignment: Alignment.center,
                                    onTap: () async {
                                      if (patient.statusData) {
                                        showToast("Visit Already Completed");
                                      } else {
                                        await visit.taskListApi(context, companyId: widget.params.companyId, clientId: widget.params.clientId);

                                        await BottomSheetUtils.showTaskListSheet(context, visit.taskNames, widget.params.clientId, widget.params.companyId, widget.params.id);
                                      }
                                    },
                                    border: ButtonBorder(width: 1, color: patient.statusData ? Colors.green.shade800 : AppColors.lightSeaGreen,),
                                    color: patient.statusData ? Colors.green.shade800 : AppColors.lightSeaGreen,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add,color: AppColors.white,
                                          size: 25,
                                        ),
                                        HGap(2.w),
                                        Txt(
                                          patient.statusData ? "Visit Completed" : (visit.taskDataTemp != null ? "Change Task" : "Add Task"),
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],

                              /* HGap(5.w),
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5.w), border: Border.all(width: 1, color: Color(0xffF4F5F9)), color: Color(0xffF4F5F9)),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.4.h),
                                    child: Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )*/
                            ],
                          ),
                        ),
                        VGap(2.h),
                        // ...List.generate(4, (index) => Padding(
                        //   padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                        //   child: GestureDetector(onTap: () {
                        //   //  context.pushNamed(PatientDetailsScreenRoute());
                        //   },child: PatientDetailsWidget()),
                        // )),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  // closeAllBox(){
  //   firstBox = false;
  //   secondBox = false;
  //   thirdBox = false;
  //   fourthBox = false;
  //
  // }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w))),
      context: context,
      builder: (BuildContext ctx) {
        return SizedBox(
          // height: 60.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Txt(
                "Set your start time",
                fontWeight: FontWeight.bold,
                fontSize: 2.t,
              ),
              SizedBox(
                height: 2.h,
              ),
              Txt(
                "Pick a time of the day, when you would \nstart working and you can stop when \nyou are done",
                fontSize: 1.6.t,
                textAlign: TextAlign.center,
                textColor: AppColors.grey,
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    "09:45",
                    fontSize: 2.4.t,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  HGap(1.w),
                  Txt(
                    "AM",
                    fontSize: 2.2.t,
                    textAlign: TextAlign.center,
                    textColor: AppColors.grey,
                  ),
                ],
              ),
              VGap(2.h),
              SizedBox(
                  height: 15.h,
                  width: 100.w,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newDate) {
                      print("new data : ${newDate.hour} : ${newDate.minute}");
                      finalTime = "${newDate.hour}:${newDate.minute}";
                      setState(() {});
                    },
                  )),
              SizedBox(
                height: 2.h,
              ),
              CustomElevatedButton(
                width: 50.w,
                onTap: () {
                  if (firstBox) {
                    time1 = finalTime;
                  } else if (secondBox) {
                    time2 = finalTime;
                  } else if (thirdBox) {
                    time3 = finalTime;
                  } else {
                    time4 = finalTime;
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
                color: AppColors.Primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 3.w),
                  child: Txt(
                    "Start",
                    textAlign: TextAlign.center,
                    textColor: Colors.white,
                    fontSize: 1.9.t,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Current Location

  Future<Map<String, dynamic>> getCurrentLocation() async {
    showLoader(context);
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String address =
        '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    log('address: $address');
    log('latitude: ${position.latitude}');
    log('longitude: ${position.longitude}');
    hideLoader();
    return {
      'address': address,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString()
    };
  }

  /// Select Time
  ///
  Future<void> showDateTimeBottomSheet(BuildContext context, DateTime? startdate, Map<String, dynamic> location) async {
    DateTime? startDateTime;
    DateTime? endDateTime;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Txt(
                    "Select Visit End Time",
                    fontSize: 2.t,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    height: 58,
                    width: 200,
                    alignment: Alignment.center,
                    onTap: () async {
                      // DateTime? selectedDate =
                      //     await _selectDate(context, startdate!);
                      // if (selectedDate != null) {
                      TimeOfDay? selectedTime = await _selectTime(context, minTime: startdate);
                      if (selectedTime != null) {
                        setState(() {
                          startDateTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );

                          // Reset endDateTime if it is earlier than startDateTime
                          if (endDateTime != null && endDateTime!.isBefore(startDateTime!)) {
                            endDateTime = null;
                          }
                        });
                      }
                      // }
                    },
                    radius: BorderRadius.circular(15),
                    border: ButtonBorder(width: 1, color: AppColors.Primary,),
                    color:  AppColors.Primary,
                    child: Txt(
                      startDateTime == null
                          ? "Select End Time"
                          : "End: ${DateFormat('hh:mm').format(startDateTime!)} ${DateFormat(' a').format(startDateTime!)}",
                      fontWeight: FontWeight.w600,
                      textColor: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            height: 58,
                            alignment: Alignment.center,
                            onTap: () async {
                              Navigator.of(context).pop();
                            },
                            radius: BorderRadius.circular(15),
                            border: ButtonBorder(width: 1, color: AppColors.Primary,),
                            color:  AppColors.Primary,
                            child: const Txt(
                              "Cancel",
                              fontWeight: FontWeight.w600,
                              textColor: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomElevatedButton(
                            height: 58,
                            alignment: Alignment.center,
                            onTap: () async {
                              if (startDateTime != null) {
                                //  print("Start: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!)}");
                                // print("End: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!)}");

                                // final startTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!);

                                final endTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!);
                                await Provider.of<DemoProvider>(context,
                                        listen: false)
                                    .visitEndApi(
                                        visitId: widget.params.id.toString(),
                                        endTime: endTime,
                                location: location
                                );
                                await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id,isEndTime: true);

                                Navigator.of(context).pop();
                                //await context.pushNamed(SignOrRecordRoute(id: widget.params.id, clientid: widget.params.clientId,endTime: endTime));
                              } else {
                                showToast("Select End Date & Time");
                              }
                            },
                            radius: BorderRadius.circular(15),
                            border: ButtonBorder(width: 1, color: AppColors.Primary,),
                            color:  AppColors.Primary,
                            child: const Txt(
                              "End time",
                              fontWeight: FontWeight.w600,
                              textColor: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context, {DateTime? minTime}) async {
    final now = DateTime.now();
    // final selectedTime = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.fromDateTime(now),
    // );
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              surfaceTint: Colors.white,
              primary: AppColors.lightSeaGreen,
              onPrimary: const Color(0xFFE6ECFA),
              secondary: AppColors.lightSeaGreen.withAlpha(20),
              onSecondary: AppColors.lightSeaGreen,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lightSeaGreen, // Your appLightBlue
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              dialBackgroundColor: const Color(0xFF212121).withAlpha(20),
              dialHandColor: AppColors.lightSeaGreen,
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.lightSeaGreen;
                }
                return Colors.black87;
              }),
              hourMinuteColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.lightSeaGreen.withAlpha(20);
                }
                return const Color(0xFF212121).withAlpha(20);
              }),
              hourMinuteTextStyle: const TextStyle(
                fontSize: 43,
                fontWeight: FontWeight.w400,
              ),
              dayPeriodTextStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              dayPeriodBorderSide: const BorderSide(
                color: Color(0xFFDADCE0),
                width: 1,
              ),
              helpTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff717370),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (minTime != null && selectedTime != null) {
      final selectedDateTime = DateTime(
        minTime.year,
        minTime.month,
        minTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isBefore(minTime)) {
        showToast("Cannot select a time earlier than the allowed time.");
        return null;
      }
    }

    return selectedTime;
  }

  /// Select Time
  ///
  Future<void> showDateTimeBottomSheetstart(BuildContext context, Map<String, dynamic> location) async {
    DateTime? startDateTime = DateTime.now();
    DateTime? endDateTime;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.clear,
                            color: AppColors.black,
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const AppImageAsset(image: AppIcons.ic_clock,height: 36,width: 36,
                    color: AppColors.appGreyWithWhite,),
                  const SizedBox(height: 12),
                  const Txt(
                    "This is your start time for the task",
                    fontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Txt(
                  //       "Selected Service Name : ",
                  //       fontSize: 1.9.t,
                  //       textAlign: TextAlign.center,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     Txt(
                  //       "${visit.selectedService == null ? visit.serviceList.first.name ?? "" : visit.selectedService.name ?? ""}",
                  //       fontSize: 1.9.t,
                  //       textAlign: TextAlign.center,
                  //     )
                  //   ],
                  // ),
                  Container(
                    // decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(4),
                    //     border: Border.all(color: Colors.black)),
                    margin: EdgeInsets.all(2.w),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric( horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            style: TextStyle(fontWeight: FontWeight.w700,
                            fontFamily: HurmeGeometricSans1,
                              fontSize: 30
                            ),
                            startDateTime == null
                                ? "Select Start Date & Time"
                                : DateFormat('hh:mm').format(startDateTime),
                          ),
                          Text(
                            style: TextStyle(fontWeight: FontWeight.w400,
                            fontFamily: HurmeGeometricSans1,
                              fontSize: 20,
                              color: AppColors.appGrey
                            ),
                            startDateTime == null
                                ? ""
                                : DateFormat(' a').format(startDateTime),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  /* ElevatedButton(
                      onPressed: startDateTime == null
                          ? null
                          : () async {
                              DateTime? selectedDate = await _selectDate(context, startDateTime!);
                              if (selectedDate != null) {
                                TimeOfDay? selectedTime = await _selectTime(
                                  context,
                                  minTime: selectedDate.isSameDate(startDateTime!) ? startDateTime : null,
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    endDateTime = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );
                                  });
                                }
                              }
                            },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Text(
                          endDateTime == null ? " Select End Date & Time " : "End: ${DateFormat('yyyy-MM-dd hh:mm a').format(endDateTime!)}",
                        ),
                      ),
                    ),
                    SizedBox(height: 16),*/
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CustomElevatedButton(
                      height: 58,
                      alignment: Alignment.center,
                      onTap: () async {
                        print("Start: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime)}");
                        // print("End: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!)}");

                        final startTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime);
                        // final endTime = DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!);
                        await Provider.of<DemoProvider>(context, listen: false)
                            .visitStartApi(
                                visitId: widget.params.id,
                                startTime: startTime,
                         location: location
                        );
                        await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id,isStartTime: true);
                        Navigator.of(context).pop();
                      },
                      radius: BorderRadius.circular(15),
                      border: ButtonBorder(width: 1, color: AppColors.Primary,),
                      color:  AppColors.Primary,
                      child: const Txt(
                        "Start time",
                        fontWeight: FontWeight.w600,
                        textColor: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          print("Start: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime)}");
                          // print("End: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!)}");

                          final startTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime);
                          // final endTime = DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!);
                          await Provider.of<DemoProvider>(context, listen: false).visitStartApi(visitId: widget.params.id, startTime: startTime);
                          await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id);
                          Navigator.of(context).pop();
                                                },
                        child: const Text("Start Visit"),
                      ),
                    ],
                  ),*/
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<DateTime?> _selectDatestart(BuildContext context, DateTime initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _selectTimestart(BuildContext context, {DateTime? minTime}) async {
    final now = DateTime.now();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(minTime ?? now),
    );

    if (minTime != null && selectedTime != null) {
      final selectedDateTime = DateTime(
        minTime.year,
        minTime.month,
        minTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isBefore(minTime)) {
        showToast("Cannot select a time earlier than the allowed time.");
        return null;
      }
    }

    return selectedTime;
  }

  showSignOrRecordBottomSheet(BuildContext context, DemoProvider visit) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStates) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Container(height: 4,width: 36, color: AppColors.dot_dark),
                    const SizedBox(height: 20),
                    const Txt(
                      "Signature & Audio Recording",
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 16),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(onTap: () {
                          isSelectedSingAudio = 0;
                          setStates(() {});
                        },
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelectedSingAudio == 0
                                  ? AppColors.appDark
                                  : AppColors.appLight
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageAsset(image: AppIcons.ic_signature,
                                  color: isSelectedSingAudio == 0
                                      ? null
                                      : AppColors.appHint,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        InkWell(onTap: () {
                          isSelectedSingAudio = 1;
                          setStates(() {});
                        },
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelectedSingAudio == 1
                                  ? AppColors.appDark
                                  : AppColors.appLight
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageAsset(image: AppIcons.ic_microphone,
                                 color: isSelectedSingAudio == 1
                                      ? null
                                      : AppColors.appHint,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if(isSelectedSingAudio == 0)...[
                      Signature(
                        controller: _signatureController,
                        height: 350,
                        backgroundColor: AppColors.white,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(onTap: () {
                              _signatureController.clear();
                              setStates(() {});
                            },
                              child: const Icon(Icons.clear,
                                color: AppColors.appHint,),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: AppColors.appHintLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                    else...[
                      const SizedBox(height: 20),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!_isRecording && _audioFilePath.isNotEmpty)...[
                            InkWell(
                                onTap:() {
                                  togglePlayPause(setStates);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const AppImageAsset(
                                        image: AppIcons.ic_start_rec),
                                    isPlaying
                                        ? const Icon(Icons.pause,color: AppColors.white,)
                                        : const Icon(Icons.play_arrow,color: AppColors.white,)
                                  ],
                                )),
                            const SizedBox(width: 20),
                          ],
                          InkWell(
                              onTap:() {
                                if(_isRecording){
                                  _stopRecording(setStates);
                                }else{
                                  _startRecording(setStates);
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const AppImageAsset(
                                      image: AppIcons.ic_start_rec),
                                  _isRecording
                                      ? const Icon(Icons.mic,color: AppColors.white,)
                                      : const Icon(Icons.mic_off,color: AppColors.white,)
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(onTap: () {
                              _audioFilePath = '';
                              _isRecording = false;
                              isPlaying = false;
                              setStates(() {});
                            },
                              child: const Icon(Icons.clear,
                                color: AppColors.appHint,),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: AppColors.appHintLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: CustomElevatedButton(
                        height: 40,
                        width: 109,
                        alignment: Alignment.center,
                        onTap: () async {
                          if(isSelectedSingAudio == 0){
                            final sign = await saveSignature();

                            if (sign == null) {
                              showToast("Your signature is required");
                            } else {
                              await visit.addSignatureApi(context, widget.params.clientId, visitId: widget.params.id, signature: sign,endTime: widget.params.endTime);

                              _signatureController.clear();
                            }
                          }else{
                            if (_audioFilePath.isNotEmpty) {
                              await visit.sentAudioFileApi(visitId: widget.params.id, audioFile: File(_audioFilePath));
                            } else {
                              showToast("Please record audio");
                            }
                          }
                        },
                        radius: BorderRadius.circular(11),
                        border: ButtonBorder(width: 1, color: AppColors.Primary,),
                        color:  AppColors.Primary,
                        child: const Txt(
                          "Submit",
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  /*  InkWell(onTap: () async {
                      showLoader(context);
                      await Provider.of<PatientDetailsProvider>(context, listen: false).visitStatusApi(context, widget.params.clientId, visitId: widget.params.id,endDate: widget.params.endTime);
                      hideLoader();
                    },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            color: AppColors.hint_text_color_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),*/
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}