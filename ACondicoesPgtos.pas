unit ACondicoesPgtos;
{          Autor: Jorge Eduardo
    Data Criação: 25/08/1999;
          Função:
  Data Alteração: 
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Mask, DBCtrls, Tabela,
  DBKeyViolation, Db, BotaoCadastro, Buttons, DBTables,
  Localizacao, Grids, DBGrids, LabelCorMove, Parcela, UnContasAReceber;

type
  TFCondicoesPagamentos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    DataCondicoesPagamentos: TDataSource;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    Localiza: TConsultaPadrao;
    Painel: TPanelColor;
    wizard: TNotebook;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor4: TDBEditColor;
    PanelColor4: TPanelColor;
    BVoltar: TBitBtn;
    BAvanca: TBitBtn;
    BitBtn4: TBitBtn;
    Label7: TLabel;
    DBEditColor2: TDBEditColor;
    Label3D1: TLabel3D;
    Label3D4: TLabel3D;
    Label3: TLabel;
    DBEditColor6: TDBEditColor;
    Label8: TLabel;
    Label3D3: TLabel3D;
    MovCondicoes: TTable;
    DatamovCondicoes: TDataSource;
    MovCondicoesI_COD_PAG: TIntegerField;
    MovCondicoesI_NRO_PAR: TIntegerField;
    MovCondicoesI_NUM_DIA: TIntegerField;
    MovCondicoesC_CRE_DEB: TStringField;
    MovCondicoesD_DAT_FIX: TDateField;
    MovCondicoesI_DIA_FIX: TIntegerField;
    MovCondicoesN_PER_PAG: TFloatField;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    num: TDBEditColor;
    dias: TDBEditColor;
    dat: TDBEditColor;
    Label3D5: TLabel3D;
    Label3D6: TLabel3D;
    Nropar: TDBText;
    mesmodia: TCheckBox;
    Label16: TLabel;
    MovCondicoesN_PER_CON: TFloatField;
    Label17: TLabel;
    DBText2: TDBText;
    CreDeb: TDBRadioGroup;
    Label13: TLabel;
    Label3D7: TLabel3D;
    StringGrid: TStringGrid;
    datas: TMemoColor;
    BitBtn3: TBitBtn;
    Bevel2: TBevel;
    DBGridColor2: TDBGridColor;
    Bevel4: TBevel;
    CheckBox1: TCheckBox;
    DBEditNumerico1: TDBEditNumerico;
    DBEditNumerico2: TDBEditNumerico;
    Grade: TDBGridColor;
    MovCondicoesN_PER_COM: TFloatField;
    MovCondicoesI_TIP_COM: TIntegerField;
    Label6: TLabel;
    DBEditColor3: TDBEditColor;
    Label18: TLabel;
    DBEditColor5: TDBEditColor;
    DBEditColor7: TDBEditColor;
    Label19: TLabel;
    CadCondicoesPagamentos: TSQL;
    consulta: TLocalizaEdit;
    BFechar: TBitBtn;
    BBAjuda: TBitBtn;
    Label20: TLabel;
    DBFilialColor1: TDBFilialColor;
    MovCondicoesD_ULT_ALT: TDateField;
    CadCondicoesPagamentosI_COD_PAG: TIntegerField;
    CadCondicoesPagamentosC_NOM_PAG: TStringField;
    CadCondicoesPagamentosI_QTD_PAR: TIntegerField;
    CadCondicoesPagamentosI_PRA_MED: TIntegerField;
    CadCondicoesPagamentosD_VAL_CON: TDateField;
    CadCondicoesPagamentosN_IND_REA: TFloatField;
    CadCondicoesPagamentosN_PER_DES: TFloatField;
    CadCondicoesPagamentosI_DIA_CAR: TIntegerField;
    CadCondicoesPagamentosC_GER_CRE: TStringField;
    CadCondicoesPagamentosD_ULT_ALT: TDateField;
    Label4: TLabel;
    Label3D2: TLabel3D;
    Label21: TLabel;
    Label3D8: TLabel3D;
    MovCondicoesN_PER_AJU: TFloatField;
    Label22: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Datainicio: TDBCheckBox;
    MovCondicoesC_DAT_INI: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadCondicoesPagamentosAfterInsert(DataSet: TDataSet);
    procedure BVoltarClick(Sender: TObject);
    procedure BAvancaClick(Sender: TObject);
    procedure numExit(Sender: TObject);
    procedure Habilita;
    procedure diasExit(Sender: TObject);
    procedure numChange(Sender: TObject);
    procedure diasChange(Sender: TObject);
    procedure datChange(Sender: TObject);
    procedure mesmodiaClick(Sender: TObject);
    procedure DBEditColor4Exit(Sender: TObject);
    procedure carregaStringGrid( numeroLinhas : integer);
    procedure StringGridSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBEditColor3Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CadCondicoesPagamentosAfterEdit(DataSet: TDataSet);
    procedure CadCondicoesPagamentosAfterPost(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure CadCondicoesPagamentosBeforePost(DataSet: TDataSet);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure MovCondicoesC_CRE_DEBSetText(Sender: TField;
      const Text: String);
    procedure DBEditColor2Exit(Sender: TObject);
    procedure DBEditColor2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridColor1DblClick(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure wizardPageChanged(Sender: TObject);
    procedure MovCondicoesBeforePost(DataSet: TDataSet);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);

  private
    { Private declarations }
    UnCR : TFuncoesContasAReceber;
    procedure carregaStringGrid1( numLinhas : integer);
    procedure carregaStringGrid2( numLinhas : integer);
  public
    { Public declarations }
  end;

var
  FCondicoesPagamentos: TFCondicoesPagamentos;
  pagina, paginaMin : integer;
  QdadeParcelas, ParcelaAtual : integer;
  SomaPerc : Double;
  data, DataAux : TDateTime;
  DiaAtual : word;
  UsarIndice : Boolean;
implementation

uses APrincipal, FunData, constantes, funsql, funobjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCondicoesPagamentos.FormCreate(Sender: TObject);
begin
   UnCR := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);
   IniciallizaCheckBox( [Datainicio],'S','N');
   CadCondicoesPagamentos.open;  {  abre tabelas }
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   CadCondicoesPagamentos.Filter := 'D_VAL_CON >= ''' + DateToStr(date) + '''';
   MovCondicoes.open;
   pagina := 0;
   Wizard.PageIndex := 0;
   DBFilialColor1.ACodFilial := Varia.CodigoFilCadastro;

   if configmodulos.Academico then
     datainicio.Caption := 'Calcular sobre a data de início da Turma.'
   else
     datainicio.caption := 'Calcular sobre a data de saída da nota fiscal.';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCondicoesPagamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadCondicoesPagamentos.Close; { fecha tabelas }
   MovCondicoes.close;
   UnCR.free;
   Action := CaFree;
end;



procedure TFCondicoesPagamentos.CadCondicoesPagamentosAfterInsert(
  DataSet: TDataSet);
begin
   DBFilialColor1.ProximoCodigo;
   CadCondicoesPagamentosD_VAL_CON.Value := date + 3600;
   CadCondicoesPagamentosN_IND_REA.Value := 0;
   CadCondicoesPagamentosN_PER_DES.Value := 0;
   CadCondicoesPagamentosI_DIA_CAR.Value := 0;
   CadCondicoesPagamentosI_QTD_PAR.Value := 1;
   CadCondicoesPagamentosC_GER_CRE.AsString := 'S';
   paginaMin := 0;
   pagina := 0;
   wizard.PageIndex := 0;
   ParcelaAtual := 1;
   DBEditColor4.ReadOnly := false;
   UsarIndice := false;
   Painel.Visible := true;
   wizardPageChanged(wizard);
   grade.Visible := false;
   dataAux := date;
   Data := date;
   DiaAtual := Dia(date);
   BAvanca.Caption := '&Avançar';
   datas.Lines.Text := 'Exemplo';
   MesmoDia.Checked := false;
   DBEditColor5.Visible :=False;
   Label18.Visible := False;

end;


procedure TFCondicoesPagamentos.carregaStringGrid( numeroLinhas : integer);
var
  laco : integer;
begin
StringGrid.Cells[0,0] := 'Nro Pagamento';
StringGrid.Cells[1,0] := 'Perc. Pagar';
StringGrid.RowCount := numerolinhas + 1;
for laco := 1 to numeroLinhas do
begin
  StringGrid.Cells[0,laco] := IntToStr(laco);
  StringGrid.Cells[1,laco] := FormatFloat('###0.000000',100/numeroLinhas);
end;
end;

procedure TFCondicoesPagamentos.carregaStringGrid1( numLinhas : integer);
var
  laco : integer;
begin
StringGrid1.Cells[0,0] := 'Nro Parcela';
StringGrid1.Cells[1,0] := 'Perc. Pagar';
StringGrid1.RowCount := numlinhas + 1;
for laco := 1 to numLinhas do
begin
  StringGrid1.Cells[0,laco] := IntToStr(laco);
  StringGrid1.Cells[1,laco] := FormatFloat('###0.000000',100/numLinhas);
end;
end;

procedure TFCondicoesPagamentos.carregaStringGrid2( numLinhas : integer);
var
  laco : integer;
begin
StringGrid2.Cells[0,0] := 'Nro Parcela';
StringGrid2.Cells[1,0] := 'Perc. Ajuste';
StringGrid2.RowCount := numlinhas + 1;
for laco := 1 to (numLinhas) do
begin
  StringGrid2.Cells[0,laco] := IntToStr(laco);
  StringGrid2.Cells[1,laco] := FormatFloat('###0.000000',0);
end;
end;


procedure TFCondicoesPagamentos.BVoltarClick(Sender: TObject);
begin
dec(Pagina);
if pagina < paginaMin then
  pagina := paginaMin;
Wizard.PageIndex := pagina
end;


procedure TFCondicoesPagamentos.BAvancaClick(Sender: TObject);
var
  soma : integer;
begin
if CadCondicoesPagamentos.State = dsEdit then
begin
   CadCondicoesPagamentos.Post;
   Painel.Visible := false;
   grade.Visible := false;
end
else
begin
    inc(Pagina);
    if (Wizard.PageIndex = 3) and Usarindice then
    begin
      inc(Pagina);
    end;

    if (Wizard.PageIndex = 3) and (ConfigModulos.Academico) then
    begin
      inc(Pagina);
    end;

    if pagina >= 5 then
      if QdadeParcelas > parcelaAtual then
      begin
         BitBtn3Click(sender);
         Data := dataAux;
         MovCondicoes.Post;
         Inc(ParcelaAtual);
         Mesmodia.Checked := false;
         pagina := 3;
      end;

    if Wizard.PageIndex = 5 then
    begin
      MovCondicoes.First;
      soma := 1;
      while not MovCondicoes.EOF do
      begin
        MovCondicoes.edit;
        MovCondicoesN_PER_PAG.Value := StrToFloat(StringGrid.Cells[1,soma]);
        MovCondicoesN_PER_COM.AsFloat := StrToFloat(StringGrid.Cells[1,soma]);
        MovCondicoesI_TIP_COM.AsInteger := varia.PagamentoComissao;
        MovCondicoes.Post;
        MovCondicoes.Next;
        inc(soma);
      end;
    end;

    if Wizard.PageIndex = 6 then
    begin
      MovCondicoes.First;
      soma := 1;
      while not MovCondicoes.EOF do
      begin
        MovCondicoes.edit;
        MovCondicoesN_PER_COM.AsFloat := StrToFloat(StringGrid1.Cells[1,soma]);
        MovCondicoes.Post;
        MovCondicoes.Next;
        inc(soma);
      end;
    end;

    if Wizard.PageIndex = 7 then
    begin
      MovCondicoes.First;
      soma := 1;
      while not MovCondicoes.EOF do
      begin
        MovCondicoes.edit;
        MovCondicoesN_PER_AJU.AsFloat := StrToFloat(StringGrid2.Cells[1,soma]);
        MovCondicoes.Post;
        MovCondicoes.Next;
        inc(soma);
      end;
    Painel.Visible := false;
    AtualizaSQLTabela(CadCondicoesPagamentos);
    end;

    Wizard.PageIndex := pagina;

    if Wizard.PageIndex = 2 then
    begin
       QdadeParcelas := Strtoint(DBEditColor4.Text);
       carregaStringGrid(QdadeParcelas);
    end;

    if Wizard.PageIndex = 3 then
    begin
     if CadCondicoesPagamentos.State = dsInsert then
        CadCondicoesPagamentos.post;

      MovCondicoes.Insert;
      MovCondicoesI_NRO_PAR.Value := ParcelaAtual;
      MovCondicoesI_NUM_DIA.Value := 0;
      MovCondicoesI_DIA_FIX.Value := 0;
      MovCondicoesN_PER_CON.Value := 0;
      MovCondicoesC_DAT_INI.asString := 'N';
      paginaMin := 3;
      CreDeb.ItemIndex := 0;
    end;

    if Wizard.PageIndex = 6 then
    begin
      QdadeParcelas := Strtoint(DBEditColor4.Text);
      carregaStringGrid1(QdadeParcelas);
    end;

    if Wizard.PageIndex = 7 then
    begin
      BAvanca.Caption := '&Finalizar';
      QdadeParcelas := Strtoint(DBEditColor4.Text);
      carregaStringGrid2(QdadeParcelas);
    end;
end;
end;


procedure TFCondicoesPagamentos.Habilita;
begin
 num.Enabled := true;
 dias.Enabled := true;
 dat.Enabled := true;
end;



procedure TFCondicoesPagamentos.numExit(Sender: TObject);
begin
if num.Text = '' then
  num.Field.Value := 0;
end;

procedure TFCondicoesPagamentos.diasExit(Sender: TObject);
begin
if dias.Text = '' then
  dias.Field.Value := 0;
end;

procedure TFCondicoesPagamentos.numChange(Sender: TObject);
begin
if (num.Text = '0') or (num.Text = '') then
  habilita
else
begin
  dias.Enabled := false;
  dat.Enabled := false;
end;
end;

procedure TFCondicoesPagamentos.diasChange(Sender: TObject);
begin
if (dias.Text = '0') or (dias.Text = '') then
  habilita
else
begin
  num.Enabled := false;
  dat.Enabled := false;
end;

if Dias.Text <> '' then
  if (StrToInt(dias.text) > 28) and (StrToInt(dias.text) <> 100)  then
    dias.text := '';
end;


procedure TFCondicoesPagamentos.datChange(Sender: TObject);
begin
if dat.text[1] = ' ' then
  habilita
else
begin
  dias.Enabled := false;
  num.Enabled := false;
end;
end;




procedure TFCondicoesPagamentos.mesmodiaClick(Sender: TObject);
begin
if mesmodia.Checked then
begin
 num.Enabled := false;
 num.Field.Value := 0;
 dias.Enabled := false;
 dias.Field.Value := 0;
 dat.Enabled := false;
 dat.Field.Value := null;
 Dias.Field.Value := 100;
end
else
begin
  habilita;
  if MovCondicoes.State = dsInsert then
    Dias.Field.Value := 0;
end;
end;

procedure TFCondicoesPagamentos.DBEditColor4Exit(Sender: TObject);
begin
if DBEditColor4.Text = '' then
  DBEditColor4.Field.Value := 1;
end;


procedure TFCondicoesPagamentos.StringGridSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
if (Col = 0) or (row = QdadeParcelas) then
  CanSelect := false;
end;

procedure TFCondicoesPagamentos.StringGridKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in ['0'..'9',',',#8]) then
  key := #
end;

procedure TFCondicoesPagamentos.StringGridSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
var
  laco,soma : integer;
begin
if StringGrid.Cells[1,Arow] <> '' then
begin
  try
    SomaPerc := 0;
    soma := 0;
    for laco := 1 to ARow do
    begin
      SomaPerc := SomaPerc + StrToFloat(StringGrid.Cells[1,laco]);
      inc(soma);
    end;

    for laco := ARow + 1 to QdadeParcelas do
       StringGrid.Cells[1,laco] := FormatFloat('###0.000000' + '00',(100 - SomaPerc)/(QdadeParcelas - soma));
  except
     StringGrid.Cells[1,ARow] := Copy(StringGrid.Cells[1,ARow],0,length(StringGrid.Cells[1,ARow]) - 1);
  end;
end;
end;


procedure TFCondicoesPagamentos.BitBtn3Click(Sender: TObject);
begin
   dataAux := UnCR.CalculaVencimento( data, (data + 60), Num.Field.AsInteger,Dias.Field.AsInteger,dat.Field.AsDateTime, DiaAtual, Datainicio.Checked );
   datas.Lines.Delete(Nropar.Field.AsInteger);
   datas.Lines.Insert(Nropar.Field.AsInteger,DateToStr(dataAux));
end;

procedure TFCondicoesPagamentos.DBEditColor3Exit(Sender: TObject);
begin
   if DBEditNumerico1.Text = '' then
      DBEditNumerico1.Field.Value := 0;
   if DBEditNumerico1.Text <> '0' then
      UsarIndice := true;
end;

procedure TFCondicoesPagamentos.CheckBox1Click(Sender: TObject);
begin
if  CheckBox1.Checked  then
  CadCondicoesPagamentos.Filtered := true
else
  CadCondicoesPagamentos.Filtered := false;
end;

procedure TFCondicoesPagamentos.CadCondicoesPagamentosAfterEdit(
  DataSet: TDataSet);
begin
BVoltar.Visible := false;
BAvanca.Caption := '&Finalizar';
DBEditColor4.ReadOnly := true;
DBFilialColor1.ReadOnly := true;
paginaMin := 0;
pagina := 0;
wizard.PageIndex := 0;
Painel.Visible := true;
Grade.Visible := true;
DBEditColor5.Visible := True;
Label18.Visible := true;
end;

procedure TFCondicoesPagamentos.CadCondicoesPagamentosAfterPost(
  DataSet: TDataSet);
begin
  BVoltar.Visible := true;
  BAvanca.Caption := 'Avançar';
  DBEditColor4.ReadOnly := false;
  DBFilialColor1.ReadOnly := false;
end;

procedure TFCondicoesPagamentos.BitBtn4Click(Sender: TObject);
begin
if (CadCondicoesPagamentos.State = dsInsert) or (CadCondicoesPagamentos.State = dsEdit) then
 CadCondicoesPagamentos.cancel
else
  cadCondicoesPagamentos.delete;
Painel.Visible := false;
end;

procedure TFCondicoesPagamentos.CadCondicoesPagamentosBeforePost(
  DataSet: TDataSet);
begin
  CadCondicoesPagamentosD_ULT_ALT.AsDateTime := Date;
   if CadCondicoesPagamentos.State = dsinsert then
      DBFilialColor1.VerificaCodigoRede;
end;

procedure TFCondicoesPagamentos.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
   DBEditColor1.SetFocus;
end;

procedure TFCondicoesPagamentos.MovCondicoesC_CRE_DEBSetText(
  Sender: TField; const Text: String);
begin
if (text = 'c') or (text =  'C' ) then
  sender.Value := 'C';

if (text = 'd') or (text =  'D' ) then
  sender.Value := 'D';
end;


{******************Força o usuario digitar algo no campo***********************}
procedure TFCondicoesPagamentos.DBEditColor2Exit(Sender: TObject);
begin
   if CadCondicoesPagamentosC_GER_CRE.AsString = '' Then
      CadCondicoesPagamentosC_GER_CRE.AsString := 'S';
end;

{*****************Filtra as teclas pressionadas pelo usuário*******************}
procedure TFCondicoesPagamentos.DBEditColor2KeyPress(Sender: TObject;
  var Key: Char);
begin
   if not(key in['S','N','s','n',#8]) Then
      key := #;
end;

{************************Altera a condição de pagamento************************}
procedure TFCondicoesPagamentos.DBGridColor1DblClick(Sender: TObject);
begin
  BotaoAlterar1.Click;
end;

procedure TFCondicoesPagamentos.DBGridColor1Ordem(Ordem: String);
begin
consulta.AOrdem := ordem;
end;

procedure TFCondicoesPagamentos.BFecharClick(Sender: TObject);
begin
self.close;
end;

procedure TFCondicoesPagamentos.BBAjudaClick(Sender: TObject);
begin
  if Painel.Visible then
    application.HelpCommand(HELP_CONTEXT, wizard.HelpContext)
  else
    application.HelpCommand(HELP_CONTEXT, FCondicoesPagamentos.HelpContext);
end;

procedure TFCondicoesPagamentos.wizardPageChanged(Sender: TObject);
begin
  if (Painel.Visible=False) then
  begin
     FCondicoesPagamentos.HelpContext := 1012;
  end
  else
  begin
     case Wizard.PageIndex of
       0 : wizard.HelpContext := 1016;
       1 : wizard.HelpContext := 1013;
       2 : wizard.HelpContext := 1014;
       3 : wizard.HelpContext := 1015;
       4 : wizard.HelpContext := 1017;
       5 : wizard.HelpContext := 1018;
       6 : wizard.HelpContext := 1019;
       7 : wizard.HelpContext := 1020;
     end;
  end;
end;

{******************* antes de gravar o registro *******************************}
procedure TFCondicoesPagamentos.MovCondicoesBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  MovCondicoesD_ULT_ALT.AsDateTime := Date;
end;


procedure TFCondicoesPagamentos.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
var
  laco,soma : integer;
begin
if StringGrid1.Cells[1,Arow] <> '' then
begin
  try
    SomaPerc := 0;
    soma := 0;
    for laco := 1 to ARow do
    begin
      SomaPerc := SomaPerc + StrToFloat(StringGrid1.Cells[1,laco]);
      inc(soma);
    end;

    for laco := ARow + 1 to QdadeParcelas do
       StringGrid1.Cells[1,laco] := FormatFloat('###0.000000' + '00',(100 - SomaPerc)/(QdadeParcelas - soma));
  except
     StringGrid1.Cells[1,ARow] := Copy(StringGrid1.Cells[1,ARow],0,length(StringGrid1.Cells[1,ARow]) - 1);
  end;
end;
end;



procedure TFCondicoesPagamentos.StringGrid2SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
var
  laco, soma : integer;

begin
if StringGrid2.Cells[1,Arow] <> '' then
begin
  try
    soma := 0;
    for laco := 1 to (ARow) do
    begin
      StringGrid2.Cells[1,laco];
      inc(soma);
    end;

  except
     StringGrid2.Cells[1,ARow] := Copy(StringGrid2.Cells[1,ARow],0,length(StringGrid2.Cells[1,ARow])- 1);
  end;
end;
end;

procedure TFCondicoesPagamentos.StringGrid2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['-','+','0'..'9',',',#8]) then
  key := #
end;

procedure TFCondicoesPagamentos.StringGrid2SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = 0) or (Arow > QdadeParcelas) then
    CanSelect := false;
end;

Initialization
 RegisterClasses([TFCondicoesPagamentos]);
end.
