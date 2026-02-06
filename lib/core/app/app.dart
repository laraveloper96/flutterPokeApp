import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokeapp/core/navigation/app_router.dart';
import 'package:pokeapp/core/shared/presentation/widgets/connectivity_listener.dart';

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PokeApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF433066)),
        useMaterial3: true,
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ConnectivityListener(
          onConnectivityChanged: (isConnected) {
            if (!isConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No Internet Connection'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Internet Connection Restored'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
