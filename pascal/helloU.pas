unit helloU;

{$link chello.o}
{$linklib c}

interface

uses CTypes;

procedure PrintHello; cdecl; external;
procedure PrintHelloS(nme : ctypes.cint32); cdecl; external;

implementation

end.
