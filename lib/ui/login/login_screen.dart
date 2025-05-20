
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/bloc/login/login_bloc.dart';
import 'package:practice/bloc/login/login_event.dart';
import 'package:practice/bloc/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


late LoginBloc _loginBloc;
final emailfocusnode = FocusNode();
final passwordfocusnode = FocusNode();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: 
      BlocProvider(create: (_) => _loginBloc,
      child:  Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (current,previous) => current.email != previous.email,
            builder: (context, state)
            {
            return 
               TextFormField(
            keyboardType: TextInputType.emailAddress,
            focusNode: emailfocusnode,
            style: TextStyle(
              color: Colors.black
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black
              ),
              hintText: "Enter Email",
              border: OutlineInputBorder()
            ),
            onChanged: (value) {
              context.read<LoginBloc>().add(EmailChanged(email: value));
            },
            onFieldSubmitted: (value) {
              // context.read<LoginBloc>().add(EmailChanged(email: value));
              
            },
          );
          }),
       
          SizedBox(height: 20),

           BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (current,previous) => current.password != previous.password,
            builder: (context, state)
            {
            return 
              TextFormField(
            keyboardType: TextInputType.text,
              style: TextStyle(
              color: Colors.black
            ),
            focusNode: passwordfocusnode,
            decoration: InputDecoration(
              hintText: "Enter Password",
              hintStyle: TextStyle(
                color: Colors.black
              ),
              border: OutlineInputBorder()
            ),
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChanged(password: value));
              print("password value is ${value.toString()}");
              
            },
            onFieldSubmitted: (value) {
              // context.read<LoginBloc>().add(PasswordChanged(password: value));

              
            },
          );
          }),
       
           
          SizedBox(height: 50),
          BlocListener<LoginBloc,LoginState>(listener: (context,state){
            if(state.loginStatus == LoginStatus.error){
               ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.message)));
            }
              if(state.loginStatus == LoginStatus.loading){
               ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Submitting')));
            }
             if(state.loginStatus == LoginStatus.success){
               ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Login successfull')));
            }

          },
          child:  BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (current,previous) => false,
            builder: (context, state)
            {
            return 
              ElevatedButton(onPressed: () {
                print(state.password.toString());
                print(state.email.toString());
                // context.read<LoginBloc>().add(LoginApi());
          }, child: Text("Login"));
          }),
          )
          


        ],
      ),
      ),
      )
      
    );
  }
}