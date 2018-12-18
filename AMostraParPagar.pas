unit AMostraParPagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Mask, DBCtrls, Tabela, Buttons, Grids, DBGrids, LabelCorMove,
  ExtCtrls, Componentes1, PainelGradiente, Db, DBTables, numericos,
  Localizacao, unContasaPagar;

type
  TFMostraParPagar = class(TFormulario)
    PainelGradiente1: TPainelGradiente;
    Painel: TPanelColor;
    Label3D1: TLabel3D;
    MovContasaPagar: TQuery;
    MovContasaPagarI_EMP_FIL: TIntegerField;
    MovContasaPagarI_LAN_APG: TIntegerField;
    MovContasaPagarI_NRO_PAR: TIntegerField;
    MovContasaPagarC_NRO_CON: TStringField;
    MovContasaPagarC_NRO_DUP: TStringField;
    MovContasaPagarD_DAT_VEN: TDateField;
    MovContasaPagarN_VLR_DUP: TFloatField;
    MovContasaPagarD_DAT_PAG: TDateField;
    MovContasaPagarN_VLR_PAG: TFloatField;
    MovContasaPagarN_VLR_DES: TFloatField;
    MovContasaPagarN_PER_JUR: TFloatField;
    MovContasaPagarN_PER_MOR: TFloatField;
    MovContasaPagarN_PER_MUL: TFloatField;
    MovContasaPagarI_COD_USU: TIntegerField;
    MovContasaPagarN_VLR_ACR: TFloatField;
    MovContasaPagarN_PER_DES: TFloatField;
    MovContasaPagarC_NRO_DOC: TStringField;
    MovContasaPagarN_VLR_JUR: TFloatField;
    MovContasaPagarN_VLR_MOR: TFloatField;
    MovContasaPagarN_VLR_MUL: TFloatField;
    MovContasaPagarI_COD_FRM: TIntegerField;
    DataMovContaaPagar: TDataSource;
    Aux: TQuery;
    PanelColor1: TPanelColor;
    Grade1: TDBGridColor;
    Grade: TDBGridColor;
    PanelColor2: TPanelColor;
    Label6: TLabel;
    Valor: Tnumerico;
    BOk: TBitBtn;
    MovContasaPagarD_CHE_VEN: TDateField;
    Localiza: TConsultaPadrao;
    MovContasaPagarC_FLA_PAR: TStringField;
    MovContasaPagarL_OBS_APG: TMemoField;
    DBMemoColor1: TDBMemoColor;
    Panel1: TPanel;
    Query1: TQuery;
    MovContasaPagarI_PAR_FIL: TIntegerField;
    MovContasaPagarC_DUP_CAN: TStringField;
    MovContasaPagarI_LAN_BAC: TIntegerField;
    BBAjuda: TBitBtn;
    MovContasaPagarD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure MovContasaPagarAfterInsert(DataSet: TDataSet);
    procedure MovContasaPagarN_VLR_DUPChange(Sender: TField);
    procedure MovContasaPagarAfterPost(DataSet: TDataSet);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grade1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grade1ColExit(Sender: TObject);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure BBAjudaClick(Sender: TObject);
    procedure MovContasaPagarBeforePost(DataSet: TDataSet);
  private
      CP : TFuncoesContasAPagar;
      AtualizaTotal : boolean;
      ValorInicialPar : Double;
      procedure LocalizaConta;
  public
     procedure Mostraparcelas( Codigolancamento : Integer; valorTotal : Double; TipoFormaPgto : string);
  end;

var
  FMostraParPagar: TFMostraParPagar;

implementation

uses APrincipal, constantes, ConstMsg, funstring, FunData, funsql;
{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraParPagar.FormCreate(Sender: TObject);
begin
  CP := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  Atualizatotal := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraParPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cp.destroy;
  aux.close;
  Query1.close;
  MovContasaPagar.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Ações das somas das parcelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ***************** Mostra as Parcelas a Pagar ******************************* }
procedure TFMostraParPagar.Mostraparcelas( Codigolancamento : Integer; valorTotal : Double; TipoFormaPgto : string);
begin
  //  self.historico := CodigoHistorico;
  cp.LocalizaParcelasComParciais(MovContasaPagar,CodigoLancamento);
  valor.AValor := valorTotal;
  valorInicialpar := valorTotal; // guarda informacao para verificar digitacao correta
  if (TipoFormaPgto <> 'C') then
     grade1.Visible := false;
  ShowModal;
end;


{**********************equivalente ao somatorio das parcelas********************}
procedure TFMostraParPagar.BOkClick(Sender: TObject);
begin
  if (MovContasaPagar.State = dsEdit) then
     GravaReg(MovContasaPagar);
  if cp.VerificaAtualizaValoresParcelas(valorInicialpar, MovContasaPagar.fieldByName('I_LAN_APG').AsInteger) then
    self.Close;
end;

{********************Não permite adicionar mais parcelas***********************}
procedure TFMostraParPagar.MovContasaPagarAfterInsert(DataSet: TDataSet);
begin
  MovContasAPagar.Cancel;
end;

{**************coloca true no flag para atualizar o valor total****************}
procedure TFMostraParPagar.MovContasaPagarN_VLR_DUPChange(Sender: TField);
begin
  Atualizatotal := true;
end;

{*************Atualiza o valor total se o campo valor foi alterado*************}
procedure TFMostraParPagar.MovContasaPagarAfterPost(DataSet: TDataSet);
begin
  if  Atualizatotal then
  begin
    valor.AValor :=  cp.SomaTotalParcelas(MovContasaPagar.fieldByName('I_LAN_APG').AsInteger );
    Atualizatotal := false;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Ações que tratam do grid
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFMostraParPagar.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    BOk.Click;
  if Grade1.Visible then
    if (( KEY = 9 ) or ( KEY = 39 )) and (grade.Columns.Grid.SelectedIndex = (grade.Columns.Count -1)) then
    begin
      self.ActiveControl := Grade1;
      grade1.Columns.grid.SelectedIndex := 0;
      abort;
    end;
end;

procedure TFMostraParPagar.Grade1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    BOk.Click;
  if (grade1.SelectedIndex = 0) and (key = 114) then
     LocalizaConta;
  if (((KEY = 9) and (Shift = [ssShift])) or ( KEY = 37 )) and (grade1.Columns.Grid.SelectedIndex = 0) then
  begin
    self.ActiveControl := Grade;
    grade1.Columns.grid.SelectedIndex := grade.Columns.Count -1;
    abort;
  end;
end;


procedure TFMostraParPagar.Grade1ColExit(Sender: TObject);
begin
  if ( MovContasAPAgar.State in [dsInsert,dsEdit]) then
  case grade1.Columns.Grid.SelectedIndex of
    0 : LocalizaConta; // valida o campo codigo caso esteja vazio
  end;
end;

{************************** localiza Conta ************************************}
procedure TFMostraParPagar.LocalizaConta;
begin
  if  (not grade.Columns[0].Field.IsNull) then
  begin
     aux.Close;
     aux.SQL.Clear;
     aux.sql.Add('select * from CadContas where c_nro_con = ''' +
                 MovContasAPagarC_NRO_CON.AsString  +  '''' );
     aux.open;
  end;
  if (aux.EOF) or (MovContasaPagar.FieldByName('c_nro_con').IsNull)  then
  begin
      Localiza.info.DataBase := Fprincipal.BaseDados;
      Localiza.info.ComandoSQL := 'Select * from cadbancos as Ban, CadContas as Co ' +
                                  ' where  Ban.I_COD_BAN = Co.I_COD_BAN and ' +
                                  ' Co.C_NRO_CON like ''@%''';
      Localiza.info.caracterProcura := '@';
      Localiza.info.ValorInicializacao := '';
      Localiza.info.CamposMostrados[0] := 'c_nro_con';
      Localiza.info.CamposMostrados[1] := 'c_nom_ban';
      Localiza.info.CamposMostrados[2] := '';
      Localiza.info.DescricaoCampos[0] := 'Conta';
      Localiza.info.DescricaoCampos[1] := 'Banco';
      Localiza.info.DescricaoCampos[2] := '';
      Localiza.info.TamanhoCampos[0] := 8;
      Localiza.info.TamanhoCampos[1] := 40;
      Localiza.info.TamanhoCampos[2] := 0;
      Localiza.info.CamposRetorno[0] := 'c_nro_con';
      Localiza.info.CamposRetorno[1] := '';
      Localiza.info.CamposRetorno[2] := '';
      Localiza.info.CamposRetorno[3] := '';
      Localiza.info.SomenteNumeros := false;
      Localiza.info.CorFoco := FPrincipal.CorFoco;
      Localiza.info.CorForm := FPrincipal.CorForm;
      Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
      Localiza.info.TituloForm := 'Localizar Produto';
      Localiza.ACadastrar := true;

      if not(MovContasaPagar.State in [dsEdit,dsInsert]) then
         MovContasapagar.Edit;

       if Localiza.execute then
          MovContasAPagarC_NRO_CON.Value := Localiza.retorno[0]
end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Baixa o movimento Contas a Pagar
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFMostraParPagar.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

procedure TFMostraParPagar.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FMostraParPagar.HelpContext);
end;



procedure TFMostraParPagar.MovContasaPagarBeforePost(DataSet: TDataSet);
begin
  MovContasaPagarD_ULT_ALT.AsDateTime := date;
end;

Initialization
 RegisterClasses([TFMostraParPagar]);
end.
