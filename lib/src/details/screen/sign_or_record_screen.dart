import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import 'package:healthcare/config/routes/app_router/route_params.dart';

import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/helper/loader.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/common_toast.dart';

import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';


import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:signature/signature.dart';

import '../../../config/routes/routes.dart';

import '../../../core/utils/gap.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;

import '../provider/patient_details_provider.dart';

class SignOrRecordRoute implements BaseRoute {
  const SignOrRecordRoute({required this.id, required this.clientid,required this.endTime});

  final String id;
  final String clientid;
  final String endTime;

  @override
  Widget get screen => SignOrRecordScreen(params: this);

  @override
  Routes get routeName => Routes.sign;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class SignOrRecordScreen extends StatefulWidget {
  final SignOrRecordRoute params;

  const SignOrRecordScreen({super.key, required this.params});

  @override
  State<SignOrRecordScreen> createState() => _SignOrRecordScreenState();
}

class _SignOrRecordScreenState extends State<SignOrRecordScreen> with AutomaticKeepAliveClientMixin<SignOrRecordScreen> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  // late AudioPlayer _audioPlayers;
  // Signature Controller
  final SignatureController _signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 5,
    exportBackgroundColor: Colors.transparent,
  );

  // Audio Recorder
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool isPlaying = false;
  String _audioFilePath = '';

  @override
  void initState() {
    super.initState();
    _initRecorder();
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

  // Start recording
  /*Future<void> _startRecording() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      _audioFilePath = '${tempDir.path}/audio_recording_${widget.params.id}.aac';
      await _audioRecorder.startRecorder(toFile: _audioFilePath);
    }else{

      // final byteData = await rootBundle.load('assets/audio/song1.mp3');

      // Get a temporary directory and save the file
      final tempDir = await getApplicationDocumentsDirectory();
      final file = File('${tempDir.path}/song4.aac');
      // await file.writeAsBytes(byteData.buffer.asUint8List());
      _audioFilePath = file.path;
      await Future.delayed(Duration(milliseconds: 300));
      // _audioFilePath = '${tempDir.path}/audio_record_${widget.params.id}.aac';
      await _audioRecorder.startRecorder(toFile: _audioFilePath,codec: fs.Codec.aacMP4);

      print("iOS Device Audio Path : >> ${_audioFilePath.toString()}");
    }

    setState(() {
      _isRecording = true;
    });
  }*/

  //
  Future<void> _startRecording() async {
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
      print("Recording started...");
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
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
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  // Stop recording
  /* Future<void> _stopRecording() async {
    await _audioRecorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }*/

  Future<void> togglePlayPause() async {
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
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _audioRecorder.closeRecorder(); // closeAudioSession();
    _audioPlayer.closePlayer();
    // _audioPlayers.dispose();// Clean up the player
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.Primary,
            title: const Text('Signature & Audio Recording'),
          ),
          body: Consumer2<DemoProvider, HomeProvider>(builder: (context, signature, home, _) {
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  VGap(1.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(
                        "Agency : ",
                        fontSize: 2.t,
                        fontWeight: FontWeight.w600,
                      ),
                      Txt(
                        home.companyName ?? "",
                        fontSize: 2.t,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.black,
                      )
                    ],
                  ),
                  VGap(1.5.h),
                  TabBar(labelColor: AppColors.Primary, labelStyle: TextStyle(fontSize: 2.2.t, fontWeight: FontWeight.bold), indicatorColor: AppColors.Primary, tabs: const [
                    Tab(text: 'Signature'),
                    Tab(text: 'Audio Recording'),
                  ]),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // Signature Tab
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Signature(
                                  controller: _signatureController,
                                  height: 400,
                                  backgroundColor: Colors.grey[200]!,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _signatureController.clear();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Txt(
                                          'Clear',
                                          fontSize: 2.t,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    HGap(3.w),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final sign = await saveSignature();

                                        if (sign == null) {
                                          showToast("Your signature is required");
                                        } else {
                                          await signature.addSignatureApi(context, widget.params.clientid, visitId: widget.params.id, signature: sign,endTime: widget.params.endTime);

                                          _signatureController.clear();
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Txt(
                                          'Visit Submit',
                                          fontSize: 2.t,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                ElevatedButton(
                                  onPressed: () async {
                                    showLoader(context);
                                    await Provider.of<PatientDetailsProvider>(context, listen: false).visitStatusApi(context, widget.params.clientid, visitId: widget.params.id,endDate: widget.params.endTime);
                                    hideLoader();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Txt(
                                      "Skip Signature",
                                      fontSize: 2.t,
                                      textColor: Colors.white,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Audio Recording Tab
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!_isRecording && _audioFilePath.isNotEmpty)
                                  ElevatedButton(
                                    onPressed: togglePlayPause,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Txt(isPlaying ? "Pause" : "Play", fontSize: 2.t, textColor: Colors.white, textAlign: TextAlign.center, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                Text(_isRecording ? 'Recording...' : 'Press to Start Recording'),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _isRecording ? _stopRecording : _startRecording,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Txt(_isRecording ? 'Stop Recording' : 'Start Recording', fontSize: 2.t, textColor: Colors.white, textAlign: TextAlign.center, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                if (!_isRecording && _audioFilePath.isNotEmpty)
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () async {
                                          print('Play audio');
                                          if (_audioFilePath.isNotEmpty) {
                                            await signature.sentAudioFileApi(visitId: widget.params.id, audioFile: File(_audioFilePath));
                                          } else {
                                            showToast("Please Start Recording");
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Txt('Submit Audio', fontSize: 2.t, textColor: Colors.white, textAlign: TextAlign.center, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
