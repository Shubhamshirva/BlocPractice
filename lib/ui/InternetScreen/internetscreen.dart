import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/internet/internet_bloc.dart';
import 'package:practice/bloc/internet/internet_state.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: 
        BlocConsumer<InternetBloc,InternetState>(builder: (context,state) {
           if(state is InternetGainedState) {
            return Text("Connected");
          }
          else if (state is InternetLostState ){
            return Text("No Internet");
          }
          else {
            return Text("Loading...");
          }
        }, listener: (context,state){
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Internet connected!"),
            backgroundColor: Colors.green,
            ));
          }
          else if (state is InternetLostState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Internet not connected!"),
            backgroundColor: Colors.red,
            ));
          }
        })
        // BlocBuilder<InternetBloc, InternetState>(builder: (context,state){
        //   if(state is InternetGainedState) {
        //     return Text("Connected");
        //   }
        //   else if (state is InternetLostState ){
        //     return Text("No Internet");
        //   }
        //   else {
        //     return Text("Loading...");
        //   }
        // //   return  Text(
        // //   ""
        // // );
        // })

      )),
    );
  }
}