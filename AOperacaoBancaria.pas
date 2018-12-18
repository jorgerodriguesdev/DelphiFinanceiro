unit AOperacaoBancaria;

{          Autor: Sergio
    Data Criação: 19/10/1999;
          Função: Cadastrar um novo Caixa
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, Constantes,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Grids, DBGrids,
  DBKeyViolation, Localizacao;

type
  TFOperacaoBancaria = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BAlterar: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    DATAOperacao: TDataSource;
    Label3: TLabel;
    ESiglaPais: TDBEditColor;
    Bevel1: TBevel;
    Label1: TLabel;
    EConsulta: TLocalizaEdit;
    CadOperacaoBancaria: TSQL;
    BFechar: TBitBtn;
    GGrid: TGridIndice;
    ValidaGravacao: TValidaGravacao;
    Label4: TLabel;
    DBEditColor1: TDBEditColor;
    BBAjuda: TBitBtn;
    CadOperacaoBancariaC_OPE_BAN: TStringField;
    CadOperacaoBancariaC_DES_BAN: TStringField;
    CadOperacaoBancariaC_BAI_CCP: TStringField;
    DBCheckBox1: TDBCheckBox;
    CadOperacaoBancariaD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadOperacaoBancariaAfterInsert(DataSet: TDataSet);
    procedure CadOperacaoBancariaAfterPost(DataSet: TDataSet);
    procedure CadOperacaoBancariaAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadOperacaoBancariaAfterCancel(DataSet: TDataSet);
    procedure GGridOrdem(Ordem: String);
    procedure PaisChange(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadOperacaoBancariaBeforePost(DataSet: TDataSet);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FOperacaoBancaria: TFOperacaoBancaria;

implementation

uses APrincipal, ACadPaises, FunObjeto;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFOperacaoBancaria.FormCreate(Sender: TObject);
begin
   Self.HelpFile := Varia.PathHelp + 'MaGeral.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   CadOperacaoBancaria.open;
   IniciallizaCheckBox([DBCheckBox1],'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFOperacaoBancaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadOperacaoBancaria.Close; { fecha tabelas }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações da Tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFOperacaoBancaria.CadOperacaoBancariaAfterInsert(DataSet: TDataSet);
begin
   ESiglaPais.ReadOnly := False;
   ConfiguraConsulta(False);
   CadOperacaoBancariaC_BAI_CCP.AsString := 'N';
end;

{******************************Atualiza a tabela*******************************}
procedure TFOperacaoBancaria.CadOperacaoBancariaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaTabela;
  ConfiguraConsulta(True);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFOperacaoBancaria.CadOperacaoBancariaAfterEdit(DataSet: TDataSet);
begin
   ESiglaPais.ReadOnly := true;
   ConfiguraConsulta(False);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFOperacaoBancaria.CadOperacaoBancariaAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(True);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFOperacaoBancaria.BFecharClick(Sender: TObject);
begin
  Close;
end;

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFOperacaoBancaria.ConfiguraConsulta( acao : Boolean);
begin
   Label1.Enabled := acao;
   EConsulta.Enabled := acao;
   GGrid.Enabled := acao;
end;

procedure TFOperacaoBancaria.GGridOrdem(Ordem: String);
begin
  EConsulta.AOrdem := ordem;
end;

procedure TFOperacaoBancaria.PaisChange(Sender: TObject);
begin
  if (CadOperacaoBancaria.State in [dsInsert, dsEdit]) then
  ValidaGravacao.Execute;
end;

procedure TFOperacaoBancaria.BBAjudaClick(Sender: TObject);
begin
 Application.HelpCommand(HELP_CONTEXT,self.HelpContext);
end;

{******************* antes de gravar o registro *******************************}
procedure TFOperacaoBancaria.CadOperacaoBancariaBeforePost(
  DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadOperacaoBancariaD_ULT_ALT.AsDateTime := Date;
end;

Initialization
 RegisterClasses([TFOperacaoBancaria]);
end.
