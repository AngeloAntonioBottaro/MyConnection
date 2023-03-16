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
  {$ifndef CONSOLE}
  FireDAC.VCLUI.Wait,
  {$EndIf}
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Comp.UI,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  Data.DB,
  MyConnection.Interfaces,
  MyConnection.Configuration;

type
  TMyFireDACConnection = class(TInterfacedObject, IMyConnectionComponent)
  private
    FConnection: TFDConnection;
    function TestFieldsComponentConnection: IMyConnectionComponent;
  protected
    function Component: TComponent;
    function TestConnectionOnly: Boolean;
    function TestConnection: Boolean;
    function Open: IMyConnectionComponent;
    function Close: IMyConnectionComponent;
    function LoadConnectionConfig: IMyConnectionComponent;
  public
    class function New: IMyConnectionComponent;
    constructor Create;
    destructor Destroy; override;
  end;

var
  FConnectionFireDac: IMyConnectionComponent;

implementation

class function TMyFireDACConnection.New: IMyConnectionComponent;
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
 LOld: Boolean;
begin
   Self.TestFieldsComponentConnection;
   try
     LOld                  := FConnection.Connected;
     FConnection.Connected := True;
     Result                := FConnection.Connected;

     if(FConnection.Connected <> LOld)then
       FConnection.Connected := LOld;

   except on E: exception do
     raise Exception.Create('Conexão não pode ser realizada: ' + E.Message);
   end;
end;

function TMyFireDACConnection.Open: IMyConnectionComponent;
begin
   Result := Self;
   Self.TestFieldsComponentConnection;
   FConnection.Connected := True;
end;

function TMyFireDACConnection.Close: IMyConnectionComponent;
begin
   Result := Self;
   FConnection.Connected := False;
end;

function TMyFireDACConnection.LoadConnectionConfig: IMyConnectionComponent;
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

function TMyFireDACConnection.TestFieldsComponentConnection: IMyConnectionComponent;
var
 LTemp: string;
begin
   Result := Self;
   LTemp  := EmptyStr;

   if(Trim(TMyConnetionConfiguration.New.DriverID) = EmptyStr)then
     LTemp := LTemp + 'DriverID. ';

   if(Trim(TMyConnetionConfiguration.New.Database) = EmptyStr)then
     LTemp := LTemp + 'Host. ';

   if(Trim(FConnection.Params.UserName) = EmptyStr)then
     LTemp := LTemp + 'Usuário. ';

   if(Trim(FConnection.Params.Password) = EmptyStr)then
     LTemp := LTemp + 'Senha. ';

   if(Trim(FConnection.Params.Database) = EmptyStr)then
     LTemp := LTemp + 'Nome banco.';

   if(LTemp <> EmptyStr)then
     raise Exception.Create('Para realizar a conexão com o banco de dados '+
                            'os seguintes dados devem ser preenchidos: ' + sLineBreak +
                            LTemp.Trim);
end;

end.
