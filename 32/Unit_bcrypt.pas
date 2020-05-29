unit Unit_bcrypt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit_key: TEdit;
    Label2: TLabel;
    Edit_output: TEdit;
    BitBtn_bcrypt: TBitBtn;
    BitBtn_check: TBitBtn;
    Label_tip: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Edit_rounds: TEdit;
    procedure BitBtn_bcryptClick(Sender: TObject);
    procedure BitBtn_checkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function checkpw(
      input: PChar;
      bcrypt_output: PChar): Integer;
    stdcall; external 'bcrypt32.dll';
function bcrypt_output_sure(
      input: PChar;
      rounds: integer;
      times: integer;
      rand_num: integer;
      debug: boolean): PChar;
    stdcall; external 'bcrypt32.dll';

procedure TForm1.BitBtn_bcryptClick(Sender: TObject);
var
  p1, p2: PChar;
  S: string;
  I: integer;
begin
  S := Trim(Edit_key.Text);
  if (S = '') then
  begin
    Label_tip.Caption := 'Pleas input key.';
    Exit;
  end;
  I := StrToIntDef(Edit_rounds.Text, 8);
  if (I < 8) or (I > 31) then I := 8;
  Edit_rounds.Text := IntToStr(I);
  Edit_output.Text := '';
  Edit_output.Refresh;
  p1 := pchar(S);
  p2 := bcrypt_output_sure(p1, I, 10, 1, false);
  Edit_output.Text := p2;
  Label_tip.Caption := '';
end;

procedure TForm1.BitBtn_checkClick(Sender: TObject);
var
  p1, p2: PChar;
begin
  p1 := pchar(Trim(Edit_key.Text));
  p2 := pchar(Trim(Edit_output.Text));
  if (checkpw(p1, p2) = 1) then
  begin
    Label_tip.Caption := 'Check OK.';
  end else
  begin
    Label_tip.Caption := 'Check Erro!';
  end;
end;

end.
