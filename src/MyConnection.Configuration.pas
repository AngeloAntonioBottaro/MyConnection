unit MyConnection.Configuration;

interface

uses
  System.SysUtils,
  MyConnection.Interfaces,
  MyConnection.Types;

type
  TMyConnetionConfiguration = class(TInterfacedObject, IMyConnectionConfiguration)
  private
    FHost: string;
    FUserName: string;
    FDatabase: string;
    FPort: string;
    FPassword: string;
    FDriverID: string;
    FConnectionComponent: TMyConnectionComponent;
    FConnectionSingleton: Boolean;
  protected
    function ClearConfiguration: IMyConnectionConfiguration;

    function DriverFirebird: IMyConnectionConfiguration;
    function DriverMySQL: IMyConnectionConfiguration;
    function DriverID: string;
    function Host(AValue: string): IMyConnectionConfiguration; overload;
    function Host: string; overload;
    function UserName(AValue: string): IMyConnectionConfiguration; overload;
    function UserName: string; overload;
    function Database(AValue: string): IMyConnectionConfiguration; overload;
    function Database: string; overload;
    function Port(AValue: string): IMyConnectionConfiguration; overload;
    function Port(AValue: Integer): IMyConnectionConfiguration; overload;
    function Port: string; overload;
    function Password(AValue: string): IMyConnectionConfiguration; overload;
    function Password: string; overload;
    function ComponentTypeFireDac: IMyConnectionConfiguration;
    function ComponentType: TMyConnectionComponent; overload;
    function ConnectionSingletonOn: IMyConnectionConfiguration;
    function ConnectionSingletonOff: IMyConnectionConfiguration;
    function ConnectionSingleton: Boolean;
  public
    class function New: IMyConnectionConfiguration;
    constructor Create;
  end;

var
  FConfiguration: IMyConnectionConfiguration;

implementation

class function TMyConnetionConfiguration.New: IMyConnectionConfiguration;
begin
   if(not Assigned(FConfiguration))then
      FConfiguration := Self.Create;

   Result := FConfiguration;
end;

constructor TMyConnetionConfiguration.Create;
begin
   Self.ClearConfiguration;
end;

function TMyConnetionConfiguration.ClearConfiguration: IMyConnectionConfiguration;
begin
   Result := Self;

   FHost     := EmptyStr;
   FDatabase := EmptyStr;
   FPort     := EmptyStr;
   FPassword := EmptyStr;

   FConnectionComponent := TMyConnectionComponent.Empty;
   FConnectionSingleton := True;
end;

function TMyConnetionConfiguration.DriverFirebird: IMyConnectionConfiguration;
begin
   Result    := Self;
   FDriverID := 'FB';
end;

function TMyConnetionConfiguration.DriverMySQL: IMyConnectionConfiguration;
begin
   Result    := Self;
   FDriverID := 'MySQL';
end;

function TMyConnetionConfiguration.DriverID: string;
begin
   Result := FDriverID;
end;

function TMyConnetionConfiguration.Host(AValue: string): IMyConnectionConfiguration;
begin
   Result := Self;
   FHost  := AValue.Trim;
end;

function TMyConnetionConfiguration.Host: string;
begin
   Result := FHost;
end;

function TMyConnetionConfiguration.UserName(AValue: string): IMyConnectionConfiguration;
begin
   Result    := Self;
   FUserName := AValue.Trim;
end;

function TMyConnetionConfiguration.UserName: string;
begin
   Result := FUserName;
end;

function TMyConnetionConfiguration.Database(AValue: string): IMyConnectionConfiguration;
begin
   Result    := Self;
   FDatabase := AValue.Trim;
end;

function TMyConnetionConfiguration.Database: string;
begin
   Result := FDatabase;
end;

function TMyConnetionConfiguration.Port(AValue: string): IMyConnectionConfiguration;
begin
   Result := Self;
   FPort  := AValue.Trim;
end;

function TMyConnetionConfiguration.Port(AValue: Integer): IMyConnectionConfiguration;
begin
   Result := Self;
   Port(IntToStr(AValue));
end;

function TMyConnetionConfiguration.Port: string;
begin
   Result := FPort;
end;

function TMyConnetionConfiguration.Password(AValue: string): IMyConnectionConfiguration;
begin
   Result    := Self;
   FPassword := AValue.Trim;
end;

function TMyConnetionConfiguration.Password: string;
begin
   Result := FPassword;
end;

function TMyConnetionConfiguration.ComponentTypeFireDac: IMyConnectionConfiguration;
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

function TMyConnetionConfiguration.ConnectionSingletonOff: IMyConnectionConfiguration;
begin
   Result               := Self;
   FConnectionSingleton := False;
end;

function TMyConnetionConfiguration.ConnectionSingletonOn: IMyConnectionConfiguration;
begin
   Result               := Self;
   FConnectionSingleton := True;
end;

end.
