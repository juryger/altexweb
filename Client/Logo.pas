unit Logo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls;

type
  TLogoForm = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Panel7: TPanel;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure Panel7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ms_down: boolean;
    X1, Y1: Integer;
  public
    { Public declarations }
  end;

var
  LogoForm: TLogoForm;

implementation

uses MAIN, Rekvizits;

{$R *.DFM}

procedure TLogoForm.CreateParams( var Params : tCreateParams ) ;
begin
   // Убрать заголовок
   Inherited CreateParams( Params ) ;
   Params.Style := Params.Style and (not WS_CAPTION) ;
end;

procedure TLogoForm.SpeedButton3Click(Sender: TObject);
begin
   Close();
end;

procedure TLogoForm.SpeedButton1Click(Sender: TObject);
begin
   LogoForm.WindowState :=  wsMinimized;
end;

procedure TLogoForm.Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Panel1MouseMove(Sender,Shift,X,Y);
   if ((X>=0)and(X<=Panel2.Width)and(Y>=0)and(Y<=Panel2.Height)) then begin
      Panel2.Font.Color := clPurple;
      Panel2.Color := clLime;
   end;
end;

procedure TLogoForm.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Panel2.Font.Color := clGreen; Panel2.Color := $0080FFFF;
   Panel4.Font.Color := clGreen; Panel4.Color := $0080FFFF;
   Panel5.Font.Color := clGreen; Panel5.Color := $0080FFFF;
   Panel6.Font.Color := clGreen; Panel6.Color := $0080FFFF;
   Panel7.Font.Color := clGreen; Panel7.Color := $0080FFFF;
end;

procedure TLogoForm.Panel4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Panel1MouseMove(Sender,Shift,X,Y);
   if ((X>=0)and(X<=Panel4.Width)and(Y>=0)and(Y<=Panel4.Height)) then begin
      Panel4.Font.Color := clPurple;
      Panel4.Color := clLime;
   end;
end;

procedure TLogoForm.Panel5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Panel1MouseMove(Sender,Shift,X,Y);
   if ((X>=0)and(X<=Panel5.Width)and(Y>=0)and(Y<=Panel5.Height)) then begin
      Panel5.Font.Color := clPurple;
      Panel5.Color := clLime;
   end;
end;

procedure TLogoForm.Panel6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Panel1MouseMove(Sender,Shift,X,Y);
   if ((X>=0)and(X<=Panel6.Width)and(Y>=0)and(Y<=Panel6.Height)) then begin
      Panel6.Font.Color := clPurple;
      Panel6.Color := clLime;
   end;
end;

procedure TLogoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   MainForm.IsLogoClosed := true;
end;

procedure TLogoForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ms_down := true;
   X1 := X; Y1 := Y;
end;

procedure TLogoForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if (ms_down) then begin
      LogoForm.Left := LogoForm.Left + X - X1;
      LogoForm.Top  := LogoForm.Top  + Y - Y1;
   end;
   Panel2.Font.Color := clGreen; Panel2.Color := $0080FFFF;
   Panel4.Font.Color := clGreen; Panel4.Color := $0080FFFF;
   Panel5.Font.Color := clGreen; Panel5.Color := $0080FFFF;
   Panel6.Font.Color := clGreen; Panel6.Color := $0080FFFF;
   Panel7.Font.Color := clGreen; Panel7.Color := $0080FFFF;
end;

procedure TLogoForm.FormCreate(Sender: TObject);
begin
   ms_down := false;
end;

procedure TLogoForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ms_down := false;
end;

procedure TLogoForm.Panel2Click(Sender: TObject);
begin
   MainForm.OpenPriceForm(Sender);
end;

procedure TLogoForm.Panel4Click(Sender: TObject);
begin
   MainForm.OpenNaklForm(Sender);
end;

procedure TLogoForm.Panel5Click(Sender: TObject);
begin
   MainForm.OpenSkladForm(Sender);
end;

procedure TLogoForm.Panel7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Panel1MouseMove(Sender,Shift,X,Y);
   if ((X>=0)and(X<=Panel7.Width)and(Y>=0)and(Y<=Panel7.Height)) then begin
      Panel7.Font.Color := clPurple;
      Panel7.Color := clLime;
   end;
end;

procedure TLogoForm.Panel7Click(Sender: TObject);
begin
   Panel7.Font.Color := clPurple;
   Panel7.Font.Color := clGreen; Panel7.Color := $0080FFFF;
   RekForm.ShowModal;
end;

procedure TLogoForm.FormShow(Sender: TObject);
begin
    Height := 150;
end;

end.
