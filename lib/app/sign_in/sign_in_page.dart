import 'package:flutter_time_tracker/app/sign_in/sign_in_bloc.dart';

import 'email_sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_time_tracker/services/auth.dart';
import 'package:flutter_time_tracker/app/sign_in/sign_in_button.dart';
import 'package:flutter_time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_time_tracker/common_widgets/show_exception_alert_dialog.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
        create: (_) => SignInBloc(),
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<SignInBloc>(
            builder: (_, bloc, __) => SignInPage(bloc: bloc)));
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50, child: _buildHeader(isLoading)),
          SizedBox(height: 48.0),
          SocialSignInButton(
            isLoading: isLoading,
            assetName: 'images/google-logo.png',
            color: Colors.white,
            text: 'Sign in with Google',
            textColor: Colors.black87,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            isLoading: isLoading,
            assetName: 'images/facebook-logo.png',
            color: Color(0xFF334D92),
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            isLoading: isLoading,
            color: Colors.teal[700],
            text: 'Sign in with email',
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            isLoading: isLoading,
            color: Colors.lime[300],
            text: 'Go anonymous',
            textColor: Colors.black,
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
