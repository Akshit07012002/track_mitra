import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_mitra/utils/colours.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  String deptName = 'Select Department';
  String fileName = '';
  String filePath = '';
  bool isLoading = false;
  bool cancelledSelect = false;
  int itemNum = 0;
  PlatformFile? pickedFile;
  List<String> fileNames = [];
  List<int> fileSizes = [];
  List<String> filePaths = [];
  int pages = 0;
  int indexPage = 0;
  String pageText = 'Page 1';

  List<List<dynamic>> _data = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    // final rawData = await rootBundle.loadString(pickedFile!.path!);
    final csvFile = File(pickedFile!.path!).openRead();
    List<List<dynamic>> listData = await csvFile
        .transform(utf8.decoder)
        .transform(
          const CsvToListConverter(
              // shouldParseNumbers: true,
              ),
        )
        .toList();
    // const CsvToListConverter().convert(rawData);
    // List<List<dynamic>> listData = const CsvToListConverter().convert(pickedFile!.path!);
    print(listData[0]);
    setState(() {
      _data = listData;
    });
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      // allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        itemNum++;
        // type = fileNames.elementAt(0).split('.');
        // print('department : $deptName');
        // print("itemNum : $itemNum  ");
        pickedFile = result.files.first;
        for (var element in result.files) {
          print(element.name);
        }
      });
      List<File> files = result.paths.map((path) => File(path!)).toList();
      // PlatformFile file = result.files.first;

      fileNames.add(pickedFile!.name);
      fileSizes.add(pickedFile!.size);
      filePaths.add(pickedFile?.path ?? '');
      filePath = pickedFile!.path!;
      fileName = pickedFile!.name;
      print('Name: ${pickedFile!.name}');
      print('Size: ${pickedFile!.size}');
      print('Extension: .${pickedFile!.extension}');
      print('Path: ${pickedFile!.path}');
    } else {
      // User canceled the picker
      print("Canceled");
      setState(() {
        cancelledSelect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text(
          'T R A C K     M I T R A',
          style: GoogleFonts.rubik(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        toolbarHeight: screenHeight * 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              screenWidth * 0.08,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.only(
              top: screenWidth * 0.09,
              bottom: screenWidth * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.028),
                child: Container(
                  // color: const Color.fromARGB(255, 166, 170, 212),
                  color: Colors.black12,
                  height: screenHeight * 0.08,
                  // width: screenWidth * 0.9,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: (fileName == '')
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          (fileName != '') ? 'Selected File : ' : '',
                          style: GoogleFonts.cabin(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          (fileName == '') ? 'No File Selected' : fileName,
                          style: GoogleFonts.cabin(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.clip,
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
              //   child: TextFormField(
              //     controller: nameController,
              //     decoration: InputDecoration(
              //       labelText: 'File Name',
              //       labelStyle: GoogleFonts.cabin(
              //         fontSize: screenWidth * 0.05,
              //         fontWeight: FontWeight.w600,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(screenWidth * 0.02),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: screenWidth * 0.04),
              //   child: TextFormField(
              //     controller: descController,
              //     decoration: InputDecoration(
              //       labelText: 'File Description',
              //       labelStyle: GoogleFonts.cabin(
              //         fontSize: screenWidth * 0.05,
              //         fontWeight: FontWeight.w600,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(screenWidth * 0.02),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenWidth * 0.07, bottom: screenWidth * 0.04),
                child: SizedBox(
                  height: screenHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                          // Palette.kToDark[700],
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                            pickedFile = null;
                          });
                          await getFile();

                          print('Button Hit. $isLoading');
                          print('itemNum: $itemNum');
                          print('Name: ${pickedFile!.name}');
                          print('Size: ${pickedFile!.size}');
                          print('Extension: .${pickedFile!.extension}');
                          print('Path: ${pickedFile!.path}');

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Text(
                          'Select File',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // upload button
                      if (pickedFile != null)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            // final url2 = uploadFile().toString();
                            // documentFileUpload(url2);
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "File Converted!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cabin(),
                                  ),
                                ),
                              );
                            });
                            _loadCSV();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text(
                            'Convert File',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              (filePath == '' || pickedFile == null)
                  ? (isLoading && !cancelledSelect)
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.04),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.028),
                            child: Container(
                              height: screenHeight * 0.4,
                              color: Colors.black12,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_copy_outlined,
                                        size: screenWidth * 0.3),
                                    Text(
                                      'File Preview',
                                      style: GoogleFonts.cabin(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                  : (pickedFile!.extension == 'csv')
                      ? SizedBox(
                          height: screenHeight * 0.6,
                          child: ListView.builder(
                            itemCount: _data.length,
                            itemBuilder: (_, index) {
                              return Card(
                                margin: const EdgeInsets.all(3),
                                color: index == 0
                                    ? Palette.kToDark[00]
                                    : Colors.white,
                                child: ListTile(
                                  leading: Text(
                                    _data[index][0].toString(),
                                    style: GoogleFonts.cabin(
                                      fontWeight: FontWeight.bold,
                                      fontSize: index == 0
                                          ? screenWidth * 0.05
                                          : screenWidth * 0.03,
                                      color: index == 0
                                          ? Colors.white
                                          : Palette.kToDark[700],
                                    ),
                                  ),
                                  title: Text(
                                    _data[index][1].toString(),
                                    style: GoogleFonts.cabin(
                                      fontWeight: FontWeight.bold,
                                      fontSize: index == 0
                                          ? screenWidth * 0.05
                                          : screenWidth * 0.03,
                                      color: index == 0
                                          ? Colors.white
                                          : Palette.kToDark[700],
                                    ),
                                  ),
                                  trailing: Text(
                                    _data[index][2].toString(),
                                    style: GoogleFonts.cabin(
                                      fontWeight: FontWeight.bold,
                                      fontSize: index == 0
                                          ? screenWidth * 0.05
                                          : screenWidth * 0.03,
                                      color: index == 0
                                          ? Colors.white
                                          : Palette.kToDark[700],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.04),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            child: Image.file(
                              semanticLabel: fileName,
                              // height: screenHeight * 0.55,
                              File(filePath),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
