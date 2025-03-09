import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../components/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _storage = FlutterSecureStorage();
  bool _isLoading = false;
  bool _isRegistering = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 1));
    await _storage.write(key: 'token', value: 'mock_token');
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, 'HomePage');
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пароли не совпадают')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 1));
    await _storage.write(key: 'token', value: 'mock_token');
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, 'HomePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          constraints: BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isRegistering ? 'Регистрация' : 'Вход в VPN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                label: "Пароль",
                icon: Icons.lock,
                isPassword: true,
              ),
              if (_isRegistering) ...[
                SizedBox(height: 15),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: "Подтвердите пароль",
                  icon: Icons.lock,
                  isPassword: true,
                ),
              ],
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _isLoading ? null : (_isRegistering ? _register : _login),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 60),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(_isRegistering ? 'Зарегистрироваться' : 'Войти'),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      _isRegistering ? 'Уже есть аккаунт? ' : 'Нет аккаунта? '),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _isRegistering = !_isRegistering),
                    child: Text(
                      _isRegistering ? 'Войти' : 'Зарегистрироваться',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
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
}
