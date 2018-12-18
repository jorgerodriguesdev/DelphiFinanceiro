unit AContas;
{          Autor: Jorge Eduardo
    Data Criação: 29/03/1999;
          Função: Cadastrar contas
  Data Alteração: 29/03/1999;
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids;

type
  TFContas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    DataContas: TDataSource;
    Label2: TLabel;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    CadContas: TSQL;
    Consulta: TLocalizaEdit;
    Label4: TLabel;
    Label6: TLabel;
    BFechar: TBitBtn;
    CadContasC_NRO_CON: TStringField;
    CadContasI_COD_BAN: TIntegerField;
    CadContasC_NOM_GER: TStringField;
    DBEditColor2: TDBEditColor;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    CadContasNomeBanco: TStringField;
    DBKeyViolation1: TDBKeyViolation;
    Label3: TLabel;
    DBEditColor1: TDBEditColor;
    CadContasD_DAT_ABE: TDateField;
    DBEditColor3: TDBEditColor;
    Label7: TLabel;
    CadContasC_NOM_CRR: TStringField;
    CadBancos: TQuery;
    ValidaGravacao1: TValidaGravacao;
    CadContasN_LIM_CRE: TFloatField;
    Label8: TLabel;
    DBEditColor4: TDBEditColor;
    BBAjuda: TBitBtn;
    CadContasD_ULT_ALT: TDateField;
    CadContasC_MOS_FLU: TStringField;
    Label9: TLabel;
    DbFluxo: TDBEditChar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadContasAfterEdit(DataSet: TDataSet);
    procedure CadContasAfterInsert(DataSet: TDataSet);
    procedure CadContasAfterScroll(DataSet: TDataSet);
    procedure CadContasAfterPost(DataSet: TDataSet);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure CadContasAfterCancel(DataSet: TDataSet);
    procedure DBEditLocaliza1Change(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadContasBeforePost(DataSet: TDataSet);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FContas: TFContas;

implementation

uses APrincipal, Constantes, ABancos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContas.FormCreate(Sender: TObject);
begin
   CadContas.open;
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

{ ******************* Quando o formulario e fechado ************************** }
 procedure TFContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadContas.close;
   CadBancos.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************Coloca o campo chave em read-only************************}
procedure TFContas.CadContasAfterEdit(DataSet: TDataSet);
begin
   CadContasC_NRO_CON.ReadOnly := true;
   ConfiguraConsulta(false);
end;

{**********************Tira o campo chave em read-only*************************}
procedure TFContas.CadContasAfterInsert(DataSet: TDataSet);
begin
   CadContasC_NRO_CON.ReadOnly := false;
   DBEditLocaliza1.Atualiza;
   ConfiguraConsulta(false);
   CadContasC_MOS_FLU.AsString := 'S';
end;

{*********************Atualiza a tabela apos gravar****************************}
procedure TFContas.CadContasAfterPost(DataSet: TDataSet);
begin
   Consulta.AtualizaTabela;
   ConfiguraConsulta(true);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFContas.CadContasAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFContas.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label6.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFContas.BFecharClick(Sender: TObject);
begin
self.close;
end;

{***************************Atualiza o localiza********************************}
procedure TFContas.CadContasAfterScroll(DataSet: TDataSet);
begin
   DBEditLocaliza1.Atualiza;
end;

{*************************Cadastra um novo banco*******************************}
procedure TFContas.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
   FBancos := TFBancos.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FBancos'));
   FBancos.BotaoCadastrar1.Click;
   FBancos.ShowModal;
   Localiza.AtualizaConsulta;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFContas.DBGridColor1Ordem(Ordem: String);
begin
Consulta.AOrdem := ordem;
end;


procedure TFContas.DBEditLocaliza1Change(Sender: TObject);
begin
if CadContas.State in [ dsInsert, dsEdit ] then
 ValidaGravacao1.execute;
end;

procedure TFContas.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FContas.HelpContext);
end;

procedure TFContas.CadContasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadContasD_ULT_ALT.AsDateTime := Date;
end;

Initialization
{*******************Registra a classe para evitar duplicidade******************}
 RegisterClasses([TFContas]);
end.
