unit MyConnection.FireDAC.Query;

interface

uses
  Data.DB,
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  MyConnection.Interfaces,
  MyConnection.FireDAC.ComponentConnection;

type
  TMyFireDACQuery = class(TInterfacedObject, IMyConnectionQuery)
  private
    FConnectionsFiredac: IMyConnectionComponent;
    FQuery: TFDQuery;
    FExceptionZeroRecordsUpdated: Boolean;
  protected
    function Close: IMyConnectionQuery;
    function Clear: IMyConnectionQuery;
    function Add(AValue: String): IMyConnectionQuery;
    function AddParam(AParam: String; Value: Variant): IMyConnectionQuery;
    function Text(AValue: String): IMyConnectionQuery;
    function SQL: TStrings;
    function ExecSQL: IMyConnectionQuery; overload;
    function ExecSQL(const ASQL: String): IMyConnectionQuery; overload;
    function Open: IMyConnectionQuery; overload;
    function Open(const ASQL: String): IMyConnectionQuery; overload;

    function Append: IMyConnectionQuery;
    function Edit: IMyConnectionQuery;
    function Post: IMyConnectionQuery;

    function IsEmpty: Boolean;
    function RowsAffected: Integer;
    function FieldByName(AValue: string): TField;
    function RecordCount: Integer;

    function IndexFieldNames(AValue: string): IMyConnectionQuery; overload;
    function IndexFieldNames: string; overload;

    function DataSet: TDataSet;
    function DataSource(AValue: TDataSource): IMyConnectionQuery;
    function ExceptionZeroRecordsUpdated: Boolean;
  public
    class function New: IMyConnectionQuery;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TMyFireDACQuery.New: IMyConnectionQuery;
begin
   Result := Self.Create;
end;

constructor TMyFireDACQuery.Create;
begin
   FConnectionsFiredac := TMyFireDACConnection.New;

   FQuery                   := TFDQuery.Create(nil);
   FQuery.FetchOptions.Mode := fmAll;
   FQuery.Connection        := TFDConnection(FConnectionsFiredac.Component);

   FQuery.Close;
   FQuery.SQL.Clear;
end;

destructor TMyFireDACQuery.Destroy;
begin
   FreeAndNil(FQuery);
   inherited;
end;

function TMyFireDACQuery.Close: IMyConnectionQuery;
begin
   Result := Self;
   FQuery.Close;
end;

function TMyFireDACQuery.Clear: IMyConnectionQuery;
begin
   Result := Self;
   FQuery.SQL.Clear;
end;

function TMyFireDACQuery.Add(AValue: String): IMyConnectionQuery;
begin
   Result := Self;
   FQuery.SQL.Add(AValue);
end;

function TMyFireDACQuery.AddParam(AParam: String; Value: Variant): IMyConnectionQuery;
begin
   Result := Self;
   FQuery.ParamByName(AParam).Value := Value;
end;

function TMyFireDACQuery.Text(AValue: String): IMyConnectionQuery;
begin
   Result          := Self;
   FQuery.SQL.Text := Trim(AValue);
end;

function TMyFireDACQuery.SQL: TStrings;
begin
   Result := FQuery.SQL;
end;

function TMyFireDACQuery.ExecSQL: IMyConnectionQuery;
begin
   Result := Self;
   FExceptionZeroRecordsUpdated := False;
   try
     FQuery.ExecSQL;
   except on E: Exception do
   begin
      FExceptionZeroRecordsUpdated := pos('0 record(s) updated.', E.Message) > 0;
      raise;
   end
   end;
end;

function TMyFireDACQuery.ExceptionZeroRecordsUpdated: Boolean;
begin
   Result := FExceptionZeroRecordsUpdated;
end;

function TMyFireDACQuery.ExecSQL(const ASQL: String): IMyConnectionQuery;
begin
   Result := Self;
   FExceptionZeroRecordsUpdated := False;
   try
     FQuery.ExecSQL(ASQL);
   except on E: Exception do
   begin
      FExceptionZeroRecordsUpdated := pos('0 record(s) updated.', E.Message) > 0;
      raise;
   end
   end;
end;

function TMyFireDACQuery.Open: IMyConnectionQuery;
begin
   Result := Self;
   FQuery.Open;
end;

function TMyFireDACQuery.Open(const ASQL: String): IMyConnectionQuery;
begin
   Result := Self;
   FQuery.Open(ASQL);
end;

function TMyFireDACQuery.Append: IMyConnectionQuery;
begin
   Result := Self;
   FQuery.Append;
end;

function TMyFireDACQuery.Edit: IMyConnectionQuery;
begin
   Result := Self;
   FQuery.Edit;
end;

function TMyFireDACQuery.Post: IMyConnectionQuery;
begin
   Result := Self;
   FQuery.Post;
end;

function TMyFireDACQuery.IndexFieldNames(AValue: string): IMyConnectionQuery;
begin
   Result := Self;
   if(FQuery.IndexFieldNames = AValue)then
     FQuery.IndexFieldNames := AValue + ':D'
   else
     FQuery.IndexFieldNames := AValue;
end;

function TMyFireDACQuery.IndexFieldNames: string;
begin
   Result := FQuery.IndexFieldNames;
end;

function TMyFireDACQuery.IsEmpty: Boolean;
begin
   Result := FQuery.IsEmpty;
end;

function TMyFireDACQuery.RowsAffected: Integer;
begin
   Result := FQuery.RowsAffected;
end;

function TMyFireDACQuery.FieldByName(AValue: string): TField;
begin
   Result := FQuery.FieldByName(AValue);
end;

function TMyFireDACQuery.RecordCount: Integer;
begin
   Result := FQuery.RecordCount;
end;

function TMyFireDACQuery.DataSet: TDataSet;
begin
   Result := FQuery;
end;

function TMyFireDACQuery.DataSource(AValue: TDataSource): IMyConnectionQuery;
begin
   Result         := Self;
   AValue.DataSet := Self.DataSet;
end;

end.
