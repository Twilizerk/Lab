unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, math, Vcl.StdCtrls, clipbrd,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs,
  VCLTee.Chart, Vcl.Imaging.pngimage, VCLTee.Series;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Image1: TImage;
    Chart1: TChart;
    Series1: TLineSeries;
    Button7: TButton;
    Button8: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Label11: TLabel;
    Edit11: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  a,b,N:integer;
  G:real;

implementation

{$R *.dfm}
Function fun(x,l,m:real):real;
begin
 Fun:=l*Power(x,4)+m*Power(x,3);
end;

Function funt(a,b,l,m:real):real;
begin
  funt:=(l*(Power(b,5)/5-Power(a,5)/5))+(m*(power(b,4)/4-power(a,4)/4));
end;

Function t1(x,l,m:real):real;
begin
 t1:=12*l*sqr(x)+6*m*x;
end;

Function Int(a,b,l,m:real; N:integer):real;
var x,h, S :real; i :integer;
begin
h:=(b-a)/N;
S:=(fun(a,l,m)+fun(b,l,m))/2;
For i:=1 to N-1 do begin
x:=a+i*h;
S:=S+fun(x,l,m);
end;
Int:=S*h;
end;


procedure TForm2.Button1Click(Sender: TObject);
var h,y,x,Rez,l,m,Rezt,p,e,t,V,W,d:real;
    I: Integer;
begin
a:=strtoint(edit1.text);
b:=strtoint(edit2.text);
l:=strtofloat(edit4.text);
m:=strtofloat(edit5.text);
e:=Power(10,-1*strtofloat(Edit9.Text));
N:=2;
 h:=(b-a)/N;
 V:=int(a,b,l,m,N);
 repeat
  begin
   N:=2*N;
   W:=int(a,b,l,m,N);
   d:=abs(W-V);
   V:=W;
  end;
until d<e;
Rez:=W;
Rezt:=funt(a,b,l,m);
h:=(b-a)/N;
Edit6.Text:=floattostrf(Rez,ffFixed,10,5);
Edit7.Text:=floattostrf(Rezt,ffFixed,10,5);
p:=Rez-Rezt;
Edit8.Text:=floattostrf(p,ffFixed,10,5);
Memo1.Lines.Add('Верхний предел a= '+inttostr(a)+' нижний предел b= '+inttostr(b)+
' l= '+floattostr(l)+' m= '+floattostr(m));
Memo1.Lines.Add('Значение квадратурами: '+Edit6.Text);
Memo1.Lines.Add('Точное значения: '+Edit7.Text);
Memo1.Lines.Add('Погрешность: '+Edit8.Text);
Edit10.Text:=inttostr(N);
Edit11.Text:=floattostr(h);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
 Edit1.Clear;
 Edit2.Clear;
 Edit4.Clear;
 Edit5.Clear;
 Edit6.Clear;
 Edit7.Clear;
 Edit8.Clear;
 Edit1.Setfocus;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
 Memo1.Lines.Clear;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
 Memo1.Lines.SaveToFile('Results.txt');
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
 ActivateKeyboardLayout(LoadKeyboardLayout('00000419',0),0);
 Clipboard.Create;
 ClipBoard.SetTextBuf(Memo1.Lines.GetText);
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
 if FileExists('Results.txt')
 then Memo1.Lines.LoadFromFile('Results.txt')
 else ShowMessage('Файл отсутствует');
end;

procedure TForm2.Button7Click(Sender: TObject);
var h,y,x,l,m:real;
    I: Integer;
begin
 a:=strtoint(edit1.text);
 b:=strtoint(edit2.text);
 l:=strtofloat(edit4.text);
 m:=strtofloat(edit5.text);
 h:=(b-a)/200;
 for I := 0 to 200 do
   begin
     x:=a+i*h;
     y:=fun(x,l,m);
     Chart1.Series[0].AddXY(x,y,'',clteecolor);
   end;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
Chart1.Series[0].Clear;
end;

end.
