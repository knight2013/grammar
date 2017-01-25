//������� 24.01.2004
//������ uDBProcedures ��� ������ � �� ADO + BathUpdates (CashUpdates)
//soft_of_AVI (C) 2003
unit uDBProcedures;

interface

  uses DB, ADODB, Windows, SysUtils, Dialogs, Variants, ComObj;

  const
    cModuleName    = 'uDBProcedures';
    cModuleVersion = '1.05';

    cReOpen        = True;
    cNotReOpen     = False;
  var
    //��������� ����������
    cModuleTitle    : string;

    //��������� ��� ������� GetLastKeyConst
    cTableKey       : TDataSource;
    cFieldTableName : Variant;
    cFieldLastKey   : Variant;

    cFieldAddon     : Variant;
    cAddon          : Variant;

    //��������� ��� ��������� ApplyUpdateConst
    cConnection     : TADOConnection;

  //����������� ���� � ��� mm/dd/yyyy � �������� dd.mm.yyyy
  function ADOGetDate(ADate: string; AMode: byte): string;

  //���������� ���������� UID
  //ATableKey       - �������, ������������ � ������ � ���������� UID
  //AFieldTableName - �������� ���� � ������� ������
  //AFieldLastKey   - �������� ���� � UID
  //ATableName      - ������� ��� ������� ��� ���������� ������ UID
  //AFieldAddon     - �������� ��������������� ���� ��� ���������� UID
  //AAddon          - �������� ��������������� ���� ��� ���������� UID
  //Result          - ����� UID ��� ������� ATableName
  function ADOGetLastKey(ATableKey: TDataSource; AFieldTableName, AFieldLastKey, ATableName, AFieldAddon, AAddon: Variant): string;

  //���������� ���������� UID �� ������� ����������� ������
  //ATableName      - ������� ��� ������� ��� ���������� ������ UID
  //Result          - ����� UID ��� ������� ATableName
  function ADOGetLastKeyConst(ATableName: Variant): string;

  //������� ������ ������ �� ���������� BathUpdates (CachedUpdates)
  //��� �� ������������� ���������� ������������ ���������� ������
  //(�� ���� ���������� �������� CursorLocation � clUseClient)
  //� LockType � ltBatchOptimistic
  //AConnection     - ���������� ADO
  //AQuery          - ����������� ������
  //AFieldKey       - �������� ����
  procedure ADOApplyUpdate(AConnection: TADOConnection; AQuery: TADOQuery; AFieldKey: string);

  //������� ������ ������ �� ���������� BathUpdates (CachedUpdates) �� ������� ����������� ������
  //AQuery          - ����������� ������
  //AFieldKey       - �������� ����
  procedure ADOApplyUpdateConst(AQuery: TADOQuery; AFieldKey: string);

  //������� ������ ������ �� ���������� BathUpdates (CachedUpdates) �� ������� ����������� ������
  //������, ��� ������ ���� ��� UID
  //AQuery          - ����������� ������
  //AFieldKey       - �������� ����
  procedure ADOApplyUpdateConstUID(AQuery: TADOQuery);

  //���������� ��������� ������ ��� ������ �������
  //ADataSource          - ����������� ��������� ������
  procedure ADORefreshDataSet(ADataSource: TDataSource; AFieldKey: string);

  //���������� ��������� ������ ��� ������ ������� ������, ��� ������ ���� ��� UID
  //ADataSource          - ����������� ��������� ������
  procedure ADORefreshDataSetUID(ADataSource: TDataSource);

  //
  Procedure ADOCompressDatabase(DatabaseName:String;DestDatabaseName:String='';Password:String='');

  //���������������� ��������� ������ �� ��������
  function LocateOnDefaultMean(ADataSource: TDataSource; AFieldKey, AFieldDisplay, ADefaultValue: string): string;

  //��������� ����������� � �������
  procedure SetParamToQuery(AQuery: TADOQuery; AName: string; AValue: variant; AReOpen: boolean);

  //�������� �� ����� "�������� �����"
  function CheckOnAllMode(AValue, AAllModeValue, AMess: string): boolean;

  //�������� ������ � ����� CacheUpdate
  procedure ADODeleteRecordUID(ADataSource: TDataSource; ATableName: string);

  //������ � runtime
  function ADOQueryRuntime(ASQL: string): TFields;

  //������ � runtime ��� ������ ����������
  function ADOQueryRuntimeConn(ASQL: string; AConnection: TADOConnection): TFields;

  //��������� �����, ������ � ���� � ��
  function SetConnString(ALogin, APassword, APathToDB: WideString):WideString;
implementation

  function ADOGetDate(ADate: string; AMode: byte): string;
  var dtConv: TdateTime;
      iDate, iMonth, iYear: word;
  begin
    case AMode of
      //�� ��� � ��������
      0: begin
           iDate  := StrToInt(ADate[4] + ADate[5]);
           iMonth := StrToInt(ADate[1] + ADate[2]);
           iYear  := StrToInt(ADate[7] + ADate[8] + ADate[9] + ADate[10]);
           dtConv := EncodeDate(iYear, iMonth, iDate);
           Result := FormatDateTime('dd.mm.yyyy', dtConv);
         end;
      1: begin
      //�� �������� � ���
           iDate  := StrToInt(ADate[1] + ADate[2]);
           iMonth := StrToInt(ADate[4] + ADate[5]);
           iYear  := StrToInt(ADate[7] + ADate[8] + ADate[9] + ADate[10]);
           dtConv := StrToDate(ADate);
           Result := FormatDateTime('mm/dd/yyyy', dtConv);
         end;
    end;
  end;

  function ADOGetLastKey(ATableKey: TDataSource; AFieldTableName, AFieldLastKey, ATableName, AFieldAddon, AAddon: Variant): string;
  var iLastKey    : integer;
  begin
    iLastKey := 1;
    if ATableKey.DataSet.Locate(AFieldTableName+';'+AFieldAddon, VarArrayOf([VarToStr(ATableName),VarToStr(AAddon)]), [loPartialKey]) then
      begin
       iLastKey := ATableKey.DataSet.FieldValues[AFieldLastKey];
       ATableKey.DataSet.Edit;
       ATableKey.DataSet.FieldValues[AFieldLastKey] := iLastKey + 1;
       ATableKey.DataSet.Post;
      end
    else
      begin
        MessageBox(0, PChar('�� ������� ������� ' + VarToStr(ATableName) + ' � ������� ��������� UID. '+#13 + '�������� �� ��������� � ������ "���������� ���".'), PChar(cModuleTitle), MB_ICONERROR);
        Result := '';
        Abort;
      end;
   Result := IntToStr(iLastKey);
   end;

  function ADOGetLastKeyConst(ATableName: Variant): string;
  begin
     if (cTableKey = nil) or (cFieldTableName = '') or (cFieldLastKey = '')
       then MessageBox(0, PChar('�� ���������� ��� ���������'), PChar(cModuleTitle), MB_ICONERROR)
       else Result := ADOGetLastKey(cTableKey, cFieldTableName, cFieldLastKey, ATableName, cFieldAddon, cAddon);
  end;

  procedure ADOApplyUpdate(AConnection: TADOConnection; AQuery: TADOQuery; AFieldKey: string);
  var sKey: string;
  begin
    sKey := VarToStr(AQuery.FieldValues[AFieldKey]);

    if (not AConnection.InTransaction)
      then begin
        AConnection.BeginTrans;
        AQuery.UpdateBatch;
        AConnection.CommitTrans;
      end
      else begin
        AQuery.CancelBatch;
        AConnection.RollbackTrans;
      end;
      AQuery.Requery;

    AQuery.Locate(AFieldKey, sKey, []);
  end;

  procedure ADOApplyUpdateConst(AQuery: TADOQuery; AFieldKey: string);
  begin
    ADOApplyUpdate(cConnection, AQuery, AFieldKey);
  end;

  procedure ADOApplyUpdateConstUID(AQuery: TADOQuery);
  begin
    ADOApplyUpdate(cConnection, AQuery, AQuery.Fields[0].DisplayName);
  end;

  procedure ADORefreshDataSet(ADataSource: TDataSource; AFieldKey: string);
  var sKey: string;
  begin
    sKey := VarToStr(ADataSource.DataSet.Fields[0].AsString);
    ADataSource.DataSet.Close;
    ADataSource.DataSet.Open;
    ADataSource.DataSet.Locate(AFieldKey, sKey, []);
  end;

  procedure ADORefreshDataSetUID(ADataSource: TDataSource);
  begin
    ADORefreshDataSet(ADataSource, ADataSource.DataSet.Fields[0].DisplayName);
  end;

Procedure ADOCompressDatabase(DatabaseName:String;DestDatabaseName:String='';Password:String='');
Const
   Provider = 'Provider=Microsoft.Jet.OLEDB.4.0;';
Var
  TempName : Array[0..MAX_PATH] of Char; // ��� ���������� �����
  TempPath : String; // ���� �� ����
  Name : String;
  Src,Dest : WideString;
  V : Variant;
begin
   try
       Src := Provider + 'Data Source=' + DatabaseName;
       if DestDatabaseName<>'' then
           Name:=DestDatabaseName
       else begin
           // �������� ���� �� ������� - ���������� ��������� ����
           // �������� ���� ��� ���������� �����
           TempPath:=ExtractFilePath(DatabaseName);
           if TempPath='' Then TempPath:=GetCurrentDir;
           //�������� ��� ���������� �����
           GetTempFileName(PChar(TempPath),'mdb',0,TempName);
           Name:=StrPas(TempName);
       end;
       DeleteFile(PChar(Name));// ����� ����� �� ������ ������������ :))
       Dest := Provider + 'Data Source=' + Name;
       if Password<>'' then begin
           Src := Src + ';Jet OLEDB:Database Password=' + Password;
           Dest := Dest + ';Jet OLEDB:Database Password=' + Password;
       end;

       V:=CreateOleObject('jro.JetEngine');
       try
           V.CompactDatabase(Src,Dest);// �������
       finally
           V:=0;
       end;
       if DestDatabaseName='' then begin // �.�. �������� ���� �� �������
           DeleteFile(PChar(DatabaseName)); //�� ������� �� ����������� ����
           RenameFile(Name,DatabaseName); // � ��������������� ����������� ����
       end;
   except
    // ������ ��������� �� �������������� ��������
    on E: Exception do ShowMessage(e.message);
   end;
end;

function LocateOnDefaultMean(ADataSource: TDataSource; AFieldKey, AFieldDisplay, ADefaultValue: string): string;
begin
  if ADataSource.DataSet.Locate(AFieldKey, ADefaultValue, [])
   then Result := ADataSource.DataSet.FieldValues [ AFieldDisplay ]
   else Result := '<���>';
end;

procedure SetParamToQuery(AQuery: TADOQuery; AName: string; AValue: variant; AReOpen: boolean);
var i: integer;
begin
  AQuery.Close;
  for i := 0 to AQuery.Parameters.Count - 1 do
      if AQuery.Parameters.Items[i].Name = AName then
         AQuery.Parameters.Items[i].Value := AValue;
  if AReOpen then AQuery.Open;
end;

function CheckOnAllMode(AValue, AAllModeValue, AMess: string): boolean;
begin
  Result := False;
  if AValue = AAllModeValue then
   begin
     ShowMessage(AMess);
     Result := True;
   end;
end;

procedure ADODeleteRecordUID(ADataSource: TDataSource; ATableName: string);
begin
  with TADOQuery.Create(nil) do
   begin
     Connection := cConnection;
     SQL.Add('delete from ' + ATableName + ' where ' + ADataSource.DataSet.Fields[0].FieldName + ' = ' + ADataSource.DataSet.Fields[0].AsString );
     ExecSQL;
     Free;
   end;
 ADORefreshDataSetUID(ADataSource);
end;

function ADOQueryRuntimeConn(ASQL: string; AConnection: TADOConnection): TFields;
begin
  with TADOQuery.Create(nil) do
   begin
     Connection := AConnection;
     SQL.Add(ASQL);
     Open;
     Result := Fields;
     Free;
   end;
end;

function ADOQueryRuntime(ASQL: string): TFields;
begin
  with TADOQuery.Create(nil) do
   begin
     Connection := cConnection;
     SQL.Add(ASQL);
     Open;
     Result := Fields;
     Free;
   end;
end;

function SetConnString(ALogin, APassword, APathToDB: WideString):WideString;
var
  wsTemp : WideString;
begin
  wsTemp := '';
  wsTemp := wsTemp + 'Provider=Microsoft.Jet.OLEDB.4.0;';

  if ALogin <> ''
    then wsTemp := wsTemp + 'User ID="' + ALogin + '";'
    else wsTemp := wsTemp + 'User ID="Admin";';

  if APathToDB <> ''
    then wsTemp := wsTemp + 'Data Source="' + APathToDB + '";'
    else wsTemp := wsTemp + 'Data Source="DB\ProgCourse.mdb";';

  wsTemp := wsTemp + 'Mode=Share Deny None;';
  wsTemp := wsTemp + 'Extended Properties="";';
  wsTemp := wsTemp + 'Jet OLEDB:System database="";';
  wsTemp := wsTemp + 'Jet OLEDB:Registry Path="";';

  if APassword <> ''
    then wsTemp := wsTemp + 'Jet OLEDB:Database Password="' + APassword + '";'
    else wsTemp := wsTemp + 'Jet OLEDB:Database Password="";';

  wsTemp := wsTemp + 'Jet OLEDB:Engine Type=5;';
  wsTemp := wsTemp + 'Jet OLEDB:Database Locking Mode=1;';
  wsTemp := wsTemp + 'Jet OLEDB:Global Partial Bulk Ops=2;';
  wsTemp := wsTemp + 'Jet OLEDB:Global Bulk Transactions=1;';
  wsTemp := wsTemp + 'Jet OLEDB:New Database Password="";';
  wsTemp := wsTemp + 'Jet OLEDB:Create System Database=False;';
  wsTemp := wsTemp + 'Jet OLEDB:Encrypt Database=True;';
  wsTemp := wsTemp + 'Jet OLEDB:Don'+#39+'t Copy Locale on Compact=False;';
  wsTemp := wsTemp + 'Jet OLEDB:Compact Without Replica Repair=False;';
  wsTemp := wsTemp + 'Jet OLEDB:SFP=False';
  Result := wsTemp;
end;

begin
  cModuleTitle := '������ ' + cModuleName + ' ' + cModuleVersion;
end.

