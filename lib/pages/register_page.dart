import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/providers/database_provider.dart';
import 'package:proyecto_poo/providers/login_state_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _userName;
  String _emailField = '';
  String _passwordField = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey ,
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Consumer<LoginState>(
        builder: (BuildContext context, LoginState value, Widget child) {
          if (value.isLoading) {
            return Center(
                child: Container(
                    padding: EdgeInsets.all(50),
                    child: CircularProgressIndicator()));
          } else {
            return child;
          }
        },
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: 180.0,
              ),
            ),
            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3.0)
                  ]),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Text('Registro', style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 60),
                    _crearUserName(),
                    SizedBox(height: 30.0),
                    _crearEmail(),
                    SizedBox(height: 30.0),
                    _crearPassword(),
                    SizedBox(height: 30.0),
                    _crearBoton(context),
                    SizedBox(height: 30.0),
                    Text(_error, style: TextStyle(color: Colors.red),),
                  ],
                ),
              ),
            ),
            //Text('¿Olvido la contraseña?'),
            SizedBox(height: 100.0)
          ],
        ),
      ),
    );
  }

  Widget _crearUserName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle, color: Colors.deepPurple),
          hintText: 'POO 2020-1',
          labelText: 'Nombre de Usuario',
        ),
        onSaved: (newValue) => this._userName = newValue,
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',
          errorText: this._error
        ),
        onSaved: (newValue) => _emailField = newValue,
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
          labelText: 'Contraseña',
        ),
      onSaved: (newValue) => _passwordField = newValue,
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Registrar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () async {
          await _submit(context);
        });
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Jorge Hernández',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
  Future _submit(BuildContext context) async
  {
    //esto debería validar los campos del formulario
      formKey.currentState.save();
      dynamic result = await context.read<LoginState>().registerWithEmailAndPassword(_emailField, _passwordField, this._userName);
      if(result == null)
      {
        setState(() {
          _error = 'Por favor ingresa un email válido o no registrado';
        });

      }
      else{
        
         
          Navigator.pop(context);

      }
  }
}
