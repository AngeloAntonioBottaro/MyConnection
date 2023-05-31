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
    FIdentifierField: string;
    FLastIDCreated: Integer;
    procedure OpenClientDataSet;
  protected
    function Open(ASQL: string): IMyConnectionMemoryTable; overload;
    function Open(ASQL, AIdentifierField: string): IMyConnectionMemoryTable; overload;
    function SaveOnDatabase: IMyConnectionMemoryTable; 
    function DataSet: TClientDataset;
    function LastIDCreated: Integer;
  public
    class function New: IMyConnectionMemoryTable;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TMyConnectionMemoryTable.New: IMyConnectionMemoryTable;
begin
   Result := Self.Create;
end;

constructor TMyConnectionMemoryTable.Create;
begin
   FLastIDCreated   := 0;
   FDataSetProvider := TDataSetProvider.Create(nil);
   FClientDataSet   := TClientDataSet.Create(nil);
end;

destructor TMyConnectionMemoryTable.destroy;
begin
   FClientDataSet.Free;
   FDataSetProvider.Free;
   inherited;
end;

function TMyConnectionMemoryTable.LastIDCreated: Integer;
begin
   Result := FLastIDCreated;
end;

function TMyConnectionMemoryTable.DataSet: TClientDataset;
begin
   Result := FClientDataSet;
end;

function TMyConnectionMemoryTable.Open(ASQL: String): IMyConnectionMemoryTable;
begin
   Result := Self.Open(ASQL, '');
end;

function TMyConnectionMemoryTable.Open(ASQL, AIdentifierField: string): IMyConnectionMemoryTable;
begin
   Result := Self;
   FIdentifierField := AIdentifierField;

   FQuery := MyQueryNew;
   FQuery
    .Clear
    .Add(ASQL);

   Self.OpenClientDataSet;
end;

procedure TMyConnectionMemoryTable.OpenClientDataSet;
begin
   FClientDataSet.Aggregates.Clear;
   FClientDataSet.Params.Clear;

   FDataSetProvider.DataSet := FQuery.DataSet;
   FDataSetProvider.Options := [poAllowCommandText];

   FClientDataSet.SetProvider(FDataSetProvider);
   FClientDataSet.Active := True;
end;

function TMyConnectionMemoryTable.SaveOnDatabase: IMyConnectionMemoryTable;
var
  I: Integer;
  LFieldName: String;
begin
   Result := Self;

   FQuery.Close;
   FQuery.Open;

   if(not FIdentifierField.IsEmpty)then
   begin
      FQuery.FieldByName(FIdentifierField).Required := False;
      FQuery.FieldByName(FIdentifierField).AutoGenerateValue := TAutoRefreshFlag.arAutoInc;
   end;

   FClientDataSet.First;
   while(not FClientDataSet.Eof)do
   begin
      FQuery.Append;

      for I := 0 to Pred(FClientDataSet.FieldCount) do
      begin
        LFieldName := UpperCase(FClientDataSet.Fields[I].FieldName);

        if(LFieldName.Equals(UpperCase(FIdentifierField)))then
          Continue;

        if(FQuery.DataSet.FindField(LFieldName) <> nil)then
          FQuery.FieldByName(LFieldName).Value := FClientDataSet.FieldByName(LFieldName).Value;
      end;

      FQuery.Post;
      FClientDataSet.Next;
   end;

   if(not FIdentifierField.IsEmpty)then
     FLastIDCreated := FQuery.FieldByName(FIdentifierField).AsInteger;
end;

end.
