import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/login_call_api/login_call_api_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController employeeIdController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocConsumer<LoginCallApiBloc, LoginCallApiState>(
        listener: (context, state) {
          if (state is LoginCallApiSuccess) {
            final position = state.user.position;
            final routeName = position == 'admin'
                ? 'mainManagerAdminScreen'
                : 'mainManagerStaffScreen';
            Navigator.of(context).pushNamedAndRemoveUntil(
              routeName,
                  (route) => false,
            );
          } else if (state is LoginCallApiFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginCallApiLoading;
          final isEmpty = employeeIdController.text.trim().isEmpty;

          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 100,
                          height: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFF534598),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
                    child: Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Container(
                              width: 593,
                              height: 344,
                              decoration: BoxDecoration(
                                color: const Color(0xFF534598),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Employee ID',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: TextField(
                                      controller: employeeIdController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                      ),
                                      onChanged: (_) {
                                        // Force rebuild to update isEmpty
                                        (context as Element).markNeedsBuild();
                                      },
                                    ),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: InkWell(
                                      onTap: isLoading
                                          ? null
                                          : () {
                                        final id = employeeIdController.text.trim();
                                        if (id.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Please enter Employee ID'),
                                              backgroundColor: Colors.orange,
                                            ),
                                          );
                                        } else {
                                          context
                                              .read<LoginCallApiBloc>()
                                              .add(LoginRequested(id));
                                        }
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: (!isEmpty && !isLoading)
                                              ? const Color(0xFFFD80A3)
                                              : const Color(0x80FD80A3),
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                        child: Center(
                                          child: isLoading
                                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                              : const Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isLoading) ...[
                // Modal barrier
                ModalBarrier(dismissible: false, color: Colors.black38),
              ],
            ],
          );
        },
      ),
    );
  }
}
