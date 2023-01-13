unit MyConnection;

interface

uses
  MyConnection.Interfaces,
  MyConnection.Types,
  MyConnection.FireDAC.ComponentConnection;

type
  iMyConnection = MyConnection.Interfaces.iMyConnection;
  iMyQuery = MyConnection.Interfaces.iMyConnectionQuery;

  TMyConnection = class(TInterfacedObject, iMyConnection)
  private
    FConfiguration: iMyConnectionConfiguration;
  protected
    function Configuration: iMyConnectionConfiguration;
    function Connection: iMyConnectionComponent;
    function Query: iMyConnectionQuery;
  public
    class function New: iMyConnection;
  end;

function MyConn: iMyConnection;
function MyConnNew: iMyConnection;
function MyQuery: iMyConnectionQuery;
function MyQueryNew: iMyConnectionQuery;

var
  FConnection: iMyConnection;
  FQuery: iMyConnectionQuery;

implementation

uses
  MyConnection.Configuration,
  MyConnection.FireDAC.Query;

class function TMyConnection.New: iMyConnection;
begin
   Result := Self.Create;
end;

function TMyConnection.Configuration: iMyConnectionConfiguration;
begin
   if(not Assigned(FConfiguration))then
      FConfiguration := TMyConnetionConfiguration.New;

   Result := FConfiguration;
end;

function TMyConnection.Connection: iMyConnectionComponent;
begin
   case(Configuration.ComponentType)of
     TMyConnectionComponent.Firedac: Result := TMyFireDACConnection.New;
   end;
end;

function TMyConnection.Query: iMyConnectionQuery;
begin
   case(Configuration.ComponentType)of
     TMyConnectionComponent.Firedac: FQuery := TMyFireDACQuery.New;
   end;

   Result := FQuery;
end;

function MyConnNew: iMyConnection;
begin
   FConnection := TMyConnection.New;
end;

function MyConn: iMyConnection;
begin
   if(not Assigned(FConnection))then
     MyConnNew;

   Result := FConnection;
end;

function MyQueryNew: iMyConnectionQuery;
begin
   FQuery := MyConn.Query;

   Result := FQuery;
end;

function MyQuery: iMyConnectionQuery;
begin
   if(not Assigned(FQuery))then
     MyQueryNew;

   Result := FQuery;
end;

{
   TMyConnection.New
    .Configuration
     .DriverID('MySQL')
     .Host('localhost')
     .UserName('root')
     .Database('solusys_teste')
     .Password('YCFYCL8kr3@')
     .ComponentTypeFireDac;

    MyConn
    .Query
     .DataSource(DataSource1)
     .Close
     .Add('select * from parametros')
     .Open;
}

end.
