unit MyConnection.Interfaces;

interface

uses
  Data.DB,
  System.Classes,
  MyConnection.Types;

type
  IMyConnectionQuery = interface
   ['{48136EAF-7FCB-407E-B97A-51648867D6B5}']
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

   function DataSet: TDataSet;
   function DataSource(AValue: TDataSource): IMyConnectionQuery;
   function ExceptionZeroRecordsUpdated: Boolean;
  end;

  IMyConnectionComponent = interface
   ['{27BA6E7E-3F54-49BF-AF82-DC6C2473E71B}']
   function Component: TComponent;
   function TestConnectionOnly: Boolean;
   function TestConnection: Boolean;
   function Open: IMyConnectionComponent;
   function Close: IMyConnectionComponent;
   function LoadConnectionConfig: IMyConnectionComponent;
  end;

  IMyConnectionConfiguration = interface
   ['{4214A983-90C0-49F2-BD7B-B7D5F43FD0F0}']
   function ClearConfiguration: IMyConnectionConfiguration;

   function DriverFirebird: IMyConnectionConfiguration;
   function DriverMySQL: IMyConnectionConfiguration;
   function DriverID: string;
   function Host(AValue: string): IMyConnectionConfiguration; overload;
   function Host: string; overload;
   function UserName(AValue: string): IMyConnectionConfiguration; overload;
   function UserName: string; overload;
   function Database(AValue: string): IMyConnectionConfiguration; overload;
   function Database: string; overload;
   function Port(AValue: string): IMyConnectionConfiguration; overload;
   function Port(AValue: Integer): IMyConnectionConfiguration; overload;
   function Port: string; overload;
   function Password(AValue: string): IMyConnectionConfiguration; overload;
   function Password: string; overload;
   function ComponentTypeFireDac: IMyConnectionConfiguration;
   function ComponentType: TMyConnectionComponent; overload;
   function ConnectionSingletonOn: IMyConnectionConfiguration;
   function ConnectionSingletonOff: IMyConnectionConfiguration;
   function ConnectionSingleton: Boolean;
  end;

  IMyConnection = interface
   ['{015F7727-6871-4830-8B13-9136A0F04DB9}']
   function Configuration: IMyConnectionConfiguration;
   function Connection: IMyConnectionComponent;
   function Query: IMyConnectionQuery;
  end;

implementation

end.
