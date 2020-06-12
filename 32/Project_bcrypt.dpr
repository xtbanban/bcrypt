program Project_bcrypt;

uses
  Forms,
  Unit_bcrypt in 'Unit_bcrypt.pas' {Form1},
  BCrypt in 'D:\Mytools\Delphi\MyProjects\BCrypt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
