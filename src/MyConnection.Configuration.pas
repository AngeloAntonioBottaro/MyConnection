unit MyConnection.Configuration;

interface

uses
  System.SysUtils,
  MyConnection.Interfaces,
  MyConnection.Types;

type
  TMyConnetionConfiguration = class(TInterfacedObject, iMyConnectionConfiguration)
  private
    FHost: string;
    FUserName: string;
    FDatabase: string;
    FPort: string;
    FPassword: string;
    FDriverID: string;
    FConnectionComponent: TMyConnectionComponent;
    FConnectionSingleton: Boolean;

    function DesCriptografaSenha(pStr: String): String;
  protected
    function ClearConfiguration: iMyConnectionConfiguration;

    function DriverID(aValue: string): iMyConnectionConfiguration; overload;
    function DriverID: string; overload;
    function Host(aValue: string): iMyConnectionConfiguration; overload;
    function Host: string; overload;
    function UserName(aValue: string): iMyConnectionConfiguration; overload;
    function UserName: string; overload;
    function Database(aValue: string): iMyConnectionConfiguration; overload;
    function Database: string; overload;
    function Port(aValue: string): iMyConnectionConfiguration; overload;
    function Port(aValue: Integer): iMyConnectionConfiguration; overload;
    function Port: string; overload;
    function Password(aValue: string): iMyConnectionConfiguration; overload;
    function Password: string; overload;
    function ComponentTypeFireDac: iMyConnectionConfiguration;
    function ComponentType: TMyConnectionComponent; overload;
    function ConnectionSingletonOn: iMyConnectionConfiguration;
    function ConnectionSingletonOff: iMyConnectionConfiguration;
    function ConnectionSingleton: Boolean;
  public
    class function New: iMyConnectionConfiguration;
    constructor Create;
  end;

var
  FConfiguration: iMyConnectionConfiguration;

implementation

class function TMyConnetionConfiguration.New: iMyConnectionConfiguration;
begin
   if(not Assigned(FConfiguration))then
      FConfiguration := Self.Create;

   Result := FConfiguration;
end;

constructor TMyConnetionConfiguration.Create;
begin
   Self.ClearConfiguration;
end;

function TMyConnetionConfiguration.ClearConfiguration: iMyConnectionConfiguration;
begin
   Result := Self;

   FHost     := EmptyStr;
   FDatabase := EmptyStr;
   FPort     := EmptyStr;
   FPassword := EmptyStr;

   FConnectionComponent := TMyConnectionComponent.Empty;
   FConnectionSingleton := True;
end;

function TMyConnetionConfiguration.DriverID(aValue: string): iMyConnectionConfiguration;
begin
   Result    := Self;
   FDriverID := aValue.Trim;
end;

function TMyConnetionConfiguration.DriverID: string;
begin
   Result := FDriverID;
end;

function TMyConnetionConfiguration.Host(aValue: string): iMyConnectionConfiguration;
begin
   Result := Self;
   FHost  := aValue.Trim;
end;

function TMyConnetionConfiguration.Host: string;
begin
   Result := FHost;
end;

function TMyConnetionConfiguration.UserName(aValue: string): iMyConnectionConfiguration;
begin
   Result    := Self;
   FUserName := aValue.Trim;
end;

function TMyConnetionConfiguration.UserName: string;
begin
   Result := FUserName;
end;

function TMyConnetionConfiguration.Database(aValue: string): iMyConnectionConfiguration;
begin
   Result    := Self;
   FDatabase := aValue.Trim;
end;

function TMyConnetionConfiguration.Database: string;
begin
   Result := FDatabase;
end;

function TMyConnetionConfiguration.Port(aValue: string): iMyConnectionConfiguration;
begin
   Result := Self;
   FPort  := aValue.Trim;
end;

function TMyConnetionConfiguration.Port(aValue: Integer): iMyConnectionConfiguration;
begin
   Result := Self;
   Port(IntToStr(aValue));
end;

function TMyConnetionConfiguration.Port: string;
begin
   Result := FPort;
end;

function TMyConnetionConfiguration.Password(aValue: string): iMyConnectionConfiguration;
begin
   Result    := Self;
   FPassword := aValue.Trim;
end;

function TMyConnetionConfiguration.Password: string;
begin
   Result := Self.DesCriptografaSenha(FPassword);
end;

function TMyConnetionConfiguration.ComponentTypeFireDac: iMyConnectionConfiguration;
begin
   Result               := Self;
   FConnectionComponent := TMyConnectionComponent.Firedac;
end;

function TMyConnetionConfiguration.ComponentType: TMyConnectionComponent;
begin
   if(FConnectionComponent = TMyConnectionComponent.Empty)then
      raise Exception.Create('Componente de conexão não informado');

   Result := FConnectionComponent;
end;

function TMyConnetionConfiguration.ConnectionSingleton: Boolean;
begin
   Result := FConnectionSingleton;
end;

function TMyConnetionConfiguration.ConnectionSingletonOff: iMyConnectionConfiguration;
begin
   Result               := Self;
   FConnectionSingleton := False;
end;

function TMyConnetionConfiguration.ConnectionSingletonOn: iMyConnectionConfiguration;
begin
   Result               := Self;
   FConnectionSingleton := True;
end;

function TMyConnetionConfiguration.DesCriptografaSenha(pStr: String): String;
const
 cNormal        = 'kywzxvutsrqponmljihgfedcbaKYWZXVUTSRQPONMLJIHGFEDCBA0987654321';
 cCriptografada = '1234567890ABCDEFGHIJLMNOPQRSTUVXZWYKabcdefghijlmnopqrstuvxzwyk';
var
 i: Integer;
begin
   for i := 1 to Length(pStr) do
   begin
      if(Pos(pStr[i], cNormal) <> 0)then
      begin
         pStr[i] := cCriptografada[Pos(pStr[i], cNormal)];
      end;
   end;

   Result := pStr;
end;

end.
