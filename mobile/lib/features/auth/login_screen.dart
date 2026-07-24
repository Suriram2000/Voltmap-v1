import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to VoltMap')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            const SizedBox(height:40),
            const Icon(Icons.ev_station,size:80,color:Colors.green),
            const SizedBox(height:20),
            const Text('Sign in',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
            const SizedBox(height:24),
            const TextField(decoration:InputDecoration(labelText:'Email')),
            const SizedBox(height:16),
            const TextField(obscureText:true,decoration:InputDecoration(labelText:'Password')),
            const SizedBox(height:24),
            FilledButton(
              onPressed:(){},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical:14),
                child: Text('Login'),
              ),
            ),
            const SizedBox(height:12),
            OutlinedButton.icon(
              onPressed:(){},
              icon: const Icon(Icons.login),
              label: const Text('Continue with Google'),
            )
          ],
        ),
      ),
    );
  }
}
