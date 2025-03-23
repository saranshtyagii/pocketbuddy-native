import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procketbuddy_native/screens/Error_Screen.dart';
import 'package:procketbuddy_native/screens/Home_Screen.dart';
import 'package:procketbuddy_native/services/Auth_Services.dart';
import 'package:http/http.dart' as http;
import 'package:procketbuddy_native/utils/User_Authentication.dart';
import 'package:procketbuddy_native/utils/User_Register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameOrEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _registerpasswordController =
      TextEditingController();
  final TextEditingController _registerConfirmpasswordController =
      TextEditingController();

  bool _hideLoginPassword = true;
  bool _hideSignUpPassword = true;
  bool _isLoginScreen = true;
  bool _showLoading = false;
  bool _showResetPasswordLoading = false;

  final authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      body: _isLoginScreen ? _buildLoginScreen() : _buildSignUpScreen(),
    );
  }

  _buildLoginScreen() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onTertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Login to your accout",
                      style: GoogleFonts.lato(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 36),
                    TextFormField(
                      controller: _usernameOrEmailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Username or Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter username or email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hideLoginPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hideLoginPassword = !_hideLoginPassword;
                            });
                          },
                          icon: _hideLoginPassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _buildForgotPassword();
                          },
                          child: Text(
                            "forgot password?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: doLogin,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.all(18),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: !_showLoading
                            ? Text(
                                "Login",
                                style:
                                    TextStyle(letterSpacing: 2, fontSize: 16),
                              )
                            : SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You don't have an account?"),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLoginScreen = false;
                      });
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildSignUpScreen() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _registerFormKey,
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onTertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: GoogleFonts.lato(fontSize: 28),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "full name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "phone number is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "phone number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "username can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _registerpasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "password is empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _registerConfirmpasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm password is empty";
                        }
                        if (value.compareTo(_registerpasswordController.text) !=
                            0) {
                          return "Password and confirm password is not match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "confirm password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: doSignUp,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.all(18),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: !_showLoading
                            ? Text("Create Account")
                            : SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already have an Account?"),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLoginScreen = true;
                      });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildForgotPassword() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Reset your Password",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 36),
                    TextFormField(
                      controller: _usernameOrEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () {
                          setModalState(() {
                            _showResetPasswordLoading = true;
                          });
                          _doPasswordReset();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.all(18),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: !_showResetPasswordLoading
                            ? Text("Reset Password")
                            : SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  doLogin() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _showLoading = !_showLoading;
    });

    String usernameOrEmail = _usernameOrEmailController.text;
    String password = _passwordController.text;
    UserAuthentication userData = UserAuthentication(
      usernameOrEmail: usernameOrEmail,
      password: password,
      "",
      "",
      "",
      "",
      "",
      "",
    );
    final http.Response? respone = await authService.authenticateUser(userData);
    setState(() {
      _showLoading = !_showLoading;
    });
    if (respone?.statusCode == 200) {
      _switchToHome();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("The email or password you entered is incorrect."),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(12),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.onSecondaryFixed,
                        ),
                      ),
                      child: Text(
                        "Okay",
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void doSignUp() async {
    _registerFormKey.currentState?.validate();

    setState(() {
      _showLoading = !_showLoading;
    });

    String fullName = _fullNameController.text.trim();
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts.isNotEmpty ? nameParts.first : "";
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _registerpasswordController.text.trim();

    UserRegister userData = UserRegister(
      userFirstName: firstName,
      userLastName: lastName,
      username: username,
      email: email,
      mobileNumber: _mobileNumberController.text.trim(),
      password: password,
    );
    http.Response? response = await authService.createUserAccount(userData);
    if (response?.statusCode == 200) {
      _switchToHome();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ErrorScreen(),
        ),
      );
    }
    setState(() {
      _showLoading = !_showLoading;
    });
  }

  _doPasswordReset() {
    authService.resetPassword();
  }

  _switchToHome() {
    setState(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }
}
