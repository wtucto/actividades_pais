import "package:get/get.dart";
import "package:flutter/material.dart";

class MyTraslation extends Translations {
  static final locale = Locale("es", "ES");
  static final fallbackLocale = Locale("en", "US");

  static final Langs = ["Español", "English"];
  static final locales = [
    Locale("es", "ES"),
    Locale("en", "US"),
  ];

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //"es_ES": es,
        //"en_US": en,
        "es_ES": {
          "Account": "Cuenta",
          "AppDescrip": "Monitoreo de proyectos Tambos",
          "AppName": "MOPROT",
          "Cancel": "Cancelar",
          "ChangePassword": "Cambiar contraseña",
          "CompanyTag": "@PAIS",
          "ConfirmChangePassword": "Confirmar",
          "ConfirmCodePhone": "Confirmar Codigo",
          "ConfirmationQuestion100": "¿Estás seguro de realizar la operación?",
          "ConnectOffline": "Sin Acceso a Internet",
          "ConnectOnline": "Conectado a Internet",
          "CreateNewAccount": "Cree su nueva cuenta para usos futuros.",
          "Credential": "Credenciales",
          "DevelopByText": "Desarrollado por ",
          "Email": "Correo",
          "EnterCurrentPassword": "Ingresar contraseña actual",
          "EnterEmail": "Ingrese su Correo",
          "EnterNewPassword": "Ingresar nueva contraseña",
          "EnterPassword": "Ingrese su Contraseña",
          "EnterPhone":
              "Ingrese su número de móvil registrado para obtener un codigo por SMS.",
          "LogOut": "Cerrar sesión",
          "Follow": "Siguienos!",
          "ForgotPassword": "¿Olvidaste tu contraseña? ",
          "FormIsComplete": "Formulario correcto.",
          "FrequentlyAskedQuestions": "Preguntas Frecuentes (FAQ)",
          "FrequentlyAskedQuestionsResp": "Preguntas Frecuentes y Respuestas",
          "General": "General",
          "I": "Info!",
          "Incomplete": "Incompleto",
          "Language": "Idioma",
          "Legal": "Legal",
          "LogIn": "Acceder",
          "LoggedIn": "iniciado sesión como @name con e-mail @email",
          "MonitorinProyTambo": "Monitoreo de Proyectos Tambos",
          "Monitoring": "Monitoreo",
          "MonitoringListTitle": "LISTA DE MONITOREOS",
          "No": "No",
          "NotAccount": "¿No tienes una cuenta? ",
          "Password": "Constraseña",
          "Penalties": "Penalidades",
          "PrivacyPolicy": "Política de Privacidad",
          "ProjectDetailTitle": "DETALLE DEL PROYECTO",
          "ProjectListTitle": "LISTADO DE PROYECTOS",
          "ReSendMessage": "reenviar de nuevo",
          "ReceiveMessage": "¿No recibiste el SMS? ",
          "RememberMe": "Recordar",
          "RepetNewPassword": "Repetir nueva contraseña",
          "Required": "Requerido (*)",
          "RequiredFields": "Campos requeridos (*).",
          "RestarPassword": "Restablecer la contraseña",
          "SaveData": "Grabar",
          "SelectData": "Seleccione",
          "Send": "Enviado",
          "SendCodePhone": "Enviar codigo",
          "SendData": "Enviar",
          "Settings": "Configuración",
          "SignIn": "Iniciar sesión",
          "SignUp": "Crear Cuenta",
          "SocialApps": "Nuestras redes sociales",
          "StillNotRegistered": "¿Aún no estás registrado? ",
          "Suport": "Soporte",
          "TermsOfUse": "Terminos de Uso",
          "TileAppRegister": "REGISTRARSE EN LA APP",
          "TileBitacoraRegister": "REGISTAR BITACORA",
          "TileIntervencion": "INTERVENCIONES",
          "TilePias": "PIAS",
          "TileProyectTambo": "MONITOR PROY. TAMBO",
          "ToChoose": "Elegir",
          "ToSend": "Por Envia",
          "User": "Usuario",
          "UserConfig": "Configuración y Usuario",
          "VerifyCodePhone": "Verificar",
          "W": "Warning!",
          "WaitConfirmCodePhone": "Espere, estamos confirmando su Codigo",
          "Yes": "Si",
          "welcome": "Bienvenido!",
        },
        "en_US": {
          "Account": "Account",
          "AppDescrip": "Tambo project monitoring",
          "AppName": "MOPROT",
          "Cancel": "Cancel",
          "ChangePassword": "Change Password",
          "CompanyTag": "@COUNTRY",
          "ConfirmChangePassword": "Confirm",
          "ConfirmCodePhone": "Confirm code",
          "ConfirmationQuestion100": "Are you sure to perform the operation?",
          "ConnectOffline": "No Internet access",
          "ConnectOnline": "Conected to internet",
          "CreateNewAccount": "Create your new account for future use.",
          "Credential": "Credentials",
          "DevelopByText": "Developed by",
          "Email": "Mail",
          "EnterCurrentPassword": "Enter current password",
          "EnterEmail": "Enter your email",
          "EnterNewPassword": "Enter new password",
          "EnterPassword": "Enter your Password",
          "EnterPhone":
              "Enter your registered mobile number to get a code by SMS.",
          "LogOut": "Log Out",
          "Follow": "Follow us!",
          "ForgotPassword": "Did you forget your password?",
          "FormIsComplete": "correct form.",
          "FrequentlyAskedQuestions": "FAQ",
          "FrequentlyAskedQuestionsResp":
              "Frequently Asked Questions and Answers",
          "General": "General",
          "I": "Info!",
          "Incomplete": "Incomplete",
          "Language": "Language",
          "Legal": "Legal",
          "LogIn": "To access",
          "LoggedIn": "logged in as @name with e-mail @email",
          "MonitorinProyTambo": "Tambo Project Monitoring",
          "Monitoring": "monitoring",
          "MonitoringListTitle": "MONITORING LIST",
          "No": "Nope",
          "NotAccount": "You do not have an account?",
          "Password": "password",
          "Penalties": "Penalties",
          "PrivacyPolicy": "Privacy Policy",
          "ProjectDetailTitle": "PROJECT DETAIL",
          "ProjectListTitle": "LIST OF PROJECTS",
          "ReSendMessage": "resend again",
          "ReceiveMessage": "Didn't receive the SMS?",
          "RememberMe": "To remember",
          "RepetNewPassword": "repeat new password",
          "Required": "Required (*)",
          "RequiredFields": "Required fields (*).",
          "RestarPassword": "Reset your password",
          "SaveData": "Engrave",
          "SelectData": "Select",
          "Send": "Send",
          "SendCodePhone": "Send code",
          "SendData": "Send",
          "Settings": "Setting",
          "SignIn": "Log in",
          "SignUp": "Create Account",
          "SocialApps": "Our social networks",
          "StillNotRegistered": "Not registered yet?",
          "Suport": "Support",
          "TermsOfUse": "Terms of use",
          "TileAppRegister": "REGISTER IN THE APP",
          "TileBitacoraRegister": "REGISTER LOG",
          "TileIntervencion": "INTERVENTIONS",
          "TilePias": "PIAS",
          "TileProyectTambo": "PROJECT MONITOR DAIRY",
          "ToChoose": "To choose",
          "ToSend": "By Send",
          "User": "User",
          "UserConfig": "Configuration and User",
          "VerifyCodePhone": "Verify",
          "W": "Warning!",
          "WaitConfirmCodePhone": "Wait, we are confirming your code",
          "Yes": "Yes",
          "welcome": "Welcome!",
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
 Text("LoggedIn".trParams({
  "name": "Jhon",
  "email": "jhon@example.com"
  }));
 */
