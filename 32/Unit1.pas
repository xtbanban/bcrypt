unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, EncdDecd;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses bolwfish;

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i: integer;
  b, e: Int64;
  S: string;
begin
  b := 0;
  S := EncodeString(Edit1.Text);
  for i := 1 to Length(S) do
    b := b + ord(S[i]) * 10;
  Edit4.Text := S;
  BlowFish_Init(edit3.Text);
  e := BlowFish_DN(b);
  Edit2.Text := IntToHex(e, 0);
  Edit6.Text := IntToStr(e);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i: integer;
  b: Int64;
  S: string;
begin
  BlowFish_Init(edit3.Text);
  b := StrToIntDef(Edit2.Text, 0);
  Edit5.Text := IntToHex(BlowFish_EN(b), 0);
end;

end.

