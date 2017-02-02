unit AppSettingsHelper;

interface

// msxml, xmldom, XMLIntf, XMLDoc
uses Windows, SysUtils, Dialogs, Classes, XMLDoc, XMLIntf;

function ComputerName: String;
function GetSettingsParam(aowner: TComponent; name: String): String;

implementation

function ComputerName: String;
var
	i: integer;
   size: cardinal;
	buffer: array[0..255] of char;
begin
	Result := '';
	size := 256;
   if GetComputerName(buffer, size) then
   begin
   	i := 0;
      while buffer[i] <> #0 do
      begin
      	Result := Result + buffer[i];
         i := i + 1;
      end;
   end;
end;

function GetSettingsParam(aowner: TComponent; name: String): String;
var
	i: integer;
  	Xml: IXMLDocument;
   root, item, hostItem, settingsItem: IXMLNode;
begin
	Result := '';

  	Xml := TXMLDocument.Create(aowner);
  	Xml.Active := true;
  	Xml.Options := [doNodeAutoIndent];

   try
   	Xml.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'AppSettings.xml');
   except
	   on E: Exception do
      begin
      	MessageDlg('При чтении файла настроек AppSettings.xml возникла ошибка = ' +
   			E.Message + ' Обратитесь к разработчику.',
            mtError, [mbOK], 0);
         exit;
      end;
   end;

   root := Xml.DocumentElement;
   if AnsiCompareText(root.NodeName, 'Settings') <> 0 then
   begin
   	MessageDlg('Внутренняя ошибка - не удалось прочитать файл настроек AppSettings.xml ' +
      	'(корневой элемент должен иметь имя Settings). Обратитесь к разработчику.',
      	mtError, [mbOK], 0);
      exit;
   end;

  	if root.ChildNodes.Count = 0 then
  		exit;

   // цикл по Хостам
   for i:= 0 to root.ChildNodes.Count - 1 do
   begin
   	item := root.ChildNodes[i];
      if item.NodeType <> ntElement then
      	continue;

      if AnsiCompareText(item.GetAttributeNS('name', ''), ComputerName) = 0 then
      begin
         hostItem := item;
      	break;
      end;
   end;

   if (hostItem = nil) then
   	exit;

   // цикл по элементам настроек на данном хосте
   for i:= 0 to hostItem.ChildNodes.Count - 1 do
   begin
   	settingsItem := hostItem.ChildNodes[i];
      if settingsItem.NodeType <> ntElement then
      	continue;

      if AnsiCompareText(settingsItem.GetAttributeNS('name', ''), name) = 0 then
      begin
         Result := settingsItem.GetAttributeNS('value', '');
      	break;
      end;
   end;

end;

end.
