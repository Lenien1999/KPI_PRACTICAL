import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpie_practical/utils/screen_size.dart';
import 'package:kpie_practical/utils/text_style.dart';
import 'package:kpie_practical/widgets/app_bar.dart';
import 'package:kpie_practical/widgets/text_Field_widget.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to manage form validation
  final _vehicleName = TextEditingController();
  final _vehicleModel = TextEditingController();
  final _vehicleColor = TextEditingController();
  final _vehicleValue = TextEditingController();
  final _vehicleRegistration = TextEditingController();
  final _chasisNum = TextEditingController();
  File? _frontViewImage;
  File? _backViewImage;
  File? _sideViewImage;
  File? _topViewImage;
  File? _insuranceFile;
  File? _driversLicenseImage;
  File? _proofOwnership;

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage(String label) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        switch (label) {
          case "Front view":
            _frontViewImage = File(pickedFile.path);
            break;
          case "Back view":
            _backViewImage = File(pickedFile.path);
            break;
          case "Side view":
            _sideViewImage = File(pickedFile.path);
            break;
          case "Top view":
            _topViewImage = File(pickedFile.path);
            break;
          case "Proof of Ownership":
            _proofOwnership = File(pickedFile.path);
            break;
          case "driver's license":
            _driversLicenseImage = File(pickedFile.path);
            break;
        }
      });
    }
  }

  // Function to pick a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['doc', 'pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _insuranceFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(imagePath: 'assets/images/guliva_header.png'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Vehicle',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                _buildSubtitle('Type of vehicle', context),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: [
                    'Private',
                    'Commercial',
                  ] // Add your vehicle types here
                      .map((String vehicleType) {
                    return DropdownMenuItem<String>(
                      value: vehicleType,
                      child: Text(vehicleType),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle change
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),

                _buildSubtitle("Name of vehicle", context),
                CustomTextInput(
                  controller: _vehicleName,
                  hintText: 'e.g. Benz AL340',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle name is required';
                    }
                    return null;
                  },
                ),

                // Model (TextFormField)
                _buildSubtitle("Model", context),
                CustomTextInput(
                  controller: _vehicleModel,
                  hintText: 'e.g. AL340',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Model is required';
                    }
                    return null;
                  },
                ),

                // Color (TextFormField)
                _buildSubtitle("Color", context),
                CustomTextInput(
                  controller: _vehicleColor,
                  hintText: 'e.g. black',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Color is required';
                    }
                    return null;
                  },
                ),
 
                _buildSubtitle("Year", context),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Year',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: ['2020', '2019', '2018']  
                      .map((String year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle change
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a year';
                    }
                    return null;
                  },
                ),

                // Value of vehicle (TextFormField)
                _buildSubtitle("Value of Vehicle", context),
                CustomTextInput(
                  controller: _vehicleValue,
                  hintText: '₦',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle value is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),

                // Vehicle registration (TextFormField)
                _buildSubtitle("Vehicle registration No.", context),
                CustomTextInput(
                  controller: _vehicleRegistration,
                  hintText: 'e.g. ABC123DE',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle registration is required';
                    }
                    return null;
                  },
                ),
                _buildSubtitle("Chasis number.", context),
                CustomTextInput(
                  controller: _chasisNum,
                  hintText: 'e.g. KTU34NN',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle registration is required';
                    }
                    return null;
                  },
                ),
                _buildSubtitle('Mode of Insurance', context),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: [
                    'Pay per trip',
                    'Pay per month(odometer)',
                  ] // Add your vehicle types here
                      .map((String insuranceType) {
                    return DropdownMenuItem<String>(
                      value: insuranceType,
                      child: Text(insuranceType),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle change
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a Insurance type';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildImagePlaceholder(
                            "Front view", _frontViewImage)),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _buildImagePlaceholder(
                            "Back view", _backViewImage)),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildImagePlaceholder(
                            "Side view", _sideViewImage)),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child:
                            _buildImagePlaceholder("Top view", _topViewImage)),
                  ],
                ),

                const SizedBox(height: 20),

                // Upload insurance certificate
                const Text(
                    'Upload 3rd party insurance certificate if you already have a cover'),
                const SizedBox(height: 8),
                _buildUploadButton("Upload file (DOC, PDF)", _insuranceFile,
                    () {
                  _pickFile();
                }),

                const SizedBox(height: 20),

                // Upload driver's license
                const Text('Upload driver\'s license'),
                const SizedBox(height: 8),
                _buildUploadButton("Upload image", _driversLicenseImage, () {
                  _pickImage("driver's license");
                }),

                const SizedBox(height: 20),
                const Text('Upload proof of ownership'),
                const SizedBox(height: 8),
                _buildUploadButton("Upload image", _driversLicenseImage, () {
                  _pickImage("Proof of Ownership");
                }),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity, // Make button full-width
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       
                      } else {
                        // Show validation error as a toast
                        Fluttertoast.showToast(
                          msg: "Please fill in the required details",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor:
                          const Color.fromARGB(255, 3, 33, 131), // Button color
                    ),
                    child: Text(
                      'Submit',
                      style: appStyle(
                          color: Colors.white, size: 14, fw: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenHeight(context) * 0.02),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 105, 104, 104),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  // Widget to build image upload placeholders
  Widget _buildImagePlaceholder(String label, File? imageFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: () {
              _pickImage(label);
            },
            child: DottedBorder(
              color: Colors.grey, // The color of the border
              strokeWidth: 1, // Thickness of the border
              dashPattern: const [
                6,
                3
              ], // Length of the dash and space between dashes
              borderType: BorderType.RRect,
              radius:
                  const Radius.circular(8), // Border radius for rounded corners
              child: Container(
                height: ScreenHeight(context) * 0.2,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: imageFile != null
                    ? Image.file(imageFile,
                        fit: BoxFit.cover, height: 100, width: 100)
                    : const Icon(Icons.camera_alt,
                        size: 40, color: Color.fromARGB(255, 3, 33, 131)),
              ),
            )),
      ],
    );
  }

  Widget _buildUploadButton(String label, File? file, VoidCallback onPressed) {
    return SizedBox(
      height: 60,
      child: DottedBorder(
        color: Colors.grey, // The color of the border
        strokeWidth: 1, // Thickness of the border
        dashPattern: const [
          6,
          3
        ], // Length of the dash and space between dashes
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: Center(
          child: Container(
            height: 40,
            width: ScreenWidth(context) * 0.4,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                // padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  file != null
                      ? const Icon(Icons.check,
                          color: Color.fromARGB(255, 7, 32, 145))
                      : Container(),
                  const SizedBox(width: 8),
                  Text(label,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 7, 32, 145))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
