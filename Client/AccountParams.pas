unit AccountParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfrmAccountParams = class(TForm)
    dtpAccountDate: TDateTimePicker;
    Label1: TLabel;
    Label4: TLabel;
    tbAccNo: TEdit;
    btCancel: TBitBtn;
    btOkay: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    tbPercentageValue: TEdit;
    procedure tbAccNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    HasNDS: Boolean;
  end;

var
  frmAccountParams: TfrmAccountParams;

implementation

uses dbModule;

{$R *.dfm}

procedure TfrmAccountParams.tbAccNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  // float - if not (Key in ['0'..'9', '.', #8, #9]) then Key := #0;
  if not (Key in ['0'..'9']) then
    Key := #0;
end;

procedure TfrmAccountParams.FormCreate(Sender: TObject);
begin
    dtpAccountDate.Date := date;
end;

procedure TfrmAccountParams.RadioButton1Click(Sender: TObject);
begin
  HasNDS := false;
  tbPercentageValue.Enabled := false;
end;

procedure TfrmAccountParams.RadioButton2Click(Sender: TObject);
begin
  HasNDS := true;
  tbPercentageValue.Enabled := true;
end;

end.
