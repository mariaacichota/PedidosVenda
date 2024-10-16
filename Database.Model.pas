unit Database.Model;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.DApt, Vcl.Dialogs, FireDAC.Stan.Error,
  IniFiles, SysUtils;

type
  TDatabase = class
  private
    class var FConnection: TFDConnection;
  public
    class function GetConnection: TFDConnection;
  end;

implementation

class function TDatabase.GetConnection: TFDConnection;
var
  IniFile: TIniFile;
  DBHost, DBName, DBUser, DBPass: String;
  DBPort: Integer;
begin
  if not Assigned(FConnection) then
  begin
    FConnection := TFDConnection.Create(nil);
    IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config\config.ini');
    try
      DBHost := IniFile.ReadString('Database', 'Server', 'localhost');
      DBName := IniFile.ReadString('Database', 'Database', 'db_pedido_venda');
      DBUser := IniFile.ReadString('Database', 'Username', 'root');
      DBPass := IniFile.ReadString('Database', 'Password', '');
      DBPort := IniFile.ReadInteger('Database', 'Port', 3306);

      FConnection.Params.DriverID := 'MySQL';
      FConnection.Params.Database := DBName;
      FConnection.Params.UserName := DBUser;
      FConnection.Params.Password := DBPass;
      FConnection.Params.Values['Server'] := DBHost;
      FConnection.Params.Values['Port'] := IntToStr(DBPort);

      FConnection.LoginPrompt := False;
      try
        FConnection.Connected := True;
      except
        on E: EFDDBEngineException do
          ShowMessage('Erro de banco de dados: ' + E.Message);
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
      end;
    finally
      IniFile.Free;
    end;
  end;
  Result := FConnection;
end;

end.

