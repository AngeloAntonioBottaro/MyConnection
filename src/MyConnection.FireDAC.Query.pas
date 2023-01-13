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
  TMyFireDACQuery = class(TInterfacedObject, iMyConnectionQuery)
  private
    FConnectionsFiredac: iMyConnectionComponent;
    FQuery: TFDQuery;
  protected
    function Close: iMyConnectionQuery;
    function Clear: iMyConnectionQuery;
    function Add(aValue: String): iMyConnectionQuery;
    function AddParam(aParam: String; Value: Variant): iMyConnectionQuery;
    function Text(aValue: String): iMyConnectionQuery;
    function SQL: TStrings;
    function ExecSQL: iMyConnectionQuery; overload;
    function ExecSQL(const ASQL: String): iMyConnectionQuery; overload;
    function Open: iMyConnectionQuery; overload;
    function Open(const ASQL: String): iMyConnectionQuery; overload;

    function Append: iMyConnectionQuery;
    function Edit: iMyConnectionQuery;
    function Post: iMyConnectionQuery;

    function IsEmpty: Boolean;
    function RowsAffected: Integer;
    function FieldByName(aValue: string): TField;
    function RecordCount: Integer;

    function DataSet: TDataSet;
    function DataSource(aValue: TDataSource): iMyConnectionQuery;
  public
    class function New: iMyConnectionQuery;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TMyFireDACQuery.New: iMyConnectionQuery;
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

function TMyFireDACQuery.Close: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.Close;
end;

function TMyFireDACQuery.Clear: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.SQL.Clear;
end;

function TMyFireDACQuery.Add(aValue: String): iMyConnectionQuery;
begin
   Result := Self;
   FQuery.SQL.Add(aValue);
end;

function TMyFireDACQuery.AddParam(aParam: String; Value: Variant): iMyConnectionQuery;
begin
   Result := Self;
   FQuery.ParamByName(aParam).Value := Value;
end;

function TMyFireDACQuery.Text(aValue: String): iMyConnectionQuery;
begin
   Result          := Self;
   FQuery.SQL.Text := Trim(aValue);
end;

function TMyFireDACQuery.SQL: TStrings;
begin
   Result := FQuery.SQL;
end;

function TMyFireDACQuery.ExecSQL: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.ExecSQL;
end;

function TMyFireDACQuery.ExecSQL(const ASQL: String): iMyConnectionQuery;
begin
   Result := Self;
   FQuery.ExecSQL(ASQL);
end;

function TMyFireDACQuery.Open: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.Open;
end;

function TMyFireDACQuery.Open(const ASQL: String): iMyConnectionQuery;
begin
   Result := Self;
   FQuery.Open(ASQL);
end;

function TMyFireDACQuery.Append: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.Append;
end;

function TMyFireDACQuery.Edit: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.Edit;
end;

function TMyFireDACQuery.Post: iMyConnectionQuery;
begin
   Result := Self;
   FQuery.Post;
end;

function TMyFireDACQuery.IsEmpty: Boolean;
begin
   Result := FQuery.IsEmpty;
end;

function TMyFireDACQuery.RowsAffected: Integer;
begin
   Result := FQuery.RowsAffected;
end;

function TMyFireDACQuery.FieldByName(aValue: string): TField;
begin
   Result := Self.DataSet.FieldByName(aValue);
end;

function TMyFireDACQuery.RecordCount: Integer;
begin
   Result := FQuery.RecordCount;
end;

function TMyFireDACQuery.DataSet: TDataSet;
begin
   Result := FQuery;
end;

function TMyFireDACQuery.DataSource(aValue: TDataSource): iMyConnectionQuery;
begin
   Result         := Self;
   aValue.DataSet := Self.DataSet;
end;

end.
