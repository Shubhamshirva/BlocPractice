import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/internet/internet_event.dart';
import 'package:practice/bloc/internet/internet_state.dart';

// class InternetBloc extends Bloc<InternetEvent, InternetState> {

//   Connectivity _connectivity = Connectivity();
//   StreamSubscription? connectivitySubscription;

//   InternetBloc() : super(InternetInitialState()){
//     on<InternetLostEvent>((event,emit) => emit(InternetLostState()));
//     on<InternetGainedEvent>((event,emit) => emit(InternetGainedState()));

//   connectivitySubscription = _connectivity.onConnectivityChanged.listen((result){
//       if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
//         add(InternetGainedEvent());
//       }
//       else {
//         add(InternetLostEvent());
//       }
//     });
//   }

//   @override
//   Future<void> close(){
//     connectivitySubscription?.cancel();
//     return super.close();
//   }

// }

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    _checkInitialConnectivity(); // Perform initial check

    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        if (_isConnectedList(results)) {
          add(InternetGainedEvent());
        } else {
          add(InternetLostEvent());
        }
      },
    );
  }

  Future<void> _checkInitialConnectivity() async {
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    if (_isConnectedList(result)) {
      emit(InternetGainedState()); // Emit initial gained state
    } else {
      emit(InternetLostState()); // Emit initial lost state
    }
  }

  bool _isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn ||
        result == ConnectivityResult.bluetooth;
  }

  bool _isConnectedList(List<ConnectivityResult> results) {
    return results.any((result) => _isConnected(result));
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}