/*
    roverx1.pde is part of roverx1.

    roverx1 is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    roverx1 is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

'****************************************************************
'*  Name    : roverx1.pde                                          *
'*  Author  : Hiroshi Takey                                     *
'*  Notice  : Software and Source Code under GPLv2 License      *
'*          : Please read license.txt                           *
'*  Date    : 8/7/2014                                          *
'*  Version : 1.0                                               *
'*  Notes   : Nothing                                           *
'*          :                                                   *
'****************************************************************
*/

#include <usart.h>
#include <io.c>
#include <string.h>


 char c = 64;

 int ledf1;						
 int ledf2;		

 int dir1;
 int dir2;
 int mov1;
 int mov2;
 u16 t1 = 0;			
 u16 t2 = 0;
 u16 auxtime = 1000;
 byte i1 = 255;

void setup()
{
 
  ledf1 = 3;
  ledf2 = 2;
  dir1 = 7;
  dir2 = 6;
  mov1 = 15;
  mov2 = 13;
  pinMode(ledf1,OUTPUT);
  pinMode(ledf2,OUTPUT);
  pinMode(dir1,OUTPUT);
  pinMode(dir2,OUTPUT);  
  pinMode(mov1,OUTPUT);
  pinMode(mov2,OUTPUT);  
  
  digitalWrite(ledf1,HIGH);	
  delay(1000);
  digitalWrite(ledf1,LOW);	

  digitalWrite(ledf2,HIGH);		
  delay(1000);
  digitalWrite(ledf2,LOW);
  
  Serial.begin(115200);  
   
  digitalWrite(dir1 ,HIGH);		
  digitalWrite(dir2 ,LOW);		
  digitalWrite(mov1 ,HIGH);
  digitalWrite(mov2 ,LOW);	
  delay(1000);

  digitalWrite(dir1 ,LOW);		
  digitalWrite(dir2 ,HIGH);	
  digitalWrite(mov1 ,LOW);		
  digitalWrite(mov2 ,HIGH);		
  delay(1000);


  digitalWrite(mov1,LOW);
  digitalWrite(mov2,LOW);
  digitalWrite(dir1,LOW);
  digitalWrite(dir2,LOW);   
   
	Serial.printf("\r\n");
	Serial.printf("*************************************\r\n");
	Serial.printf("*** Comunidad Openhardware Bolvia ***\r\n");
	Serial.printf("*************************************\r\n");
	Serial.printf("\r\n");

  c = Serial.getKey();    
 
  Serial.printf("aqui\r\n");
}

 char *buffer;
 
 //Bufferes de control de movimiento y direccion del rover.
 char *buffer1 = "1E\r";
 char *buffer2 = "2E\r";
 char *buffer3 = "3E\r";
 char *buffer4 = "4E\r";
 char *buffer5 = "5E\r";

 char *buffermov1i = "6E\r";   
 char *buffermov1d = "7E\r";  
 
 char *buffermov2i = "8E\r";   
 char *buffermov2d = "9E\r";  
 
 
 int it1 = 0;

void loop()
{ 

  buffer = 0;

	if (Serial.available() > 0) {
   buffer = Serial.getString();
 }

 t1 = t1 + 1;
 delayMicroseconds(1);
 if (t1 >= auxtime){ //Temporizador de microsegundos
   t1 = 0;
   t2 = t2 + 1;
 }
 
 if (t2 >= 10){  //Temporizador de segundos
   t2 = 0;
 } 

 if ( t2 >= 5){
  digitalWrite(ledf1,HIGH);	
 }
 else{
  digitalWrite(ledf1,LOW);
 }

  //Mueve mueve hacia adelante al Rover y direcciona hacia la izquiera
 	if (strcmp(buffer,buffermov1i) == 0) {
    if (it1 != 1 ){
      it1 = 1;
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);   
    }
    
    digitalWrite(mov2,HIGH);
    digitalWrite(mov1,LOW);
      if ( t2 >= 1){ 
        digitalWrite(dir1,HIGH);
        digitalWrite(dir2,LOW);
      }
    } 
    
  //Mueve hacia adelante al Rover y direcciona hacia la derecha 
 	if (strcmp(buffer,buffermov1d) == 0) {
    if (it1 != 2 ){
      it1 = 2;
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);   
    }

    digitalWrite(mov2,HIGH);
    digitalWrite(mov1,LOW);
     if ( t2 >= 1){ 
       digitalWrite(dir1,LOW);
       digitalWrite(dir2,HIGH);
     } 
    } 


  //Mueve hacia atrás al Rover y direcciona hacia la izquierda 
 	if (strcmp(buffer,buffermov2i) == 0) {
    if (it1 != 4 ){
      it1 = 4;
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);   
    }
    
    digitalWrite(mov2,LOW);
    digitalWrite(mov1,HIGH);
      if ( t2 >= 1){ 
        digitalWrite(dir2,LOW);
      }
    } 
  
  //Mueve hacia atrás al Rover y direcciona hacia la derecha    
 	if (strcmp(buffer,buffermov2d) == 0) {
    if (it1 != 5 ){
      it1 = 5;
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);   
    }

     digitalWrite(mov2,LOW);
     digitalWrite(mov1,HIGH);
     if ( t2 >= 1){ 
       digitalWrite(dir1,LOW);
       digitalWrite(dir2,HIGH);
     } 
    } 
      
  //Mueve hacia atrás    
  if (strcmp(buffer,buffer1) == 0) {  
    if (it1 != 3 ){
      it1 = 3;
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);   
    }

   digitalWrite(mov1,HIGH);
   digitalWrite(mov2,LOW);
 }
 
  //Mueve hacia adelante
	if (strcmp(buffer,buffer2) == 0) {
    if (it1 != 3 ){
      it1 = 3;
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);   
    }
        digitalWrite(mov1,LOW);
        digitalWrite(mov2,HIGH);
    } 

	//Direcciona solo llantas delanteras hacia el lado izquierdo
 if (strcmp(buffer,buffer3) == 0) {
    //digitalWrite(dir1,LOW);
    digitalWrite(dir2,HIGH);
    //delay(400);
    } 
    
 	if (strcmp(buffer,buffer4) == 0) {
    digitalWrite(dir1,HIGH);
    //digitalWrite(dir2,LOW);
    //delay(400);
    } 

   //Direcciona solo llantas delanteras hacia el lado derecho
 	if (strcmp(buffer,buffer5) == 0) { 
     digitalWrite(mov1,LOW);
     digitalWrite(mov2,LOW);
     digitalWrite(dir1,LOW);
     digitalWrite(dir2,LOW);
   }

}
