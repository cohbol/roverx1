roverx1
=======
Ésta carpeta contiene todo el sofware necesario y documentación para lograr hacer funcionar el roverx1 con sus modificaciones correctas.
El autor de éste código fuente main.pas ó software está liberado bajo licencia gplv2 tal como se describe en éste mismo directorio en el archivo licence.txt
El autor no se responsabiliza por daños materiales y/o personales causados al implementar el código en el roverx1 y es de total responsabilidad de parte de la persona que está tratando implementar ésta aplicación.

Autor: Hiroshi Takey
email: htakey@gmail.com
skype: htakey

Éste código fuente ésta listo para ser compilado en Embarcadero Delphi XE5 para la versión de Android 4.2 el cuál fue testeado exitosamente como se muestra en el siguiente link de video:

https://www.youtube.com/watch?v=be-s2eH_F3k


Hardware Necesario
-------------------

 - Dispositivo Android 4.2 en adelante con Giroscopio y Bluetooth.
 - Modulo Bluetooth http://www.amazon.com/Arduino-Wireless-Bluetooth-Transceiver-Module/dp/B0093XAV4U/ref=pd_sim_misc_1/180-1246072-2357111?ie=UTF8&refRID=0M3CJNMK8A7S68AM1QZM
 - Un Juguete RC sencillo con direción izquierda y derecha (Lo llamaremos roverx1, de aquí en adelante).
 - Pinguino 18F2550 con bootloader 1.X ó 2.x (Diagrama PIC18F2550_diagram.png)

Software necesario
-------------------

 - Pinguino IDE - http://pinguino.cc/ (Funcional en Ubuntu 12.04, no comprabado en otro sistema operativo)
 - Embarcadero Delphi XE5 en adelante.(Funcional en Windows XP S3, no comprobado en otro sistema operativo)


Intrucciones
-------------

  - Abrir el archivo roverx1.pde con el IDE pinguino, compilar y grabar a la placa PINGUINO.
  - Retirar el micro que lleva el roverx1 y reemplazarlo por el pinguino.
  - Las salidas digitales 7 y 6 corresponden a la combinación de dirección y deben estar conectadas en la entrada del puente H de transistores del motor de dirección.
  - Las salidas digitales 13 y 15 corresponden a la combinación de movimiento y deben estar conectadas en la entrada del puente H de transistores del motor de movimiento.
  - Conectar el pin del modulo bluetooth RX al pin 8 TX del Pinguino.
  - Conectar el pin del modulo bluetooth TX al pin 9 RX del Pinguino.
  - Tanto el modulo bluetooth como el pinguino deben alimentarse de manera externa con 3 baterias tipo AA de lo contrario no llegará a funcionar si se alimentan directamente del juguete ya que a la hora de funcionar los motores hay un caída de tensión.
  - Encender todo el roverx1 y esperar a que realice un autotest. Si todo va bien proceder con el siguiente paso.
  - Cargar todo el proyecto en Embarcadero XE5 y luego compilarlo y exportarlo al dispositivo Android.
  - Ejecutar el programa en el dispositivo Android y seleccionar el dispositivo apareado previamente en el sistema de Android.
  
  Si todo va bien, deberías ya estar disfrutando de tu nuevo roverx1 hackeado!

  Gracias! Para el soporte puedes seguirme en la Comunidad OpenHardware Bolivia (COHBOL) en facebook ;)
  https://www.facebook.com/pages/Comunidad-OpenHardware-Bolivia/543594545767566
  ó también en:
  https://sourceforge.net/p/cohbol/roverx1/
