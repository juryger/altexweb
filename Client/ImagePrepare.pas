unit ImagePrepare;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TImageEditorForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    panelSrc: TPanel;
    panelDst: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    imageSrc: TImage;
    imageDst: TImage;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    trackBarZoomer: TTrackBar;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure trackBarZoomerChange(Sender: TObject);
    procedure imageSrcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imageSrcMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imageSrcMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure LoadOriginalImage(img: TImage);
    procedure TransformedImage();
    procedure DrawRectangle();
    function LoadFromFile(fileName: String): TImage;
    function DefineStartOutputPosition(destinationSize: TPoint; sourceSize: TPoint): TPoint;
  public
    { Public declarations }
    imgFileName: string;
    imgImage: TImage;
    procedure Dispose();
  end;

var
   ImageEditorForm: TImageEditorForm;

   // This variable denote selection boundaries
   startSelectionPoint, endSelectionPoint: TPoint;

   // flag used for drawing selection rectangle
   drawing: Boolean;

   // константы исходного и преобразуемого изображений
   const ConstDestinationImageSize: integer = 400;
   const ConstSourceImageSize: integer = 400;
   const ConstStorageImageSize: integer = 400;

implementation

{$R *.DFM}

procedure TImageEditorForm.FormShow(Sender: TObject);
begin
   if (imgFileName <> '') then begin
      imgImage := LoadFromFile(imgFileName);
      if (imgImage = nil) then
         raise Exception.Create('Не удается загрузить изображение из указанного файла, обратитесь к разработчику.')
   end
   else if (imgImage = nil) then
      raise Exception.Create('Не удается загрузить изображение из БД, обратитесь к разработчику.');

   // Load Original Image
   imgImage.AutoSize := true;
   LoadOriginalImage(imgImage);

   // Load Transformed Image
   startSelectionPoint := Point(0, 0);
   endSelectionPoint := Point(imageSrc.Width, imageSrc.Height);
   TransformedImage;

   imgImage.Picture.Bitmap.FreeImage;
   imgImage.Picture.Assign(nil);
end;

//------------------------------------------------------------------------------
// Prepare Load Picture From File
//------------------------------------------------------------------------------
function TImageEditorForm.LoadFromFile(fileName: String): TImage;
var
   imageTemp: TImage;
begin
   if fileName = '' Then
      raise Exception.Create('Переменная FileName не задана, обратитесь к разработчику.');

   imageTemp := TImage.Create(Self);
   imageTemp.Picture.LoadFromFile(imgFileName);

   Result := imageTemp;
end;

//------------------------------------------------------------------------------
// Load original image to the Left Screen's place holder
//------------------------------------------------------------------------------
procedure TImageEditorForm.LoadOriginalImage(img: TImage);
var
   bitMapTemp: TBitmap;
begin
   if (img.Height >= img.Width) then begin
      imageSrc.Height := ConstSourceImageSize;
      imageSrc.Width := MulDiv(imageSrc.Height,  img.Width, img.Height);
   end
   else begin
      imageSrc.Width := ConstSourceImageSize;
      imageSrc.Height := MulDiv(imageSrc.Width,  img.Height, img.Width);
   end;

   with ImageSrc.Canvas.Pen do begin
      Style := psDot;
      Mode := pmXor;
   end;

   bitMapTemp := TBitmap.Create;
   try
       try
         bitMapTemp.Width := imageSrc.Width;
         bitMapTemp.Height := imageSrc.Height;

         // Copy the selected part of the image
         bitMapTemp.Canvas.StretchDraw(
            Rect(0, 0, imageSrc.Width, imageSrc.Height)
            , img.Picture.Graphic);

         ImageSrc.Picture.Bitmap.Assign(bitMapTemp);
        except
            on E: Exception do begin
                ShowMessage('Во время загрузки изображение возникла ошибка = ' +
                E.Message + ' Обратитесь к разработчику.');
        end;
       end;
   finally
      bitMapTemp.FreeImage;
   end;

end;

//------------------------------------------------------------------------------
// Transform size of the original image and load it to the right screen's place
// holder
//------------------------------------------------------------------------------
procedure TImageEditorForm.TransformedImage;
var
    sourceImageRect: TRect;
    sourceImageWidth: integer;
    sourceImageHeight: integer;
    bitMapTemp: TBitmap;
    startOutputPoint: TPoint;

    destinationImageWidth: integer;
    destinationImageHeight: integer;
begin
   sourceImageRect :=
        Rect(
            startSelectionPoint.x,
            startSelectionPoint.y,
            endSelectionPoint.x,
            endSelectionPoint.y);

   sourceImageWidth := ABS(sourceImageRect.Right - sourceImageRect.Left);
   sourceImageHeight := ABS(sourceImageRect.Bottom - sourceImageRect.Top);

   // define destination image size & other parameters
   ImageDst.Picture.Assign(nil);
   ImageDst.Canvas.Brush.Color := clWhite;

   // Привести размер изображения к заданному хранилищем
   if (sourceImageHeight >= sourceImageWidth) then begin
      destinationImageHeight := ConstStorageImageSize;
      destinationImageWidth := MulDiv(destinationImageHeight,  sourceImageWidth, sourceImageHeight);
   end
   else begin
      destinationImageWidth := ConstStorageImageSize;
      destinationImageHeight := MulDiv(destinationImageWidth,  sourceImageHeight, sourceImageWidth);
   end;
   ImageDst.Width := ConstStorageImageSize;
   ImageDst.Height := ConstStorageImageSize;
   ImageDst.Picture.Bitmap.Width := ConstStorageImageSize;
   ImageDst.Picture.Bitmap.Height := ConstStorageImageSize;

   // clear destination
   ImageDst.Canvas.FillRect(Rect(0, 0, ImageDst.Width, ImageDst.Height));

   // prepare bitmap
   bitMapTemp := TBitmap.Create;
   try
       try
         bitMapTemp.Width := sourceImageWidth;
         bitMapTemp.Height := sourceImageHeight;

         // Copy the selected part of the image
         bitMapTemp.Canvas.CopyRect(
            Rect(0, 0, sourceImageWidth, sourceImageHeight),
            ImageSrc.Canvas,
            sourceImageRect);

         startOutputPoint :=
            DefineStartOutputPosition(
                Point(ConstStorageImageSize, ConstStorageImageSize),
                Point(destinationImageWidth, destinationImageHeight));
         ImageDst.Canvas.StretchDraw(
            Rect(startOutputPoint.x, startOutputPoint.y, destinationImageWidth + startOutputPoint.x, destinationImageHeight + startOutputPoint.y),
            bitMapTemp);

        except
            on E: Exception do begin
                ShowMessage('Во время загрузки изображение возникла ошибка = ' +
                E.Message + ' Обратитесь к разработчику.');
        end;
       end;
   finally
      bitMapTemp.FreeImage;
   end;
end;

procedure TImageEditorForm.SpeedButton1Click(Sender: TObject);
begin
   if trackBarZoomer.Position < trackBarZoomer.Max then
      trackBarZoomer.Position := trackBarZoomer.Position + trackBarZoomer.Frequency;
end;

procedure TImageEditorForm.SpeedButton2Click(Sender: TObject);
begin
   if trackBarZoomer.Position > trackBarZoomer.Min then
      trackBarZoomer.Position := trackBarZoomer.Position - trackBarZoomer.Frequency;
end;

procedure TImageEditorForm.trackBarZoomerChange(Sender: TObject);
begin
   if (trackBarZoomer.Position >= trackBarZoomer.Min) and
      (trackBarZoomer.Position <= trackBarZoomer.Max) then
   begin
      LoadOriginalImage(imgImage);
      startSelectionPoint := Point(0, 0);
      endSelectionPoint := Point(imageSrc.Width, imageSrc.Height);
      TransformedImage;
   end;
end;

procedure TImageEditorForm.imageSrcMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button = mbLeft then
   begin
      drawing := true;
      startSelectionPoint.x := X;
      startSelectionPoint.y := Y;
      endSelectionPoint.x := X;
      endSelectionPoint.y := Y;
   end;
end;

procedure TImageEditorForm.imageSrcMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   if drawing then
   begin
      DrawRectangle;
      endSelectionPoint.x := X;
      endSelectionPoint.y := Y;
      DrawRectangle;
   end;
end;

procedure TImageEditorForm.imageSrcMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button = mbLeft then
   begin
      drawing := false;
      DrawRectangle;
      TransformedImage;
   end;
end;

procedure TImageEditorForm.DrawRectangle;
var
    p: array [0..4] of TPoint;
begin
   p[0] := startSelectionPoint;
   p[1].x := endSelectionPoint.x;
   p[1].y := startSelectionPoint.y;
   p[2] := endSelectionPoint;
   p[3].x := startSelectionPoint.x;
   p[3].y := endSelectionPoint.y;
   p[4] := startSelectionPoint;
   ImageSrc.Canvas.Polyline(p);
end;

procedure TImageEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      imageSrc.Picture.Bitmap.FreeImage;
      imageSrc.Picture.Assign(nil);

      imgImage.Picture.Bitmap.FreeImage;
      imgImage.Picture.Assign(nil);
end;

procedure TImageEditorForm.Dispose;
begin
      imageDst.Picture.Bitmap.FreeImage;
      imageDst.Picture.Assign(nil);
end;

//------------------------------------------------------------------------------
// Defines Start Output Position for destination image
// destinationSize: size of destination (output) image
// sourceSize: original image size, that should be place to output image
//------------------------------------------------------------------------------
function TImageEditorForm.DefineStartOutputPosition(destinationSize: TPoint; sourceSize: TPoint): TPoint;
var
   startPosition: TPoint;
   destinationMiddlePoint: TPoint;
   sourceMiddlePoint: TPoint;
begin
   startPosition.x := 0;
   startPosition.y := 0;

   destinationMiddlePoint.x := Round(destinationSize.x / 2);
   destinationMiddlePoint.y := Round(destinationSize.y / 2);

   sourceMiddlePoint.x := Round(sourceSize.x / 2);
   sourceMiddlePoint.y := Round(sourceSize.y / 2);

   startPosition.x := Abs(destinationMiddlePoint.x - sourceMiddlePoint.x);
   startPosition.y := Abs(destinationMiddlePoint.y - sourceMiddlePoint.y);

   Result := startPosition;
end;

end.
