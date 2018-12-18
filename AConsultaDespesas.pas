unit AConsultaDespesas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Localizacao, Db, DBTables, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Mask, BotaoCadastro;

type
  TFConsultaDespesas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    GConsulta: TGridIndice;
    DESPESAS: TQuery;
    DATADESPESAS: TDataSource;
    PanelColor3: TPanelColor;
    DESPESASI_COD_DES: TIntegerField;
    DESPESASI_EMP_FIL: TIntegerField;
    DESPESASC_NOM_DES: TStringField;
    DESPESASC_ATI_DES: TStringField;
    DESPESASI_MES_GER: TIntegerField;
    DESPESASI_MES_MED: TIntegerField;
    DESPESASC_CLA_PLA: TStringField;
    DESPESASI_COD_EMP: TIntegerField;
    DESPESASC_NOM_PLA: TStringField;
    LPlanoGeral: TLabel;
    BPlano: TSpeedButton;
    EPlanoGeral: TEditColor;
    Label1: TLabel;
    BDesativa: TBitBtn;
    BAtiva: TBitBtn;
    AUX: TQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField3: TStringField;
    IntegerField5: TIntegerField;
    StringField4: TStringField;
    BBAjuda: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EPlanoGeralExit(Sender: TObject);
    procedure EPlanoGeralChange(Sender: TObject);
    procedure BDesativaClick(Sender: TObject);
    procedure BAtivaClick(Sender: TObject);
    procedure DESPESASAfterScroll(DataSet: TDataSet);
    procedure EPlanoGeralKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
  private
    VprOrdem: string;
    procedure PosicionaDespesas;
  public
  end;

var
  FConsultaDespesas: TFConsultaDespesas;

implementation

{$R *.DFM}

uses
  constantes, fundata, funstring, funsql, APrincipal, ConstMsg, APlanoConta;

procedure TFConsultaDespesas.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  VprOrdem := ' ORDER BY C_NOM_DES ';
  PosicionaDespesas;
end;

{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaDespesas.PosicionaDespesas;
begin
  FechaTabela(DESPESAS);
  LimpaSQLTabela(DESPESAS);
  DESPESAS.SQL.ADD(' SELECT * FROM CADDESPESAS CAD, CAD_PLANO_CONTA PLA '+
                   ' WHERE CAD.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
                   ' AND   CAD.C_CLA_PLA =  PLA.C_CLA_PLA ');
  if (EPlanoGeral.Text <> '') then
    DESPESAS.SQL.Add(' AND CAD.C_CLA_PLA = ''' + Trim(EPlanoGeral.Text) + '''') 
  else
    DESPESAS.SQL.Add(' ');
  DESPESAS.SQL.ADD(VprOrdem);
  AbreTabela(DESPESAS);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaDespesas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DESPESAS.close;
  aux.close;
  Action := CaFree;
end;

procedure TFConsultaDespesas.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFConsultaDespesas.EPlanoGeralExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := EPlanoGeral.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlanoGeral,  False, (Sender is TSpeedButton)) then
    EPlanoGeral.SetFocus;
  EPlanoGeral.text := VpfCodigo;
  PosicionaDespesas;
end;

procedure TFConsultaDespesas.EPlanoGeralChange(Sender: TObject);
begin
  PosicionaDespesas;
end;

procedure TFConsultaDespesas.BDesativaClick(Sender: TObject);
begin
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE CADDESPESAS SET ' +
    ' C_ATI_DES = ''N'', ' +
    ' D_ULT_ALT = ' + SQLTextoDataAAAAMMMDD(date) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_COD_DES = ' + IntToStr(DESPESASI_COD_DES.AsInteger));
  AUX.ExecSQL;
  PosicionaDespesas;
end;

procedure TFConsultaDespesas.BAtivaClick(Sender: TObject);
begin
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE CADDESPESAS SET ' +
    ' C_ATI_DES = ''S'',' +
    ' D_ULT_ALT = ' + SQLTextoDataAAAAMMMDD(date) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_COD_DES = ' + IntToStr(DESPESASI_COD_DES.AsInteger));
  AUX.ExecSQL;
  PosicionaDespesas;
end;

procedure TFConsultaDespesas.DESPESASAfterScroll(DataSet: TDataSet);
begin
  if DESPESAS.EOF then
  begin
    BDesativa.Enabled := False;
    BAtiva.Enabled := False;
  end
  else
  begin
    BDesativa.Enabled := UpperCase(Trim(DESPESASC_ATI_DES.AsString)) = 'S';
    BAtiva.Enabled := (not   BDesativa.Enabled);
  end;
end;

procedure TFConsultaDespesas.EPlanoGeralKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

procedure TFConsultaDespesas.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FConsultaDespesas.HelpContext);
end;

Initialization
  RegisterClasses([TFConsultaDespesas]);
end.
