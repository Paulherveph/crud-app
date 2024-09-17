import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;
  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(height: 50), // Empty space instead of image
              textfield(email, _focusNode1, 'Email', Icons.email),
              SizedBox(height: 10),
              textfield(password, _focusNode2, 'Password', Icons.lock, obscureText: _obscurePassword, toggleObscure: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              }),
              SizedBox(height: 10),
              textfield(passwordConfirm, _focusNode3, 'Confirm Password', Icons.lock, obscureText: _obscureConfirmPassword, toggleObscure: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              }),
              SizedBox(height: 8),
              account(),
              SizedBox(height: 20),
              SignUP_bottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Do you have an account?",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget SignUP_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if (!_isEmailValid(email.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid email format. Please use @gmail.com')),
            );
            return;
          }
          if (password.text != passwordConfirm.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Passwords do not match.')),
            );
            return;
          }
          AuthenticationRemote()
              .register(email.text, password.text, passwordConfirm.text);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(TextEditingController _controller, FocusNode _focusNode,
      String typeName, IconData iconss, {bool obscureText = false, VoidCallback? toggleObscure}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          style: TextStyle(fontSize: 18, color: Colors.black),
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconss,
              color: _focusNode.hasFocus ? Colors.green : Color(0xffc5c5c5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
            suffixIcon: toggleObscure != null
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: toggleObscure,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}