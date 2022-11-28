import 'package:authorisation/src/providers/auth_provider.dart';
import 'package:brickman_demo_app/home/ui/views/home_view.dart';
import 'package:brickman_demo_app/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FormType { signIn, signUp }

class LandingPage extends ConsumerStatefulWidget {
  static const routeName = '/landing';

  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  FormType _form = FormType.signIn;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (prev, current) {
      if (current.recordAuth != null) {
        ref.read(routerProvider).go(HomeView.routeName);
      }
    });

    final errorMessage = ref.watch(authProvider.select((status) => status.clientException?.response["message"]));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("🧱", style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: "User name"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 16),
            _form == FormType.signIn
                ? Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _handleSignIn,
                        child: const Text("Sign in"),
                      ),
                      TextButton(
                        onPressed: _onFormChange,
                        child: const Text("Don't have an account? Tap here to Sign Up."),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _handleSignUp,
                        child: const Text("Create an Account"),
                      ),
                      TextButton(
                        onPressed: _onFormChange,
                        child: const Text("Already have an account? Tap here to Sign In."),
                      ),
                      const Text(
                        "(Password needs to be atleast 8 characters)",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void _onFormChange() {
    setState(() {
      _form == FormType.signUp ? _form = FormType.signIn : _form = FormType.signUp;
    });
  }

  void _handleSignIn() {
    ref.read(authProvider.notifier).signIn(
          user: _userNameController.text,
          password: _passwordController.text,
        );
  }

  void _handleSignUp() {
    ref.read(authProvider.notifier).signUp(
          user: _userNameController.text,
          password: _passwordController.text,
        );
  }
}
