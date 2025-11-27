import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';

void main () async { 
   WidgetsFlutterBinding.ensureInitialized();


   runApp(const MyApp( )); 
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
     
      ], child: MaterialApp(
        
      ),
    );
  }
}