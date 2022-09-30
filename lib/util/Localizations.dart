import 'package:get/get.dart';

class MyTraslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': {
          'AppName': "MOPROT",
          'AppDescrip': "Tambos project monitoring",
          'welcome': 'Welcome Back!',
          "RememberMe": "Remember me",
        },
        'es': {
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
        },
      };
}
