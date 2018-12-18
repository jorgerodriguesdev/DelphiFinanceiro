unit ABancos;
{       Data Criação: 29/03/1999;
          Função: Cadastrar um novo Banco
  Data Alteração: 29/03/1999;
    Alterado por: JORGE EDUARDO
Motivo alteração: COLOCAR FLAG P/MOSTRAR FLUXO
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids;

type
  TFBancos = class(TFormularioPermissao)
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
    DataBancos: TDataSource;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    DBKeyViolation1: TDBKeyViolation;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    ProximoCodigo1: TProximoCodigo;
    CadBancos: TSQL;
    CadBancosI_COD_BAN: TIntegerField;
    CadBancosC_NOM_BAN: TStringField;
    CadBancosC_NRO_AGE: TStringField;
    consulta: TLocalizaEdit;
    DBEditColor4: TDBEditColor;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEditPos21: TDBEditPos2;
    DBEditPos22: TDBEditPos2;
    Label6: TLabel;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    BBAjuda: TBitBtn;
    CadBancosC_FON_BAN: TStringField;
    CadBancosC_FAX_BAN: TStringField;
    CadBancosD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadBancosAfterInsert(DataSet: TDataSet);
    procedure CadBancosBeforePost(DataSet: TDataSet);
    procedure CadBancosAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadBancosAfterEdit(DataSet: TDataSet);
    procedure CadBancosAfterCancel(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FBancos : TFBancos;

implementation

uses APrincipal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBancos.FormCreate(Sender: TObject);
begin
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
   CadBancos.open;  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
 procedure TFBancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadBancos.close; { fecha tabelas }
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFBancos.CadBancosAfterInsert(DataSet: TDataSet);
begin
   ProximoCodigo1.execute('CadBancos');
   DBKeyViolation1.ReadOnly := False;
   ConfiguraConsulta(false);
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFBancos.CadBancosBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadBancosD_ULT_ALT.AsDateTime := Date;

  If CadBancos.State = dsInsert Then
    ProximoCodigo1.VerificaCodigo;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFBancos.CadBancosAfterPost(DataSet: TDataSet);
begin
   consulta.AtualizaTabela;
   ConfiguraConsulta(true);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFBancos.CadBancosAfterEdit(DataSet: TDataSet);
begin
   DBKeyViolation1.ReadOnly := true;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFBancos.CadBancosAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFBancos.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label6.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFBancos.BFecharClick(Sender: TObject);
begin
   self.close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFBancos.DBGridColor1Ordem(Ordem: String);
begin
consulta.AOrdem := ordem;
end;

procedure TFBancos.DBKeyViolation1Change(Sender: TObject);
begin
if CadBancos.State in [ dsEdit, dsInsert ] then
  ValidaGravacao1.execute;
end;

procedure TFBancos.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FBancos.HelpContext);
end;

Initialization
 RegisterClasses([TFBancos]);
end.
