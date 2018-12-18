unit AMostraParReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, PainelGradiente, StdCtrls, Mask, DBCtrls, Tabela, Buttons,
  Grids, DBGrids, ExtCtrls, Componentes1, numericos, UnContasAReceber, Spin;

type
  TFMostraParReceber = class(TFormulario)
    Painel: TPanelColor;
    Label6: TLabel;
    BOk: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    DataMovContaaReceber: TDataSource;
    MovContasaReceber: TQuery;
    MovContasaReceberI_EMP_FIL: TIntegerField;
    MovContasaReceberI_LAN_REC: TIntegerField;
    MovContasaReceberI_NRO_PAR: TIntegerField;
    MovContasaReceberD_DAT_VEN: TDateField;
    MovContasaReceberD_DAT_PAG: TDateField;
    MovContasaReceberN_VLR_PAR: TFloatField;
    MovContasaReceberN_VLR_DES: TFloatField;
    MovContasaReceberN_VLR_PAG: TFloatField;
    MovContasaReceberN_VLR_ACR: TFloatField;
    MovContasaReceberN_PER_MOR: TFloatField;
    MovContasaReceberN_PER_JUR: TFloatField;
    MovContasaReceberN_PER_COR: TFloatField;
    MovContasaReceberI_COD_USU: TIntegerField;
    MovContasaReceberN_PER_MUL: TFloatField;
    MovContasaReceberI_COD_FRM: TIntegerField;
    valor: Tnumerico;
    MovContasaReceberC_NRO_DUP: TStringField;
    MovContasaReceberN_DES_VEN: TFloatField;
    MovContasaReceberL_OBS_REC: TMemoField;
    BBAjuda: TBitBtn;
    Bfechar: TBitBtn;
    MovContasaReceberD_ULT_ALT: TDateField;
    PanelColor1: TPanelColor;
    Grade: TDBGridColor;
    PanelColor2: TPanelColor;
    DBMemoColor1: TDBMemoColor;
    Label1: TLabel;
    PanelColor3: TPanelColor;
    SpinEditColor1: TSpinEditColor;
    Button3: TButton;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure MovContasaReceberAfterInsert(DataSet: TDataSet);
    procedure MovContasaReceberN_VLR_PARChange(Sender: TField);
    procedure MovContasaReceberAfterPost(DataSet: TDataSet);
    procedure GradeColExit(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MovContasaReceberBeforePost(DataSet: TDataSet);
    procedure BfecharClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Atualizatotal : boolean;
    valorInicialpar : Double;
    CR : TFuncoesContasAReceber;
    procedure MudaDiasMes( Tipo : integer);
    procedure AlteraDiasMes( Tipo : integer);
  public
     procedure Mostraparcelas( Codigolancamento : Integer; valorTotal : Double);
     procedure VisualizaParcelas( Codigolancamento : Integer);
     Procedure MostraInadimplentes(CodCliente : Integer; ValorTotal : Double);
  end;

var
  FMostraParReceber: TFMostraParReceber;

implementation

uses APrincipal, constantes, ConstMsg, funsql, fundata;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraParReceber.FormCreate(Sender: TObject);
begin
   Atualizatotal := false;
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   CR := TFuncoesContasAReceber.criar(Self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraParReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FechaTabela(MovContasaReceber);
 Action := CaFree;
end;

{ ************************** mostra as parcelas **************************** }
procedure TFMostraParReceber.Mostraparcelas( Codigolancamento : Integer; valorTotal : Double);
begin
  CR.LocalizaParcelasComParciais(MovContasaReceber, Codigolancamento);
  valor.AValor :=  valorTotal;
  valorInicialpar := valorTotal;
  PanelColor3.Visible := false;
  ShowModal;
end;

procedure TFMostraParReceber.VisualizaParcelas( Codigolancamento : Integer);
begin
  CR.LocalizaParcelasComParciais(MovContasaReceber, Codigolancamento);
  valor.Visible := false;
  Label6.Visible := false;
  BOk.Visible := false;
  Bfechar.Visible := true;
  grade.Columns[3].ReadOnly := true;
  ShowModal;
end;


{ ************  ok para fechar o formulario ******************************** }
procedure TFMostraParReceber.BOkClick(Sender: TObject);
begin
  if (MovContasaReceber.State = dsEdit) then
     MovContasaReceber.Post;
  if CR.VerificaAtualizaValoresParcelas(valorInicialpar, MovContasaReceber.fieldByName('I_LAN_REC').AsInteger) then
  close;
end;

{ **************** evita a insercao de novas parcelas ************************ }
procedure TFMostraParReceber.MovContasaReceberAfterInsert(
  DataSet: TDataSet);
begin
  MovContasAReceber.Cancel;
end;

{ ************ quando for atualizado o valor da parcela ********************** }
procedure TFMostraParReceber.MovContasaReceberN_VLR_PARChange(
  Sender: TField);
begin
  Atualizatotal := true;
end;

{ ************* soma o valor total das parcelas ************************** }
procedure TFMostraParReceber.MovContasaReceberAfterPost(DataSet: TDataSet);
begin
  if  Atualizatotal then
  begin
    valor.AValor :=  CR.SomaTotalParcelas(MovContasaReceber.fieldByName('I_LAN_REC').AsInteger);
    Atualizatotal := false;
  end;
end;

{*************** verefica se a data e valida **********************************}
procedure TFMostraParReceber.GradeColExit(Sender: TObject);
begin
  if (config.DataVencimentoMenor) and (grade.SelectedIndex = 2) and (MovContasAReceberD_DAT_VEN.AsDateTime < date) then
  begin
    Aviso(CT_DataMenorQueAtual);
    MovContasaReceber.Cancel;
  end;
end;

procedure TFMostraParReceber.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FMostraParReceber.HelpContext);
end;

procedure TFMostraParReceber.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    BOk.Click;
end;

{************  antes de gravar o mov contas a receber ************************ }
procedure TFMostraParReceber.MovContasaReceberBeforePost(
  DataSet: TDataSet);
begin
//caso modifique o numero da duplicata e este seja igual ao documento
MovContasaReceberD_ULT_ALT.AsDateTime := date;
end;

procedure TFMostraParReceber.BfecharClick(Sender: TObject);
begin
  if (MovContasaReceber.State = dsEdit) then
     MovContasaReceber.Post;
  self.close;
end;

Procedure TFMostraParReceber.MostraInadimplentes(CodCliente : Integer; ValorTotal : Double);
begin
  valor.AValor := ValorTotal;
  Label6.Caption := 'Valor Total :';
  PainelGradiente1.Caption := '  Parcelas vencidas ';
  Label1.Visible := false;
  BOk.Visible := false;
  Bfechar.Visible := true;
  PanelColor2.Visible := false;
  PanelColor3.Visible := false;
  self.Height := Self.Height - PanelColor2.Height;
  Grade.Columns[4].Visible := false;
  Grade.Columns[5].Visible := false;
  Grade.Columns[6].Visible := false;
  Grade.Columns[7].Visible := false;
  Grade.Columns.Items[1].FieldName := 'I_NRO_NOT';
  Grade.Columns.Items[1].Title.Caption := 'Nro Nota';
  self.Width := 413;
  Bfechar.Left := 290;
  MovContasaReceber.RequestLive := false;
  AdicionaSQLAbreTabela(MovContasaReceber,
                            ' select * from cadcontasareceber cad ' +
                            ' key join movcontasareceber mov ' +
                            ' where cad.i_cod_CLI = ' + IntTostr(CodCliente) +
                            ' and n_vlr_pag is null  ' +
                            ' and d_dat_ven < ' + SQLTextoDataAAAAMMMDD(DecDia(date,Varia.DiasCarenciaIna) ) +
                            ' and isnull(C_DUP_CAN, ''N'') = ''N'' '+
                            ' order by d_dat_ven ');
  DBMemoColor1.Visible := false;

end;
procedure TFMostraParReceber.AlteraDiasMes( Tipo : integer);
begin
  if not (MovContasaReceber.State in [dsedit, dsInsert]) then
    MovContasaReceber.edit;
  case Tipo of
    1 : MovContasaReceberD_DAT_VEN.AsDateTime := IncDia(MovContasaReceberD_DAT_VEN.AsDateTime, SpinEditColor1.Value);
    2 : MovContasaReceberD_DAT_VEN.AsDateTime := IncDia(MovContasaReceberD_DAT_VEN.AsDateTime, 1);
    3 : MovContasaReceberD_DAT_VEN.AsDateTime := IncMes(MovContasaReceberD_DAT_VEN.AsDateTime, 1);
  end;
  if (MovContasaReceber.State in [dsedit, dsInsert]) then
    MovContasaReceber.post;
end;

procedure TFMostraParReceber.MudaDiasMes( Tipo : integer);
begin
  if CheckBox1.Checked then
  begin
    while not MovContasaReceber.eof do
    begin
      AlteraDiasMes(tipo);
      MovContasaReceber.next;
    end;
  end
  else
    AlteraDiasMes(tipo);
  MovContasaReceber.First;
end;

procedure TFMostraParReceber.Button3Click(Sender: TObject);
begin
  MudaDiasMes(1);
end;

procedure TFMostraParReceber.Button1Click(Sender: TObject);
begin
  MudaDiasMes(2);
end;

procedure TFMostraParReceber.Button2Click(Sender: TObject);
begin
  MudaDiasMes(3);
end;

Initialization
 RegisterClasses([TFMostraParReceber]);
end.
