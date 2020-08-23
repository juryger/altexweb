unit fullImageView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TFullImageViewForm = class(TForm)
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    imgImage: TImage;
  end;

var
  FullImageViewForm: TFullImageViewForm;

implementation

{$R *.DFM}


procedure TFullImageViewForm.FormShow(Sender: TObject);
begin
   Image1.Picture.Bitmap.Assign(imgImage.Picture.Bitmap);
end;

end.

