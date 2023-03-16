unit MyConnection;

interface

uses
  MyConnection.Interfaces,
  MyConnection.Types,
  MyConnection.FireDAC.ComponentConnection;

type
  IMyConnection = MyConnection.Interfaces.IMyConnection;
  IMyQuery = MyConnection.Interfaces.IMyConnectionQuery;

  TMyConnection = class(TInterfacedObject, IMyConnection)
  private
    FConfiguration: IMyConnectionConfiguration;
  protected
    function Configuration: IMyConnectionConfiguration;
    function Connection: IMyConnectionComponent;
    function Query: IMyConnectionQuery;
  public
    class function New: IMyConnection;
  end;

function MyConn: IMyConnection;
function MyConnNew: IMyConnection;
function MyQuery: IMyConnectionQuery;
function MyQueryNew: IMyConnectionQuery;

var
  FConnection: IMyConnection;
  FQuery: IMyConnectionQuery;

implementation

uses
  MyConnection.Configuration,
  MyConnection.FireDAC.Query;

class function TMyConnection.New: IMyConnection;
begin
   Result := Self.Create;
end;

function TMyConnection.Configuration: IMyConnectionConfiguration;
begin
   if(not Assigned(FConfiguration))then
      FConfiguration := TMyConnetionConfiguration.New;

   Result := FConfiguration;
end;

function TMyConnection.Connection: IMyConnectionComponent;
begin
   case(Configuration.ComponentType)of
     TMyConnectionComponent.Firedac: Result := TMyFireDACConnection.New;
   end;
end;

function TMyConnection.Query: IMyConnectionQuery;
begin
   case(Configuration.ComponentType)of
     TMyConnectionComponent.Firedac: FQuery := TMyFireDACQuery.New;
   end;

   Result := FQuery;
end;

function MyConnNew: IMyConnection;
begin
   FConnection := TMyConnection.New;
end;

function MyConn: IMyConnection;
begin
   if(not Assigned(FConnection))then
     MyConnNew;

   Result := FConnection;
end;

function MyQueryNew: IMyConnectionQuery;
begin
   FQuery := MyConn.Query;

   Result := FQuery;
end;

function MyQuery: IMyConnectionQuery;
begin
   if(not Assigned(FQuery))then
     MyQueryNew;

   Result := FQuery;
end;

{
   MyConn
    .Configuration
     .ClearConfiguration
     .DriverID('FB')
     .Host('localhost')
     .UserName('sysdba')
     .Database('database.fdb')
     .Password('masterkey')
     .Port('3050')
     .ComponentTypeFireDac
     .ConnectionSingletonOn;

    MyConn.Connection.TestConnection;

    MyQueryNew
     .DataSource(DataSource1)
     .Close
     .Add('select * from parametros')
     .Open;
}

end.
