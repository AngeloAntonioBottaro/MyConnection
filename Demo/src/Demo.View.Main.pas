unit Demo.View.Main;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  MyConnection,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Demo.View.OtherForm;

type
  TDemoViewMain = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    DS: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FQuery: iMyQuery;
  public
  end;

var
  DemoViewMain: TDemoViewMain;

implementation

{$R *.dfm}


procedure TDemoViewMain.Button1Click(Sender: TObject);
begin
   TMyConnection.New
    .Configuration
     .ClearConfiguration
      .DriverFirebird
      .Host('127.0.0.1')
      .UserName('sysdba')
      .Database('C:\AABSoft\ERP\Database\DATABASE.FDB')
      .Port('3050')
      .Password('masterkey')
      .ComponentTypeFireDac;

   FQuery := TMyConnection.New.Query.DataSource(DS);
end;

procedure TDemoViewMain.Button2Click(Sender: TObject);
begin
   DemoViewOtherForm.ShowModal;
end;

procedure TDemoViewMain.Button4Click(Sender: TObject);
begin
   FQuery
    .Clear
    .Text('select * from produtos')
    .Open;
end;

procedure TDemoViewMain.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := True;
end;

end.
