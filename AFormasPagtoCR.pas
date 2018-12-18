unit AFormasPagtoCR;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls,
  Localizacao, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, Mask,
  DBCtrls;

type
  TFFormasPagtoCR = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Cheques: TQuery;
    DataCheques: TDataSource;
    ChequesI_NRO_NOT: TIntegerField;
    ChequesI_NRO_PAR: TIntegerField;
    ChequesC_NRO_DUP: TStringField;
    ChequesD_DAT_PAG: TDateField;
    ChequesN_VLR_PAG: TFloatField;
    ChequesC_NOM_CLI: TStringField;
    ChequesC_NOM_PLA: TStringField;
    ChequesC_CLA_PLA: TStringField;
    ChequesI_SEQ_NOT: TIntegerField;
    ChequesI_COD_CLI: TIntegerField;
    ChequesD_DAT_VEN: TDateField;
    ChequesD_DAT_EMI: TDateField;
    ChequesC_CLA_PLA_1: TStringField;
    ChequesI_COD_FRM: TIntegerField;
    FormaPagamento: TQuery;
    ChequesI_LAN_REC: TIntegerField;
    ChequesN_VLR_PAR: TFloatField;
    PanelColor3: TPanelColor;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    EditLocaliza4: TEditLocaliza;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    FormaPagto: TEditLocaliza;
    GridIndice1: TGridIndice;
    ChequesI_COD_MAT: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure FormaPagtoRetorno(Retorno1, Retorno2: String);
    procedure dataParcela2CloseUp(Sender: TObject);
    procedure MovChequesAfterInsert(DataSet: TDataSet);
  private
    TipoFrm : string;
    procedure AbreConsulta;
  public
    { Public declarations }
  end;

var
  FFormasPagtoCR: TFFormasPagtoCR;

implementation

uses APrincipal, funsql, fundata,  Constantes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFFormasPagtoCR.FormCreate(Sender: TObject);
begin
//  LabelNome1.ANroNome := varia.TipoNome;
   if ConfigModulos.Academico then
   begin
     EditLocaliza4.AInfo.TituloForm := ' Localiza Aluno ';
     GridIndice1.Columns[1].Title.Caption := 'Aluno';
     GridIndice1.Columns[2].FieldName := 'i_cod_mat';
     GridIndice1.Columns[2].Title.Caption := 'Contr [+]';
   end;
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  AbreConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormasPagtoCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Cheques.close;
 FormaPagamento.close;
 Action := CaFree;
end;

procedure TFFormasPagtoCR.BFecharClick(Sender: TObject);
begin
  Self.close;
end;


procedure TFFormasPagtoCR.AbreConsulta;
begin
  LimpaSQLTabela(Cheques);
  InseriLinhaSQL(Cheques, 0, ' select CP.I_COD_MAT, ' );
  InseriLinhaSQL(Cheques, 1, ' CP.I_LAN_REC, CP.C_CLA_PLA, CP.I_SEQ_NOT, ' +
                             ' CP.I_COD_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR, ' +
                             ' MCP.C_NRO_DUP, MCP.D_DAT_VEN, CP.D_DAT_EMI, ' +
                             ' MCP.N_VLR_PAR, MCP.D_DAT_PAG, ' +
                             ' MCP.N_VLR_PAG, MCP.I_COD_FRM, ' +
                             ' C.C_NOM_CLI, P.C_CLA_PLA, P.C_NOM_PLA ' );
  InseriLinhaSQL(Cheques, 2, ' from ' +
                             ' MovContasAReceber as MCP, ' +
                             ' CadContasAReceber as CP, ' +
                             ' CadClientes as C, '+
                             ' Cad_PLANO_CONTA as P ' +
                             ' where ' );
  InseriLinhaSQL(Cheques, 3, SQLTextoDataEntreAAAAMMDD('MCP.D_DAT_PAG',
                             DataParcela1.Date, DataParcela2.Date, false) +
                             ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''' );
  if FormaPagto.Text <> '' then
    InseriLinhaSQL(Cheques, 4, ' and MCP.I_COD_FRM = ' + FormaPagto.Text )
  else
    InseriLinhaSQL(Cheques, 4, ' ');
  if EditLocaliza4.Text <> '' then
    InseriLinhaSQL(Cheques, 5, ' and CP.I_COD_CLI = ' +  EditLocaliza4.Text )
  else
    InseriLinhaSQL(Cheques, 5, ' ');
  InseriLinhaSQL(Cheques, 6, ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                             ' and CP.I_LAN_REC = MCP.I_LAN_REC ' +
                             ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                             ' and CP.C_CLA_PLA = P.C_CLA_PLA ' );
  ImprimeSqlArq(cheques, 'c:\x\che.sq;');
  Cheques.open;
end;

procedure TFFormasPagtoCR.FormaPagtoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    TipoFrm := Retorno1;
    AbreConsulta;
  end;
end;

procedure TFFormasPagtoCR.dataParcela2CloseUp(Sender: TObject);
begin
  AbreConsulta;
end;




procedure TFFormasPagtoCR.MovChequesAfterInsert(DataSet: TDataSet);
begin
  Abort;
end;



Initialization
  RegisterClasses([TFFormasPagtoCR]);
end.
