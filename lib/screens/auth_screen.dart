import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kpie_practical/utils/text_style.dart';
import 'package:kpie_practical/widgets/app_bar.dart';
import 'package:kpie_practical/widgets/social_login_button.dart';
import 'package:kpie_practical/widgets/text_Field_widget.dart';
import '../utils/screen_size.dart';
import 'vehicle_list_screen.dart';

class AuthScreen extends StatefulWidget {
  final bool isSignUp;
  const AuthScreen({super.key, required this.isSignUp});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          imagePath: "assets/images/guliva_header.png",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildTitle(),
              Center(
                child: _buildSubtitle(
                  widget.isSignUp ? "SIGN UP WITH..." : "LOG IN WITH...",
                  context,
                ),
              ),
              const SocialLoginButtons(),
              Center(
                child: _buildSubtitle(
                  widget.isSignUp ? "SIGN UP WITH EMAIL" : "LOG IN WITH EMAIL",
                  context,
                ),
              ),
              Form(
                key: _formKey,
                child: _buildLoginForm(),
              ),
              if (!widget.isSignUp) _buildForgotPassword(),
              SizedBox(height: ScreenHeight(context) * 0.02),
              if (widget.isSignUp) _buildAgreedTerms(),
              _buildLoginButton(context),
              if (!widget.isSignUp) _buildFingerprintImage(context),
              if (!widget.isSignUp)
                Center(child: _buildSubtitle("Touch / Face ID", context)),
              SizedBox(height: ScreenHeight(context) * 0.02),
              _buildSignUpText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgreedTerms() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(color: Colors.red),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigation logic for Terms & Conditions
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(color: Colors.red),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigation logic for Privacy Policy
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.isSignUp ? "Sign Up" : "Log In",
      style: appStyle(
        color: Colors.black,
        fw: FontWeight.bold,
        size: 13,
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

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isSignUp) _buildSubtitle("First Name", context),
        if (widget.isSignUp)
          CustomTextInput(
            controller: _firstName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First Name is required';
              }
              return null;
            },
          ),
        if (widget.isSignUp) _buildSubtitle("Last Name", context),
        if (widget.isSignUp)
          CustomTextInput(
            controller: _lastName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last Name is required';
              }
              return null;
            },
          ),
        if (widget.isSignUp) _buildSubtitle("Phone Number", context),
        if (widget.isSignUp)
          CustomTextInput(
            controller: _phoneNumber,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone Number is required';
              }
              return null;
            },
          ),
        _buildSubtitle("Email Address", context),
        CustomTextInput(
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        if (widget.isSignUp) _buildSubtitle("Date of Birth", context),
        if (widget.isSignUp)
          CustomTextInput(
            suffixIcon: IconButton(
              onPressed: _selectDate, // Call the date picker method
              icon: const Icon(Icons.calendar_month),
            ),
            controller: _dob,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'DOB is required';
              }

              return null;
            },
          ),
        _buildSubtitle("Password", context),
        CustomTextInput(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: Icon(isVisible ? Icons.remove_red_eye : Icons.visibility_off),
          ),
          visible: !isVisible,
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _dob.text =
            DateFormat('yyyy-MM-dd').format(selectedDate); // Format date
      });
    }
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          // Forgot password functionality
        },
        child: Text(
          "Forgot Password?",
          style: appStyle(
            color: Colors.redAccent,
            size: 14,
            fw: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: ScreenWidth(context),
      color: _isChecked || !widget.isSignUp
          ? const Color.fromARGB(255, 3, 33, 131)
          : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {
        // if (_formKey.currentState!.validate()) {
        if (!widget.isSignUp || _isChecked) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (__) {
            return const VehicleListScreen();
          })); // Proceed to sign up or login
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (__) {
            return const VehicleListScreen();
          }));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please agree to the terms")),
          );
        }
        // }
      },
      child: Text(
        widget.isSignUp ? "Sign Up" : "Log In",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildFingerprintImage(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Image.asset("assets/images/fingerprint.png"),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: appStyle(color: Colors.black, size: 14, fw: FontWeight.normal),
          children: [
            TextSpan(
              text: widget.isSignUp
                  ? "Already have an account? "
                  : "Don't have an account yet? ",
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.isSignUp
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AuthScreen(isSignUp: false),
                          ),
                        )
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AuthScreen(isSignUp: true),
                          ),
                        );
                },
              text: widget.isSignUp ? "Log In" : "Sign Up",
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
