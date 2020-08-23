//////////////////////////////////////////////////////////////////////////////////////
//
//    ----- BDE 4GB PATCH -----
//  Version 1.01
//
//
//
//  FUNCTION
//
//    This unit is a patch for the famous 4Gb BDE Bug.  It is build to fix the
//    'Insufficient disk space'-error which can occur while using BDE when
//    the disk free space is near to a multiple of 4Gb.  For more information
//    please see BDE report# 7089 on Quality Central.
//
//  TECH DETAILS
//
//    The reason for the error in BDE is aparently a bug in idapi32.dll while
//    computing free disk space. Idapi32.dll  is using  the api function called
//    GetDiskFreeSpaceA exported by kernel32.dll.
//    The solution is to 'patch' GetDiskFreeSpaceA in kernel32.dll for the current
//    process, every call to this function is redirected to a new routine
//    (NewGetDiskFreeSpaceA).
//
//  USAGE
//
//    Just include this unit in your at the top of the uses clause in your project.
//
//
//  2004-02-26
//  (c) Reinaldo Roberto Yañez Arrey
//  Buenos Aires, Argentina
//  ryaayr@yahoo.com, ryaayr@arnet.com.ar
//  Any feedback is welcome!
//
//  Disclaimer:
//    The code and text in this unit are not associated with Borland. This unit is
//    provided "as is"! The author takes no responsibility for use, or misuse, of
//    this unit. Usage of this code is at your own risk.
//  License:
//    You are free to use this unit in any way, but beware that BDE is an
//    official Borland product, and therefore bound by the terms and conditions of
//    the Borland product license.
//
//////////////////////////////////////////////////////////////////////////////////////
// Thanks to:
//          Leonardo Mato & Manuel E. Parma
//                   for their encouragement to produce good code.
//////////////////////////////////////////////////////////////////////////////////////
//
// History: 2004-03-05    Version 1.01  (Fixes a problem on finalization if using packages)
//          2004-02-26    Version 1.00  (Created)
//
//////////////////////////////////////////////////////////////////////////////////////

unit FixBDE4GbBug;

interface

procedure PatchBDE;

implementation

uses Windows;


type
  TRYPatch = record
    OrgAddr: Pointer;
    OrgBytes: array[0..4] of Byte;
  end;

// Este metodo nunca lo vi escrito correctamente para contemplar los casos de
// usar packages o no.
// Si se utilizan packages HAY que preguntar por el $25FF y patchear el puntero a
// puntero a puntero
// Sino, no se patchea absolutamente nada !!!!
// Ry@2003.10.31
function RedirectByRY(OldPtr, NewPtr: Pointer): TRYPatch;
type
  PPtr=^pointer;
  PPPtr=^PPtr;
  TByteArray=array[0..maxint-1] of byte;
  PByteArray=^TByteArray;
var
  OldProtect,
  Protect   : DWORD;
  p: PByteArray;
begin
  if PWord(OldPtr)^ = $25FF then
  begin {Es un JMP DWORD PTR [XXXXXXX](=> Esta utilizando Packages)}
    p := OldPtr;
    OldPtr := (PPPtr(@p[2])^)^;
  end;
  VirtualProtect(OldPtr, 5, PAGE_READWRITE, @OldProtect);
  result.OrgAddr := OldPtr;
  result.OrgBytes[0] := PByte(OldPtr)^;
  result.OrgBytes[1] := PByte(Integer(OldPtr) + 1)^;
  result.OrgBytes[2] := PByte(Integer(OldPtr) + 2)^;
  result.OrgBytes[3] := PByte(Integer(OldPtr) + 3)^;
  result.OrgBytes[4] := PByte(Integer(OldPtr) + 4)^;

  PByte(OldPtr)^:= $E9;
  PInteger(Integer(OldPtr)+1)^ := Integer(NewPtr) - Integer(OldPtr) - 5;
  VirtualProtect(OldPtr, 5, OldProtect, @Protect);
  FlushInstructionCache(GetCurrentProcess, OldPtr, 5);
end;

procedure RestorePatch(RestorePatch: TRYPatch);
var
  OldProtect,
  Protect   : DWORD;
  OldPtr: Pointer;
begin
  OldPtr := RestorePatch.OrgAddr;
  VirtualProtect(OldPtr, 5, PAGE_READWRITE, @OldProtect);
  PByte(OldPtr)^ := RestorePatch.OrgBytes[0];
  PByte(Integer(OldPtr) + 1)^ := RestorePatch.OrgBytes[1];
  PByte(Integer(OldPtr) + 2)^ := RestorePatch.OrgBytes[2];
  PByte(Integer(OldPtr) + 3)^ := RestorePatch.OrgBytes[3];
  PByte(Integer(OldPtr) + 4)^ := RestorePatch.OrgBytes[4];
  VirtualProtect(OldPtr, 5, OldProtect, @Protect);
  FlushInstructionCache(GetCurrentProcess, OldPtr, 5);
end;


function NewGetDiskFreeSpaceA(lpPath: LPCTSTR; lpSectorsPerCluster: LPDWORD
; lpBytesPerSector: LPDWORD; lpNoFreeClusters: LPDWORD;
lpTotalNoClusters: LPDWORD): LongBool; stdcall;
var
  FreeBytesAvailableToCaller, TotalNoBytes,
  TotalNoFreeBytes: ULARGE_INTEGER;

  PFreeBytesAvailableToCaller, PTotalBytes,
  PTotalFreeBytes: PLargeInteger;
begin
  PFreeBytesAvailableToCaller := @FreeBytesAvailableToCaller;
  PTotalBytes := @TotalNoBytes;
  PTotalFreeBytes := @TotalNoFreeBytes;

  result := GetDiskFreeSpaceEx(lpPath,
    PFreeBytesAvailableToCaller,
    PTotalBytes, PTotalFreeBytes);
  if not result then Exit;

  lpSectorsPerCluster^ := 1;
  lpBytesPerSector^ := 1;

  if (FreeBytesAvailableToCaller.QuadPart > $ffffffff) then
    lpNoFreeClusters^ := $ffffffff
  else
    lpNoFreeClusters^ := FreeBytesAvailableToCaller.QuadPart;
  lpTotalNoClusters^ := $ffffffff;
end;


var
  kernel32: HMODULE;
  ProcAddr: Pointer;
  RestoreP: TRYPatch;

procedure PatchBDE;
begin
  kernel32 := LoadLibrary('kernel32');
  ProcAddr := GetProcAddress(kernel32, 'GetDiskFreeSpaceA');
  RestoreP := RedirectByRy(ProcAddr, @NewGetDiskFreeSpaceA);
end;

procedure UnPatchDBE;
begin
  {Leave everything as before, just in case...}
  RestorePatch(RestoreP);
  FreeLibrary(kernel32);
end;


initialization
  PatchBDE;

finalization
  UnPatchDBE;

end.



