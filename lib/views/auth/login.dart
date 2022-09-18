import 'package:fenwicks_admin/core/routes/routes.dart';
import 'package:fenwicks_admin/views/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fenwicks Admin"),
        centerTitle: true,
      ),
      body: Form(
        key: controller.loginKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.loginKey.currentState!.validate()) {
                    controller.login();
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Wanna create a new admin? "),
                  GestureDetector(
                    onTap: () => {Get.toNamed(Routes.register), controller.rest()},
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
