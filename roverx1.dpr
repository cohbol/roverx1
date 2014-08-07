program roverx1;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {mainform},
  Androidapi.JNI.Speech in 'Androidapi.JNI.Speech.pas',
  Androidapi.JNI.TTS in 'Androidapi.JNI.TTS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.soInvertedLandscape];
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
