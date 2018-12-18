unit ANovaComissao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DBKeyViolation, Buttons, Localizacao, StdCtrls, Mask, DBCtrls, Tabela,
  Db, DBTables, Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro;

type
  TFNovaComissao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MovComissoes: TSQL;
    MovComissoesI_EMP_FIL: TIntegerField;
    MovComissoesI_LAN_CON: TIntegerField;
    MovComissoesI_LAN_REC: TIntegerField;
    MovComissoesI_COD_VEN: TIntegerField;
    MovComissoesD_DAT_VEN: TDateField;
    MovComissoesD_DAT_PAG: TDateField;
    MovComissoesD_DAT_VAL: TDateField;
    MovComissoesN_VLR_COM: TFloatField;
    MovComissoesI_NRO_PAR: TIntegerField;
    MovComissoesN_PER_PAG: TFloatField;
    MovComissoesI_TIP_COM: TIntegerField;
    Label1: TLabel;
    DataMovComissoes: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditNumerico;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Localiza: TConsultaPadrao;
    BitBtn1: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    BBAjuda: TBitBtn;
    MovComissoesC_CAN_COM: TStringField;
    DBMemoColor1: TDBMemoColor;
    MovComissoesL_OBS_COM: TMemoField;
    Label3: TLabel;
    MovComissoesN_PER_COM: TFloatField;
    Label4: TLabel;
    DBEditNumerico1: TDBEditNumerico;
    MovComissoesD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MovComissoesAfterInsert(DataSet: TDataSet);
    procedure MovComissoesBeforePost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBEditColor1Change(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
  public
    procedure LocalizaComissaoExclusao(Lancamento : String );
  end;

var
  FNovaComissao: TFNovaComissao;

implementation

uses
  APrincipal, AMovComissoes, constMsg, constantes, UnComissoes1;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          inicializacao de destruicao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaComissao.FormCreate(Sender: TObject);
begin
  MovComissoes.open;
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaComissao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovComissoes.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          acoes na tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ************************ depois do insert ****************************** }
procedure TFNovaComissao.MovComissoesAfterInsert(DataSet: TDataSet);
begin
  DBEditcolor1.Field.Value := varia.CodigoEmpFil;
  MovComissoesC_CAN_COM.AsString := 'N';
end;

{********************* antes do post **************************************** }
procedure TFNovaComissao.MovComissoesBeforePost(DataSet: TDataSet);
begin
   MovComissoesD_ULT_ALT.AsDateTime := date;
  if Dataset.state = dsinsert Then
    MovComissoesI_LAN_CON.AsInteger := GeraProximoCodigo('I_LAN_CON','MOvComissoes','I_EMP_FIL',varia.CodigoEmpFil,fprincipal.BaseDados, true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            acoes diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** fecha o formulario ******************************** }
procedure TFNovaComissao.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

{ *************** Localiza Comissao dos Vendedores *************************** }
procedure TFNovaComissao.LocalizaComissaoExclusao(Lancamento : String );
begin
  MovComissoes.Close;
  MovComissoes.sql.Clear;
  MovComissoes.sql.Add('select * from MovComissoes where i_emp_fil = '+ InttoStr(varia.CodigoEmpFil) +
                       ' and I_LAN_CON = ' + Lancamento );
  MovComissoes.open;
  DBEditLocaliza1.Atualiza;
end;

{  ************** valida gravacao ****************************************** }
procedure TFNovaComissao.DBEditColor1Change(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

procedure TFNovaComissao.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FNovaComissao.HelpContext);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaComissao]);
end.
 