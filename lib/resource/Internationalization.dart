import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyTraslation extends Translations {
  static final locale = Locale('es', 'ES');
  static final fallbackLocale = Locale('en', 'US');

  static final Langs = ['Español', 'English'];
  static final locales = [
    Locale('es', 'ES'),
    Locale('en', 'US'),
  ];

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //'es_ES': es,
        //'en_US': en,
        'en_US': {
          'AppName': "MOPROT",
          'AppDescrip': "Tambos project monitoring",
          'welcome': 'Welcome Back!',
          "RememberMe": "Remember me",
          "Language": "Language",
          'Settings': "Settings",
        },
        'es_ES': {
          "Language": "Idioma",
          'Settings': "Configuración",
          'AppName': "MOPROT",
          'AppDescrip': "Monitoreo de proyectos Tambos",
          'welcome': "Bienvenido!",
          "EnterEmail": "Ingrese su Correo",
          "Email": "Correo",
          "EnterPassword": "Ingrese su Contraseña",
          "Password": "Constraseña",
          "RememberMe": "Recordar",
          'ForgotPassword': "¿Olvidaste tu contraseña? ",
          'RestarPassword': "Restablecer la contraseña",
          'LogIn': "Acceder",
          'CreateNewAccount': "Cree su nueva cuenta para usos futuros.",
          "SignIn": "Iniciar sesión",
          "NotAccount": "¿No tienes una cuenta? ",
          "SignUp": "Crear Cuenta",
          "Follow": "Siguienos!",
          "SocialApps": "Nuestras redes sociales",
          "ReceiveMessage": "¿No recibiste el SMS? ",
          "ReSendMessage": "reenviar de nuevo",
          "EnterPhone":
              "Ingrese su número de móvil registrado para obtener un codigo por SMS.",
          "SendCodePhone": "Enviar codigo",
          "ConfirmCodePhone": "Confirmar Codigo",
          "WaitConfirmCodePhone": "Espere, estamos confirmando su Codigo",
          "VerifyCodePhone": "Verificar",
          "StillNotRegistered": "¿Aún no estás registrado? ",
          "Credential": "Credenciales",
          "ChangePassword": "Cambiar contraseña",
          "EnterCurrentPassword": "Ingresar contraseña actual",
          "EnterNewPassword": "Ingresar nueva contraseña",
          "RepetNewPassword": "Repetir nueva contraseña",
          "ConfirmChangePassword": "Confirmar",
          'LoggedIn': 'iniciado sesión como @name con e-mail @email',
        },
      };

  void changeLocale(String lang) {
    final locale = _getLocateFromLanguages(lang);
    Get.updateLocale(locale!);
  }

  Locale? _getLocateFromLanguages(String lang) {
    for (int i = 0; i < Langs.length; i++) {
      if (lang == Langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}

/**
 * 
 Text('logged_in'.trParams({
  'name': 'Jhon',
  'email': 'jhon@example.com'
  }));
 */
