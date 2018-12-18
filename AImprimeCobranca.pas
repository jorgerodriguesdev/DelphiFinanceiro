unit AImprimeCobranca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, DBGrids,
  Tabela, StdCtrls, Mask, numericos, Buttons, UCrpe32, ComCtrls,
  Localizacao;

type
  TFImprimeCobranca = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label20: TLabel;
    PanelColor3: TPanelColor;
    DBGridColor1: TDBGridColor;
    BFechar: TBitBtn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GradeContas: TListBoxColor;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    Contas: TQuery;
    DsContas: TDataSource;
    ContasI_EMP_FIL: TIntegerField;
    ContasI_LAN_REC: TIntegerField;
    ContasI_COD_CLI: TIntegerField;
    ContasD_DAT_MOV: TDateField;
    ContasI_QTD_PAR: TIntegerField;
    ContasN_VLR_TOT: TFloatField;
    ContasD_DAT_EMI: TDateField;
    ContasI_SEQ_NOT: TIntegerField;
    ContasI_NRO_NOT: TIntegerField;
    ContasI_NRO_PAR: TIntegerField;
    ContasN_VLR_PAR: TFloatField;
    ContasN_VLR_PAG: TFloatField;
    ContasD_DAT_PAG: TDateField;
    ContasD_DAT_VEN: TDateField;
    ContasN_TOT_PAR: TFloatField;
    ContasC_NRO_DUP: TStringField;
    ContasC_NOM_CLI: TStringField;
    Data1: TCalendario;
    Data2: TCalendario;
    Flag: TComboBoxColor;
    Label2: TLabel;
    Label3: TLabel;
    Procurador: TConsultaPadrao;
    EditLan: TEditColor;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure EVendedorRetorno(Retorno1, Retorno2: String);
    procedure FlagChange(Sender: TObject);
  private
    rel : TCrpe;
    Sql : TStringList;
    function GeraTextoLancamentos : string;
    procedure CarregaContas;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

  type
    TDadoCR = class
      Seqconta : integer;
      NroParcela : integer;
    end;

var
  FImprimeCobranca: TFImprimeCobranca;

implementation

uses APrincipal, funsql, constantes, Fundata, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCobranca.FormCreate(Sender: TObject);
begin
  sql := TStringList.create;
  Sql.Clear;;
  Flag.ItemIndex := 0;
  Data1.Date := PrimeiroDiaMes(Date);
  Data2.Date := UltimoDiaMes(Date);
  CarregaContas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCobranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  rel.free;
  Contas.close;
  Action := CaFree;
end;

procedure TFImprimeCobranca.CarregaContas;
begin
    Contas.close;
    Contas.SQL.Clear;
    Contas.SQL.Add(' select CAD.I_EMP_FIL,CAD.I_LAN_REC, CAD.I_COD_CLI, ' +
                   ' CAD.D_DAT_MOV,CAD.I_QTD_PAR,CAD.N_VLR_TOT,CAD.D_DAT_EMI, ' +
                   ' CAD.I_SEQ_NOT, CAD.I_NRO_NOT, ' +
                   ' MOV.I_EMP_FIL,MOV.I_NRO_PAR,MOV.N_VLR_PAR, MOV.N_VLR_PAG, ' +
                   ' MOV.I_LAN_REC, MOV.D_DAT_PAG, MOV.D_DAT_VEN, MOV.N_TOT_PAR, MOV.C_NRO_DUP, ' +
                   ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CAD.I_NRO_NOT ' +
                   ' FROM  ' +
                   ' CADCONTASARECEBER  AS CAD, ' +
                   ' MOVCONTASARECEBER AS MOV, ' +
                   ' CADCLIENTES AS CLI ' );
    AdicionaFiltros(Contas.SQL);
    Contas.SQL.Add(' AND MOV.I_LAN_REC = CAD.I_LAN_REC  ' +
                   ' AND MOV.I_EMP_FIL =  CAD.I_EMP_FIL ' +
                   ' AND CAD.I_COD_CLI = CLI.I_COD_CLI  ' );
  abreTabela(Contas);
end;

procedure TFImprimeCobranca.AdicionaFiltros(VpaSelect : TStrings);
begin
    VpaSelect.Add(' Where Cad.I_EMP_FIl = '+ IntToStr (Varia.CodigoEmpFil)+
                  ' and mov.d_dat_pag is null '  );

    if GeraTextoLancamentos <> '' then
      VpaSelect.Add(' and cad.i_lan_rec not in ( ' + GeraTextoLancamentos + ')');

    if EditLan.Text <> '' then
      VpaSelect.add(' and Cad.I_LAN_REC = '''+ EditLan.Text + '''')
    else
      VpaSelect.add(' ');


    case Flag.ItemIndex of
      0 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN', Data1.Date,Data2.Date, true  ));
      1 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_EMI', Data1.Date,Data2.Date, true  ));
    end;
end;


function  TFImprimeCobranca.GeraTextoLancamentos : string;
var
  laco : integer;
begin
 result := '';
 for laco := 0 to GradeContas.Items.Count - 1 do
 begin
   if laco <> 0 then
     result := result + ',';
   result := result + Inttostr(TDadoCR(GradeContas.Items.Objects[Laco]).SeqConta);
 end;
end;

procedure TFImprimeCobranca.BitBtn1Click(Sender: TObject);
begin
  CarregaContas;
end;

procedure TFImprimeCobranca.BFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TFImprimeCobranca.SpeedButton1Click(Sender: TObject);
var
  Dados : TDadoCR;
begin
  if not Contas.Eof then
  begin
    Dados := TDadoCR.Create;
    Dados.SeqConta := Contas.fieldbyname('i_lan_rec').AsInteger;
    Dados.NroParcela := Contas.fieldbyname('i_nro_par').AsInteger;

    GradeContas.Items.AddObject(Contas.fieldbyname('i_lAN_REC').AsString +
                            ' - ' + Contas.fieldbyname('c_nom_cli').AsString,dados);
    CarregaContas;
  end;
end;

procedure TFImprimeCobranca.SpeedButton2Click(Sender: TObject);
begin
  if GradeContas.Items.Count <> 0 then
     GradeContas.Items.Delete(GradeContas.ItemIndex);
  CarregaContas;
end;

procedure TFImprimeCobranca.BitBtn3Click(Sender: TObject);
var
  laco : integer;
  Inicio, fim : String;
begin
  if rel <> nil then
    rel.free;

  rel := TCrpe.Create(self);
  rel.ReportName := varia.PathRel + 'diverso\CobrancaContasaReceber.rpt';
  rel.Connect.Retrieve;
  rel.Connect.DatabaseName := varia.AliasBAseDados;
  rel.Connect.ServerName := varia.AliasRelatorio;
  rel.WindowState := wsMaximized;

 rel.ParamFields.Retrieve;
 rel.ParamFields[0].Value := IntToStr(Varia.CodigoEmpFil);
 rel.SQL.Query.Clear;
 rel.SQL.Retrieve;
 if sql.Count < 2 then
   sql := Rel.sql.Query
 else
 begin
   rel.SQL.Query.Clear;
   Rel.sql.Query.Assign(sql);
 end;

 for laco := 0 to GradeContas.Items.Count - 1 do
 begin
   if laco = 0 then
     inicio := ' where ( '
   else
     inicio := ' or ';
   fim := '';
   if laco = GradeContas.Items.Count - 1 then
     fim := ' ) ';

   rel.SQL.Query.Insert(10 + laco,inicio + '( MovContasaReceber."I_EMP_FIL" = ' + inttostr(varia.CodigoEmpFil) +
                           ' and MovContasaReceber."I_LAN_REC" = ' +
                           Inttostr(TDadoCR(GradeContas.Items.Objects[Laco]).SeqConta) +
                           ' and MOVContasaReceber."I_NRO_PAR" = ' +
                           Inttostr(TDadoCR(GradeContas.Items.Objects[Laco]).NroParcela) + ')' +
                           fim);
 end;
 rel.execute;
end;

procedure TFImprimeCobranca.EVendedorRetorno(Retorno1, Retorno2: String);
begin
  CarregaContas;
end;

procedure TFImprimeCobranca.FlagChange(Sender: TObject);
begin
  CarregaContas;
end;

Initialization
 RegisterClasses([TFImprimeCobranca]);
end.
