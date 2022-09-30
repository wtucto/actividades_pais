import 'package:actividades_pais/app_properties.dart';
import 'package:actividades_pais/custom_background.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/src/pages/Monitor/main/settings/change_language_page.dart';
import 'package:actividades_pais/src/pages/Monitor/auth/login_page.dart';
import 'package:actividades_pais/src/pages/Monitor/auth/change_password_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'General',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Idioma'),
                              leading: Image.asset('assets/icons/language.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeLanguagePage())),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Cambio de contraseña'),
                              leading:
                                  Image.asset('assets/icons/change_pass.png'),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChangePasswordPage(),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Salir'),
                              leading: Image.asset('assets/icons/sign_out.png'),
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()),
                                (route) => false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
