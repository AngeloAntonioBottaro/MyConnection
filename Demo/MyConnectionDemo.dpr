program MyConnectionDemo;

uses
  Vcl.Forms,
  Demo.View.Main in 'src\Demo.View.Main.pas' {DemoViewMain},
  Demo.View.OtherForm in 'src\Demo.View.OtherForm.pas' {DemoViewOtherForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDemoViewMain, DemoViewMain);
  Application.CreateForm(TDemoViewOtherForm, DemoViewOtherForm);
  Application.Run;
end.
