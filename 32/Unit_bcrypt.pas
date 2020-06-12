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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit_key_1: TEdit;
    Edit_output_1: TEdit;
    BitBtn_outpuy_1: TBitBtn;
    BitBtn_check_1: TBitBtn;
    Edit3: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label_note_1: TLabel;
    Bevel4: TBevel;
    Label7: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    SpeedButton_up: TSpeedButton;
    Edit_salt: TEdit;
    Label8: TLabel;
    Bevel13: TBevel;
    Edit_org_1: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton_getsalt: TSpeedButton;
    Label13: TLabel;
    procedure BitBtn_bcryptClick(Sender: TObject);
    procedure BitBtn_checkClick(Sender: TObject);
    procedure BitBtn_outpuy_1Click(Sender: TObject);
    procedure BitBtn_check_1Click(Sender: TObject);
    procedure SpeedButton_upClick(Sender: TObject);
    procedure SpeedButton_getsaltClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  BCrypt;

{$R *.dfm}

function checkpw(
  input: PChar;
  bcrypt_output: PChar): Integer;
  stdcall; external 'bcrypt32.dll';

function bcrypt_output_sure(
  input: PChar;
  rounds: integer;
  times: integer): PChar;
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
  Label_tip.Caption := 'Bcrypt...';
  Label_tip.Refresh;
  p1 := pchar(S);
  p2 := bcrypt_output_sure(p1, I, 10);
  Edit_output.Text := p2;
  Label_tip.Caption := 'Bcrypt finish.';
end;

procedure TForm1.BitBtn_checkClick(Sender: TObject);
var
  p1, p2: PChar;
  S: string;
begin
  S := Trim(Edit_key.Text);
  if (S = '') then
  begin
    Label_tip.Caption := 'Pleas input key.';
    Exit;
  end;  p1 := pchar(Trim(Edit_key.Text));
  p2 := pchar(Trim(Edit_output.Text));
  if (checkpw(p1, p2) = 1) then
  begin
    Label_tip.Caption := 'Check OK.';
  end else
  begin
    Label_tip.Caption := 'Check Erro!';
  end;
end;

procedure TForm1.BitBtn_outpuy_1Click(Sender: TObject);
var
  key, org, salt, output: ansistring;
  keyBtypts, saltBytes: TBytes;
begin
  key := Trim(Edit_key_1.Text);
  org := Trim(Edit_org_1.Text);
  if (key = '') then
  begin
    Label_note_1.Caption := 'Pleas input key.';
    Exit;
  end;
  if (Length(org) < 16) then
  begin
    Label_note_1.Caption := 'org length must move then 16';
    exit;
  end;
  SetLength(keyBtypts, 17);
  Move(org[1], keyBtypts[0], 16);

  salt := BCrypt.BsdBase64Encode(keyBtypts, Length(keyBtypts));
  SetLength(salt, 22);
  
  output := BCrypt.HashPassword(key, salt);

  Edit_output_1.Text := output;
  Edit_salt.Text := salt;

  Label_note_1.Caption := 'Bcrypt ok.';
end;

procedure TForm1.BitBtn_check_1Click(Sender: TObject);
begin
  //
end;

procedure TForm1.SpeedButton_upClick(Sender: TObject);
begin
  Edit_key.Text := Edit_key_1.Text;
  Edit_output.Text := Edit_output_1.Text;
  Label_tip.Caption := '';
  BitBtn_check.Click;
end;

procedure TForm1.SpeedButton_getsaltClick(Sender: TObject);
begin
  Edit_org_1.Text := BCrypt.MyGetSalt;
end;

end.

