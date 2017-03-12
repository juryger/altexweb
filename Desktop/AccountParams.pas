unit AccountParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfrmAccountParams = class(TForm)
    dtpAccountDate: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    tbPercentageValue: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    tbAccNo: TEdit;
    btCancel: TBitBtn;
    btOkay: TBitBtn;
    procedure tbAccNoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
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

end.
