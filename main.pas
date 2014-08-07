{
    main.pas is part of roverx1.

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
'*  Name    : main.pas                                          *
'*  Author  : Hiroshi Takey                                     *
'*  Notice  : Copyright (c) 2014 [select VIEW...EDITOR OPTIONS] *
'*          : All Rights Reserved                               *
'*  Date    : 8/7/2014                                          *
'*  Version : 1.0                                               *
'*  Notes   : Nothing                                           *
'*          :                                                   *
'****************************************************************
}
unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  Androidapi.JNI.BluetoothAdapter,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNIBridge,Androidapi.JNI.Os, Androidapi.JNI.GraphicsContentViewText,Androidapi.JNI.TTS,Androidapi.JNI.Speech,
  Android.JNI.Toast, FMX.ListView.Types, FMX.Edit,  FMX.Objects,
  FMX.ListBox, FMX.Layouts, FMX.Memo,
  FMX.ListView, System.Rtti, FMX.Grid, Data.Bind.GenData,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt ,Unit1, Data.Bind.Components, Data.Bind.ObjectScope, System.Sensors, FMX.Sensors;

type
  Tmainform = class(TForm)
    reload: TButton;
    Timer1: TTimer;
    im: TImage;
    Label1: TLabel;
    ListView1: TListView;
    StyleBook1: TStyleBook;
    Brush1: TBrushObject;
    rojo: TBrushObject;
    verder: TBrushObject;
    Timer3: TTimer;
    Button3: TButton;
    Button4: TButton;
    Label7: TLabel;
    Button5: TButton;
    Button6: TButton;
    Label8: TLabel;
    MotionSensor1: TMotionSensor;
    Label9: TLabel;
    Button7: TButton;
    Rectangle1: TRectangle;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Timer3Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button4MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button6MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button5MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Button3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure MotionSensor1DataChanged(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);


  private

  public
    targetMAC:string;                      // MAC address del equipo remoto seleccionado
    ostream:JOutputStream;
    istream:JInputstream;
    uid:JUUID;                             // UUID para la transferencia SPP
    Sock:JBluetoothSocket;
    Adapter:JBluetoothAdapter;             // Adaptador local Bluetooth
    remoteDevice:JBluetoothDevice;
    s3:string;
    sw:boolean;
    sw_mov1:boolean;
    sw_mov2:boolean;
    sw_dir1:boolean;
    sw_dir2:boolean;

    sw_movdir1i:boolean;
    sw_movdir1d:boolean;

    sw_movdir2i:boolean;
    sw_movdir2d:boolean;

    sw_apagar:boolean;

    sw_secuencia:byte;

    sw_pressedadelante:boolean;
    sw_pressedatras:boolean;
  end;

var
  mainform: Tmainform;
  vr,vg,vb:integer;
  dat:array[0..2] of integer = (250,200,100);

  {Buferes que contienen los comandos de control de movimiento del Rover}
  buffer:array[0..3] of byte =  ($31,$31,$45,$0D);
  buffer2:array[0..3] of byte = ($32,$32,$45,$0D);
  buffer3:array[0..3] of byte = ($33,$33,$45,$0D);
  buffer4:array[0..3] of byte = ($34,$34,$45,$0D);
  buffer5:array[0..3] of byte = ($35,$35,$45,$0D);

  buffermov1der:array[0..3] of byte = ($36,$36,$45,$0D);
  buffermov1izq:array[0..3] of byte = ($37,$37,$45,$0D);
  buffermov2der:array[0..3] of byte = ($38,$38,$45,$0D);
  buffermov2izq:array[0..3] of byte = ($39,$39,$45,$0D);
const
  th=80;

implementation

{$R *.fmx}
 uses FMX.Helpers.Android;


procedure Tmainform.Button3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
if MotionSensor1.Active then
begin
  sw_mov1:= true;
  sw_apagar:=false;
  sw_pressedatras:=true;
end;
end;

procedure Tmainform.Button3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin

if not(MotionSensor1.Active) then
begin
  if X > ( button3.Position.X + Button3.Width)  then
  begin
      sw_movdir2d := true;
      sw_movdir2i:= false;
      sw_mov1:= false;
      sw_apagar:=false;
  end;

  if X < (button3.Position.X) then
  begin
      sw_movdir2i:= true;
      sw_movdir2d := false;
      sw_mov1:= false;
      sw_apagar:=false;
  end;

  if (X < ( button3.Position.X + Button3.Width))and (X > (button3.Position.X))then
  begin
    sw_movdir2d := false;
    sw_movdir2i := false;
    sw_mov1:= true;
    sw_apagar:=false;
  end;

  Label8.Text:= FloatToStr(X);
  end;
end;

procedure Tmainform.Button3MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  sw_mov1:= false;
  sw_mov2:=false;
  sw_movdir1i := false;
  sw_movdir1d:= false;
  sw_apagar:= true;
  sw_dir1:= false;
  sw_dir2:= false;
  sw_movdir2i:= false;
  sw_movdir2d:= false;
  sw_pressedatras:= false;
  sw_pressedadelante:= false;
end;

procedure Tmainform.Button4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
if MotionSensor1.Active then
begin
  sw_mov2:= true;
  sw_pressedadelante:= true;
  sw_apagar:=false;
end;
end;

procedure Tmainform.Button4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
 i1:integer;
begin
if not(MotionSensor1.Active) then
begin
  if X > ( button4.Position.X + Button4.Width)  then
  begin
      sw_movdir1d := true;
      sw_movdir1i:= false;
      sw_mov2:= false;
      sw_apagar:=false;
  end;

  if X < (button4.Position.X) then
  begin
    sw_movdir1i:= true;
    sw_movdir1d := false;
    sw_mov2:= false;
    sw_apagar:=false;
  end;

  if (X < ( button4.Position.X + Button4.Width))and (X > (button4.Position.X))then
  begin
    sw_movdir1d := false;
    sw_movdir1i := false;
    sw_mov2:= true;
    sw_apagar:=false;
  end;

  Label8.Text:= FloatToStr(X);

  end;
end;

procedure Tmainform.Button4MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  sw_mov1:= false;
  sw_mov2:=false;
  sw_movdir1i := false;
  sw_movdir1d:= false;
  sw_apagar:= true;
  sw_dir1:= false;
  sw_dir2:= false;
  sw_movdir2i:= false;
  sw_movdir2d:= false;
  sw_pressedadelante:= false;
end;

procedure Tmainform.Button5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  sw_dir2:= true;
  sw_apagar:=false;

end;

procedure Tmainform.Button5MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  sw_dir2:= false;
  sw_apagar:=true;

end;

procedure Tmainform.Button6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  sw_dir1:= true;
  sw_apagar:=false;
end;

procedure Tmainform.Button6MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  sw_dir1:= false;
  sw_apagar:=true;
end;

procedure Tmainform.Button7Click(Sender: TObject);
begin
  MotionSensor1.Active:= not(MotionSensor1.Active);
  if Rectangle1.Fill.Color = TAlphaColorRec.Greenyellow then
  begin
    Rectangle1.Fill.Color:= TAlphaColorRec.Red;
  end
  else
  begin
    Rectangle1.Fill.Color:= TAlphaColorRec.Greenyellow;
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  s3:= '0';
  sw:= false;
  sw_secuencia:=0;
  sw_pressedadelante:=false;
  sw_pressedatras:=false;
end;

procedure Tmainform.FormShow(Sender: TObject);
var
  s:string;
  i:integer;
  list:TStringList;
begin
  list:=TStringList.Create;
  s:=checkBluetooth;                       // Comprueba si el Servicio de Bluetooth  està activado
  Toast(s);
  if pos('disabled',s)<>0 then exit;

  // Este es id por defecto para la conexiòn serial bluetooth SPP UUID
  uid:=TJUUID.JavaClass.fromString(stringtojstring('00001101-0000-1000-8000-00805F9B34FB'));

  list.Clear;
  list.AddStrings(getbonded);    //lista de adaptadores sincronizados
  for i := 0 to list.Count-1 do
  begin
  listview1.Items.Add;
  listview1.Items.Item[i].Text:=list[i].Split(['='])[0];
  listview1.Items.Item[i].Detail:=list[i].Split(['='])[1];
  end;


end;

procedure Tmainform.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  Toast('Seleccionado '+Aitem.Text);
  targetMAC:=Aitem.Detail;
  if trim(targetMAC)='' then exit;

  Adapter:=TJBluetoothAdapter.JavaClass.getDefaultAdapter;
  remoteDevice:=Adapter.getRemoteDevice(stringtojstring(targetMAC));
  Toast('Conectando a '+Aitem.Text+' ('+Aitem.Detail+')');
  sock:=remoteDevice.createRfcommSocketToServiceRecord(UID);
  try sock.connect;
  except Toast('No se puede crear el registro del servicio!');
  end;
  if not sock.isConnected then
  begin
    Toast('Fallo al conectar al '+ targetMAC +'! Intente de nuevo...');
    exit;
  end;
  Toast('Conectado!');
  listview1.Visible:=false;                 // escoder la lista
  label1.Visible:=false;
  reload.Visible:=false;

  ostream:=sock.getOutputStream;           // registro de entrada y salidas de datos
  istream:=sock.getInputStream;


  Application.ProcessMessages;

  sleep(200);
  ostream.write(ord(13)); //
  sleep(200);
  timer3.Enabled:=true;
  timer1.Enabled:=True;
  MotionSensor1.Active:=true;

end;

procedure Tmainform.MotionSensor1DataChanged(Sender: TObject);
var
  X:double;
begin
  label9.Text:= FloatToStr(MotionSensor1.Sensor.AccelerationY * 80);
  X:= MotionSensor1.Sensor.AccelerationY * 80;


  if X > 150  then
  begin

    if  sw_pressedadelante then
    begin
      sw_movdir1d := true;
      sw_movdir1i:= false;
      sw_mov2:= false;
      sw_apagar:=false;
    end;

    if  sw_pressedatras then
    begin
      sw_movdir2d := true;
      sw_movdir2i:= false;
      sw_mov1:= false;
      sw_apagar:=false;
    end;

  end;

  if X < (-150) then
  begin

    if  sw_pressedadelante then
    begin
      sw_movdir1i:= true;
      sw_movdir1d := false;
      sw_mov2:= false;
      sw_apagar:=false;
    end;

    if  sw_pressedatras then
    begin
      sw_movdir2d := false;
      sw_movdir2i:= true;
      sw_mov1:= false;
      sw_apagar:=false;
    end;

  end;

  if (X < 150)and (X > (-150))then
  begin
    if  sw_pressedadelante then
    begin
      sw_movdir1d := false;
      sw_movdir1i := false;
      sw_mov2:= true;
      sw_apagar:=false;
    end;

    if  sw_pressedatras then
    begin
      sw_movdir2d := false;
      sw_movdir2i := false;
      sw_mov1:= true;
      sw_apagar:=false;
    end;

  end;

  Label8.Text:= FloatToStr(X);

end;

procedure Tmainform.Timer1Timer(Sender: TObject);
var
  len,i:integer;
  s:string;
  buffer:TJavaArray<byte>;
begin
  len:=istream.available;
  if len=0 then exit;
  buffer:=TJavaArray<byte>.create(len);
  istream.read(buffer,0,len);
  s:='';
  for i:=0 to len-1 do
  begin
    s:= s + char(buffer[i]);
  end;
  label7.Text:= s;
end;



procedure Tmainform.Timer3Timer(Sender: TObject);
var
 i1:integer;
begin

  if sw_movdir2d = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffermov2der[i1]);
    end;
  end;
  if sw_movdir2i = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffermov2izq[i1]);
    end;
  end;


  if sw_movdir1d = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffermov1der[i1]);
    end;
  end;
  if sw_movdir1i = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffermov1izq[i1]);
    end;
  end;


  if sw_mov1 = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffer[i1]);
    end;
  end;


  if sw_mov2 = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffer2[i1]);
    end;
  end;

  if sw_dir1 = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffer3[i1]);
    end;
  end;

  if sw_dir2 = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffer4[i1]);
    end;
  end;


  if sw_apagar = true then
  begin
    for i1 := 0 to 3 do
    begin
      ostream.write(buffer5[i1]);
    end;
  end;

end;

end.
