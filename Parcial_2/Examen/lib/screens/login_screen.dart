import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController =
      TextEditingController();

  late AnimationController
      animationController;

  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    fadeAnimation =
        CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      await Supabase.instance.client.auth
          .signInWithPassword(
        email: emailController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const HomeScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
                Alignment.bottomRight,
            colors: [
              Color(0xFF0A0A0F),
              Color(0xFF141421),
              Color(0xFF0A0A0F),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity:
                fadeAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                        20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.travel_explore,
                      size: 100,
                      color:
                          Color(0xFF00F7FF),
                    ),

                    const SizedBox(
                        height: 15),

                    const Text(
                      'CYBER',
                      style:
                          TextStyle(
                        fontSize: 40,
                        fontWeight:
                            FontWeight
                                .bold,
                        color: Color(
                            0xFF00F7FF),
                        letterSpacing:
                            4,
                        shadows: [
                          Shadow(
                            color: Color(
                                0xFF00F7FF),
                            blurRadius:
                                20,
                          ),
                        ],
                      ),
                    ),

                    const Text(
                      'FAVORITES',
                      style:
                          TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight
                                .bold,
                        color: Color(
                            0xFFFF00FF),
                        letterSpacing:
                            3,
                        shadows: [
                          Shadow(
                            color: Color(
                                0xFFFF00FF),
                            blurRadius:
                                20,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        height: 25),

                    Container(
                      constraints:
                          const BoxConstraints(
                        maxWidth:
                            500,
                      ),
                      padding:
                          const EdgeInsets
                              .all(24),
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                                0xFF141421),
                        borderRadius:
                            BorderRadius
                                .circular(
                                    25),
                        border:
                            Border.all(
                          color:
                              const Color(
                                  0xFF00F7FF),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color:
                                Color(
                                    0x5500F7FF),
                            blurRadius:
                                25,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'INICIAR SESIÓN',
                            style:
                                TextStyle(
                              color: Color(
                                  0xFF00F7FF),
                              fontSize:
                                  22,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  20),

                          TextField(
                            controller:
                                emailController,
                            decoration:
                                const InputDecoration(
                              labelText:
                                  'Correo',
                              prefixIcon:
                                  Icon(Icons
                                      .email),
                            ),
                          ),

                          const SizedBox(
                              height:
                                  15),

                          TextField(
                            controller:
                                passwordController,
                            obscureText:
                                true,
                            decoration:
                                const InputDecoration(
                              labelText:
                                  'Contraseña',
                              prefixIcon:
                                  Icon(Icons
                                      .lock),
                            ),
                          ),

                          const SizedBox(
                              height:
                                  25),

                          SizedBox(
                            width: double
                                .infinity,
                            height: 55,
                            child:
                                ElevatedButton(
                              onPressed:
                                  login,
                              child:
                                  const Text(
                                'ACCEDER',
                                style:
                                    TextStyle(
                                  fontSize:
                                      16,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height:
                                  15),

                          TextButton(
                            onPressed:
                                () {
                              Navigator
                                  .push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          RegisterScreen(),
                                ),
                              );
                            },
                            child:
                                const Text(
                              'Crear cuenta',
                              style:
                                  TextStyle(
                                color: Color(
                                    0xFF00F7FF),
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
        ),
      ),
    );
  }
}