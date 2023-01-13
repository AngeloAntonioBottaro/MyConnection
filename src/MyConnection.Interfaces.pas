unit MyConnection.Interfaces;

interface

uses
  Data.DB,
  System.Classes,
  MyConnection.Types;

type
  iMyConnectionQuery = interface
   ['{48136EAF-7FCB-407E-B97A-51648867D6B5}']
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
  end;

  iMyConnectionComponent = interface
   ['{27BA6E7E-3F54-49BF-AF82-DC6C2473E71B}']
   function Component: TComponent;
   function TestConnectionOnly: Boolean;
   function TestConnection: Boolean;
   function Open: iMyConnectionComponent;
   function Close: iMyConnectionComponent;
   function LoadConnectionConfig: iMyConnectionComponent;
  end;

  iMyConnectionConfiguration = interface
   ['{4214A983-90C0-49F2-BD7B-B7D5F43FD0F0}']
   function ClearConfiguration: iMyConnectionConfiguration;

   function DriverID(aValue: string): iMyConnectionConfiguration; overload;
   function DriverID: string; overload;
   function Host(aValue: string): iMyConnectionConfiguration; overload;
   function Host: string; overload;
   function UserName(aValue: string): iMyConnectionConfiguration; overload;
   function UserName: string; overload;
   function Database(aValue: string): iMyConnectionConfiguration; overload;
   function Database: string; overload;
   function Port(aValue: string): iMyConnectionConfiguration; overload;
   function Port(aValue: Integer): iMyConnectionConfiguration; overload;
   function Port: string; overload;
   function Password(aValue: string): iMyConnectionConfiguration; overload;
   function Password: string; overload;
   function ComponentTypeFireDac: iMyConnectionConfiguration;
   function ComponentType: TMyConnectionComponent; overload;
   function ConnectionSingletonOn: iMyConnectionConfiguration;
   function ConnectionSingletonOff: iMyConnectionConfiguration;
   function ConnectionSingleton: Boolean;
  end;

  iMyConnection = interface
   ['{015F7727-6871-4830-8B13-9136A0F04DB9}']
   function Configuration: iMyConnectionConfiguration;
   function Connection: iMyConnectionComponent;
   function Query: iMyConnectionQuery;
  end;

implementation

end.
