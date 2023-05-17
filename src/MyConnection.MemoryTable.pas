unit MyConnection.MemoryTable;

interface

uses
  System.SysUtils,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.Provider,
  MyConnection,
  MyConnection.Interfaces;

type
  TMyConnectionMemoryTable = class(TInterfacedObject, IMyConnectionMemoryTable)
  private
    FQuery: IMyQuery;
    FClientDataSet: TClientDataSet;
    FDataSetProvider: TDataSetProvider;
    procedure PreencherClientDataSet;
  public
    class function New: IMyConnectionMemoryTable;
    constructor Create;
    destructor Destroy; override;
    function Consultar(ASQL: string): IMyConnectionMemoryTable;
    function Incluir(ACampoIdentificador: string): IMyConnectionMemoryTable;
    function DataSet: TClientDataset;
  end;

implementation

class function TMyConnectionMemoryTable.New: IMyConnectionMemoryTable;
begin
   Result := Self.Create;
end;

constructor TMyConnectionMemoryTable.Create;
begin
   FDataSetProvider := TDataSetProvider.Create(nil);
   FClientDataSet   := TClientDataSet.Create(nil);
end;

destructor TMyConnectionMemoryTable.destroy;
begin
   FClientDataSet.Free;
   FDataSetProvider.Free;
   inherited;
end;

function TMyConnectionMemoryTable.DataSet: TClientDataset;
begin
   if(not Assigned(FClientDataSet))then
     Exit(nil);

   Result := FClientDataSet;
end;

function TMyConnectionMemoryTable.Consultar(ASQL: String): IMyConnectionMemoryTable;
begin
   Result := Self;
   FQuery := MyQueryNew;
   FQuery
    .Clear
    .Add(ASQL);

   Self.PreencherClientDataSet;
end;

procedure TMyConnectionMemoryTable.PreencherClientDataSet;
begin
   FClientDataSet.Aggregates.Clear;
   FClientDataSet.Params.Clear;

   FDataSetProvider.DataSet := FQuery.DataSet;
   FDataSetProvider.Options := [poAllowCommandText];

   FClientDataSet.SetProvider(FDataSetProvider);
   FClientDataSet.Active := True;
end;

function TMyConnectionMemoryTable.Incluir(ACampoIdentificador: string): IMyConnectionMemoryTable;
var
  I: Integer;
  LNomeCampo: String;
begin
   Result := Self;

   FQuery.Close;
   FQuery.Open;

   FClientDataSet.First;
   while(not FClientDataSet.Eof)do
   begin
      FQuery.Append;

      for I := 0 to Pred(FClientDataSet.FieldCount) do
      begin
        LNomeCampo := UpperCase(FClientDataSet.Fields[I].FieldName);

        if(LNomeCampo.Equals(UpperCase(ACampoIdentificador)))then
          Continue;

        if(FQuery.DataSet.FindField(LNomeCampo) <> nil)then
          FQuery.FieldByName(LNomeCampo).Value := FClientDataSet.FieldByName(LNomeCampo).Value;
      end;

      FQuery.Post;
      FClientDataSet.Next;
   end;
end;

end.
