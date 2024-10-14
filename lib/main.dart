import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String email = '';
  String senha = '';
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool _obscurePassword = true; // Controla a visibilidade da senha

  //chave unica para todo o app
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildEmail(),
          const SizedBox(
            height: 24,
          ),
          buildPassword(),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              //validar form
              //1 acessar o form e executar a validaçao
              bool valid = formKey.currentState!.validate();
              if (valid) {
                print('Email: ${emailController.text}');
                print('Password: ${passwordController.text}');
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

//antes TextField e agora textformfield
  Widget buildEmail() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Informe o email';
          } else if (!value.contains('@')) {
            return 'E-mail deve conter @';
          }
          return null;
        },
        controller: emailController,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
          hintText: 'name@example.com',
          labelText: 'E-mail',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              emailController.clear();
            },
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      );

  Widget buildPassword() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Informe a Senha';
          } else if (value.length < 6) {
            return 'A senha deve ter no mínimo 6 caracteres';
          }
          return null;
        },
        obscureText: _obscurePassword, // Controla a exibição da senha
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed:
                _togglePasswordView, // Chama a função para alternar a visibilidade da senha
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility
                  : Icons.visibility_off, // Altera o ícone
            ),
          ),
        ),
      );

  // Função para alternar a visibilidade da senha
  void _togglePasswordView() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}
