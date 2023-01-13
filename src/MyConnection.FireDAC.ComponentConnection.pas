unit MyConnection.FireDAC.ComponentConnection;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  {$ifndef CONSOLE}  FireDAC.VCLUI.Wait,
  {$EndIf}  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Comp.UI,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  MyConnection.Interfaces,
  MyConnection.Configuration;

type
  TMyFireDACConnection = class(TInterfacedObject, iMyConnectionComponent)
  private
    FConnection: TFDConnection;
    function TestFieldsComponentConnection: iMyConnectionComponent;
  protected
    function Component: TComponent;
    function TestConnectionOnly: Boolean;
    function TestConnection: Boolean;
    function Open: iMyConnectionComponent;
    function Close: iMyConnectionComponent;
    function LoadConnectionConfig: iMyConnectionComponent;
  public
    class function New: iMyConnectionComponent;
    constructor Create;
    destructor Destroy; override;
  end;

var
 FConnectionFireDac: TMyFireDACConnection;

implementation

class function TMyFireDACConnection.New: iMyConnectionComponent;
begin
   if(TMyConnetionConfiguration.New.ConnectionSingleton)then
   begin
      if(not Assigned(FConnectionFireDac))then
         FConnectionFireDac := Self.Create;

      Result := FConnectionFireDac;
   end
   else
   begin
      Result := Self.Create;
   end;
end;

constructor TMyFireDACConnection.Create;
begin
   FConnection  := TFDConnection.Create(nil);
   Self.LoadConnectionConfig;
end;

destructor TMyFireDACConnection.Destroy;
begin
   if(Assigned(FConnection))then
      FreeAndNil(FConnection);

   inherited;
end;

function TMyFireDACConnection.Component: TComponent;
begin
   Self.TestFieldsComponentConnection;
   Result := FConnection;
end;

function TMyFireDACConnection.TestConnectionOnly: Boolean;
begin
   Result := False;
   try
     Result := Self.TestConnection;
   except
   end;
end;

function TMyFireDACConnection.TestConnection: Boolean;
var
 vOld: Boolean;
begin
   Self.TestFieldsComponentConnection;
   try
     vOld                  := FConnection.Connected;
     FConnection.Connected := True;
     Result                := FConnection.Connected;

     if(FConnection.Connected <> vOld)then
       FConnection.Connected := vOld;

   except on E: exception do
     raise Exception.Create('Conexão não pode ser realizada: ' + E.Message);
   end;
end;

function TMyFireDACConnection.Open: iMyConnectionComponent;
begin
   Result := Self;
   Self.TestFieldsComponentConnection;
   FConnection.Connected := True;
end;

function TMyFireDACConnection.Close: iMyConnectionComponent;
begin
   Result := Self;
   FConnection.Connected := False;
end;

function TMyFireDACConnection.LoadConnectionConfig: iMyConnectionComponent;
begin
   Result := Self;
   FConnection.Connected := False;
   FConnection.Params.Clear;
   FConnection.Params.DriverID :=     TMyConnetionConfiguration.New.DriverID;
   FConnection.Params.Database :=     TMyConnetionConfiguration.New.Database;
   FConnection.Params.UserName :=     TMyConnetionConfiguration.New.UserName;
   FConnection.Params.Password :=     TMyConnetionConfiguration.New.Password;
   FConnection.Params.Add('Server=' + TMyConnetionConfiguration.New.Host);
   FConnection.Params.Add('Port='   + TMyConnetionConfiguration.New.Port);
end;

function TMyFireDACConnection.TestFieldsComponentConnection: iMyConnectionComponent;
var
 vTemp: string;
begin
   Result := Self;
   vTemp  := EmptyStr;

   if(Trim(TMyConnetionConfiguration.New.DriverID) = EmptyStr)then
     vTemp := vTemp + 'DriverID. ';

   if(Trim(TMyConnetionConfiguration.New.Database) = EmptyStr)then
     vTemp := vTemp + 'Host. ';

   if(Trim(FConnection.Params.UserName) = EmptyStr)then
     vTemp := vTemp + 'Usuário. ';

   if(Trim(FConnection.Params.Password) = EmptyStr)then
     vTemp := vTemp + 'Senha. ';

   if(Trim(FConnection.Params.Database) = EmptyStr)then
     vTemp := vTemp + 'Nome banco.';

   if(vTemp <> EmptyStr)then
     raise Exception.Create('Para realizar a conexão com o banco de dados '+
                            'os seguintes dados devem ser preenchidos: ' + sLineBreak +
                            vTemp);
end;

end.
