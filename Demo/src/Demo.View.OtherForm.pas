unit Demo.View.OtherForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  MyConnection;

type
  TDemoViewOtherForm = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button4: TButton;
    DS2: TDataSource;
    Button1: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FQuery: iMyQuery;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DemoViewOtherForm: TDemoViewOtherForm;

implementation

{$R *.dfm}

procedure TDemoViewOtherForm.Button1Click(Sender: TObject);
begin
   MyQueryNew
    .DataSource(DS2)
    .Add('select * from produtos')
    .Open;
end;

procedure TDemoViewOtherForm.Button4Click(Sender: TObject);
begin
   FQuery := TMyConnection.New.Query.DataSource(DS2);

   FQuery
    .Add('select * from clientes')
    .Open;
end;

end.
