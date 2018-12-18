unit AConciliacaoBan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, PainelGradiente, ExtCtrls,
  Componentes1, StdCtrls, Buttons, LabelCorMove, DBKeyViolation;

type
  TFConciliacao = class(TFormularioPermissao)
    PanelColor3: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DBGridColor1: TGridIndice;
    DataMovContas: TDataSource;
    MovContas: TQuery;
    CadPlano: TQuery;
    MovContasI_LAN_BAC: TIntegerField;
    MovContasC_NRO_CON: TStringField;
    MovContasN_VLR_ENT: TFloatField;
    MovContasN_VLR_SAI: TFloatField;
    MovContasN_SAL_ATU: TFloatField;
    MovContasD_DAT_COM: TDateField;
    MovContasC_NRO_DOC: TStringField;
    MovContasC_CON_BAN: TStringField;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Label3D1: TLabel3D;
    Label3D2: TLabel3D;
    MovContasC_CLA_PLA: TStringField;
    MovContasPlano_de_Contas: TStringField;
    BBAjuda: TBitBtn;
    Conciliado: TComboBoxColor;
    Label1: TLabel;
    MovContasD_DAT_MOV: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure MovContasC_CON_BANSetText(Sender: TField;
      const Text: String);
    procedure MovContasAfterInsert(DataSet: TDataSet);
    procedure BBAjudaClick(Sender: TObject);
    procedure ConciliadoClick(Sender: TObject);
    procedure MovContasBeforePost(DataSet: TDataSet);
  private
    NroConta, Nomebanco, NroDoc : string;
    Data1, data2 : TDateTime;
  public
    procedure CarregaContas(NroConta, NroDoc : string; Data1, data2 : TDateTime; Nomebanco : string );
  end;

var
  FConciliacao: TFConciliacao;

implementation

{$R *.DFM}

uses Fundata, Constantes, funsql, APrincipal;

{ ****************** Na criação do Formulário ******************************** }
procedure TFConciliacao.FormCreate(Sender: TObject);
begin
  AbreTabela(CadPlano);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  Conciliado.ItemIndex := 0;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConciliacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CadPlano);
  movcontas.close;
  Action := CaFree;
end;

{ *************************** carrega contas a conciliar ********************* }
procedure TFConciliacao.CarregaContas(NroConta, NroDoc : string; Data1, data2 : TDateTime; Nomebanco : string );
begin
  self.NroConta := NroConta;
  self.Nomebanco := Nomebanco;
  self.Data1  := data1;
  self.Data2 := data2;
  self.NroDoc := NroDoc;
  Label3D1.Caption := 'Conta Nº : ' + NroConta + ' do ' + NomeBanco;
  Label3D2.Caption := 'Período de ' + dateToStr(data1) + ' à '+ DateToStr(data2);
  LimpaSQLTabela(MovContas);
  InseriLinhaSQL(MovContas, 0, 'Select ' );
  InseriLinhaSQL(MovContas, 1, ' * ' );
  InseriLinhaSQL(MovContas, 2, ' from Movbancos ' );
  InseriLinhaSQL(MovContas, 3, ' where C_NRO_CON = ''' + NroConta + '''' );
  InseriLinhaSQL(MovContas, 4,' and D_DAT_COM between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                              ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + ''''  +
                              ' and c_che_can = ''N''');

  case Conciliado.ItemIndex of
    0 : InseriLinhaSQL(MovContas, 5, ' and C_CON_BAN = ''N''' );
    1 : InseriLinhaSQL(MovContas, 5, ' and C_CON_BAN = ''S''' );
    2 : InseriLinhaSQL(MovContas, 5, '' );
  end;

  if NroDoc <> '' then
   InseriLinhaSQL(MovContas, 6, ' and C_NRO_DOC = ''' + nrodoc + '''' )
  else
   InseriLinhaSQL(MovContas, 6,' ');


  InseriLinhaSQL(MovContas, 7,' order by D_DAT_COM ');
  AbreTabela(MovContas);
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConciliacao.BitBtn1Click(Sender: TObject);
begin
  if MovContas.State = dsEdit then
    GravaReg(MovContas);
  self.close;
end;

{******************** valida apenas , S, s, N, s no campo conciliado ********* }
procedure TFConciliacao.MovContasC_CON_BANSetText(Sender: TField;
  const Text: String);
begin
  if (text = 's') or (text =  'S' ) then
    sender.Value := 'S';

  if (text = 'n') or (text =  'N' ) then
    sender.Value := 'N';
end;

{************* cancela caso tente enserir novo registro ******************** }
procedure TFConciliacao.MovContasAfterInsert(DataSet: TDataSet);
begin
  MovContas.Cancel;
end;

procedure TFConciliacao.BBAjudaClick(Sender: TObject);
begin
Application.HelpCommand(HELP_CONTEXT,FConciliacao.HelpContext);
end;

procedure TFConciliacao.ConciliadoClick(Sender: TObject);
begin
  CarregaContas( NroConta, NroDoc, data1,data2,Nomebanco);
end;

procedure TFConciliacao.MovContasBeforePost(DataSet: TDataSet);
begin
  MovContasD_DAT_MOV.AsDateTime := date;
end;

Initialization
  RegisterClasses([TFConciliacao]);

end.
