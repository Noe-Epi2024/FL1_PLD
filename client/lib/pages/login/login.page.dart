import 'package:flutter/material.dart';

import '../../components/fields/password.field.dart';
import '../../components/generators/text.generator.dart';
import '../../helpers/validator.helpers.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
  }

  Widget get _appBar => SliverAppBar(
        flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: "backgroundImage",
            child: Image.network(
              "https://images.pexels.com/photos/1477199/pexels-photo-1477199.jpeg?cs=srgb&dl=pexels-artem-saranin-1477199.jpg&fm=jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,
        forceElevated: true,
        toolbarHeight: 0,
        collapsedHeight: 0,
        expandedHeight: 250,
      );

  Widget get _usernameField => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            label: Text("Entrez votre nom d'utilisateur"),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) => ValidatorHelper.isNullOrEmptyValidator(
            value,
            "Veuillez entrer votre nom d'utilisateur",
          ),
        ),
      );

  Widget get _passwordField => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: PasswordField(
          controller: _passwordController,
        ),
      );

  Widget get _loginButton => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: _submit,
          child: Text("Connexion"),
        ),
      );

  Widget get _starLoggedIn => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Rester connecter"),
          Checkbox(value: false, onChanged: (value) {}),
        ],
      );

  Widget get _createAccount =>
      TextButton(onPressed: () {}, child: Text("Créer un compte"));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _appBar,
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 36,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextGenerator.headline(
                        "Connexion à HyperTools",
                        textAlign: TextAlign.center,
                      ),
                      TextGenerator.title("Nom d'utilisateur"),
                      _usernameField,
                      TextGenerator.title("Mot de passe"),
                      _passwordField,
                      _starLoggedIn,
                      _loginButton,
                      Divider(height: 32),
                      _createAccount,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
