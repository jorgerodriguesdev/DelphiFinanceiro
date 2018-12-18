unit AAdicionais;

{          Autor: Jorge Eduardo
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
  DBKeyViolation, Localizacao, UnContasAReceber, numericos;

type
  TFAdicionais = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DATACADPAGAR: TDataSource;
    CADPAGAR: TQuery;
    CADPAGARI_LAN_APG: TIntegerField;
    CADPAGARN_VLR_TOT: TFloatField;
    CADPAGARI_LAN_REC: TIntegerField;
    CADPAGARN_VLR_REC: TFloatField;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    GridIndice1: TGridIndice;
    AUX: TQuery;
    CADPAGARC_CLA_PLA: TStringField;
    PLANO: TQuery;
    CADPAGARPLANO_CONTAS: TStringField;
    CADPAGARI_NRO_NOT: TIntegerField;
    Label1: TLabel;
    ETotal: Tnumerico;
    Label2: TLabel;
    EReceber: Tnumerico;
    BBAjuda: TBitBtn;
    CADPAGARI_PAR_REC: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CADPAGARBeforeInsert(DataSet: TDataSet);
    procedure CADPAGARBeforePost(DataSet: TDataSet);
    procedure GridIndice1Exit(Sender: TObject);
    procedure CADPAGARAfterPost(DataSet: TDataSet);
    function CalculaTotalReceber: Double;
    procedure BBAjudaClick(Sender: TObject);
  private
    CR : TFuncoesContasAReceber;
  public
    { Public declarations }
    function CarregaAdicional(VpaOrdem, VpaParcela: Integer): Double;
  end;

var
  FAdicionais: TFAdicionais;

implementation

uses APrincipal, funsql, ConstMsg;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFAdicionais.FormCreate(Sender: TObject);
begin
  CR := TFuncoesContasAReceber.criar(self, FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
  AdicionaSQLAbreTabela(PLANO,
    ' SELECT * FROM CAD_PLANO_CONTA ' +
    ' WHERE I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa));
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAdicionais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CR.Destroy;
  FechaTabela(PLANO);
  FechaTabela(CADPAGAR);
  Aux.close;
  Action := CaFree;
end;

{***** Carrega as contas a pagar vinculada a conta a receber informada *****}
function TFAdicionais.CarregaAdicional(VpaOrdem, VpaParcela: Integer): Double;
begin
  Result := CR.SomaValoresAdicionais(VpaOrdem, VpaParcela);
  if (Result > 0) then
  begin
    AdicionaSQLAbreTabela(CADPAGAR,
      ' SELECT * FROM CADCONTASAPAGAR ' +
      ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
      ' AND I_LAN_REC = ' + IntToStr(VpaOrdem) +
      ' AND I_PAR_REC = ' + IntToStr(VpaParcela) +
      ' AND N_VLR_REC >= 0');
    ETotal.AValor := Result;
    EReceber.AValor := CalculaTotalReceber;
    Self.ShowModal;
  end
  else
  begin
    Aviso('Este título não possui adicionais a pagar vinculados.');
    Close;
  end;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFAdicionais.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFAdicionais.CADPAGARBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFAdicionais.CADPAGARBeforePost(DataSet: TDataSet);
begin
  if (CADPAGARN_VLR_REC.AsFloat > CADPAGARN_VLR_TOT.AsFloat) then
  begin
    Aviso('O valor recebido não pode ser maior que o valor do adicional.');
    CADPAGAR.Cancel;
    Abort;
  end;
end;

procedure TFAdicionais.GridIndice1Exit(Sender: TObject);
begin
  if (CADPAGAR.State = dsEdit) then
    CADPAGAR.Post;
end;

procedure TFAdicionais.CADPAGARAfterPost(DataSet: TDataSet);
begin
  EReceber.AValor := CalculaTotalReceber;
end;

function TFAdicionais.CalculaTotalReceber: Double;
begin
  Result := 0;
  CADPAGAR.DisableControls;
  CADPAGAR.First;
  while not CADPAGAR.EOF do
  begin
    Result := Result + CADPAGARN_VLR_REC.AsFloat;
    CADPAGAR.Next;
  end;
  CADPAGAR.EnableControls;
end;

procedure TFAdicionais.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FAdicionais.HelpContext);
end;

Initialization
 RegisterClasses([TFAdicionais]);
end.
