unit AFormasPagtoCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls,
  Localizacao, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, Mask,
  DBCtrls;

type
  TFFormasPatgoCP = class(TFormularioPermissao)
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
    ChequesI_LAN_APG: TIntegerField;
    ChequesC_CLA_PLA: TStringField;
    ChequesI_SEQ_NOT: TIntegerField;
    ChequesI_COD_CLI: TIntegerField;
    ChequesD_DAT_VEN: TDateField;
    ChequesD_DAT_EMI: TDateField;
    ChequesN_VLR_DUP: TFloatField;
    ChequesC_CLA_PLA_1: TStringField;
    ChequesI_COD_FRM: TIntegerField;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PagamentoTab: TTabSheet;
    TerceirosTab: TTabSheet;
    GridIndice1: TGridIndice;
    PanelColor3: TPanelColor;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    EditLocaliza4: TEditLocaliza;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    FormaPagto: TEditLocaliza;
    BTerceiros: TBitBtn;
    Label2: TLabel;
    MovCheques: TQuery;
    MovChequesNomeForma: TStringField;
    MovChequesI_SEQ_TER: TIntegerField;
    MovChequesI_COD_BAN: TIntegerField;
    MovChequesI_COD_FRM: TIntegerField;
    MovChequesI_FIL_APG: TIntegerField;
    MovChequesI_LAN_APG: TIntegerField;
    MovChequesI_PAR_APG: TIntegerField;
    MovChequesI_FIL_REC: TIntegerField;
    MovChequesI_LAN_REC: TIntegerField;
    MovChequesI_PAR_REC: TIntegerField;
    MovChequesC_EMI_CHE: TStringField;
    MovChequesC_NRO_CHE: TStringField;
    MovChequesD_DAT_COM: TDateField;
    MovChequesD_DAT_CAD: TDateField;
    MovChequesN_VLR_CHE: TFloatField;
    MovChequesC_CHE_DEV: TStringField;
    DataMovCheques: TDataSource;
    FormaPagamento: TQuery;
    Grade: TDBGridColor;
    PanelColor4: TPanelColor;
    Label3: TLabel;
    DataTerceiroFim: TCalendario;
    DataTerceiroIni: TCalendario;
    CPeriodoPor: TComboBoxColor;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label19: TLabel;
    EBanco: TEditLocaliza;
    LBanco: TLabel;
    Label5: TLabel;
    ENroCheque: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure FormaPagtoRetorno(Retorno1, Retorno2: String);
    procedure dataParcela2CloseUp(Sender: TObject);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENroChequeSelect(Sender: TObject);
    procedure EBancoChange(Sender: TObject);
    procedure ENroChequeChange(Sender: TObject);
    procedure GradeExit(Sender: TObject);
    procedure MovChequesAfterInsert(DataSet: TDataSet);
    procedure PaginasChange(Sender: TObject);
    procedure AbreMovCheques(Lancamento, Parcela: Integer);    
  private
    TipoFrm : string;
    procedure AbreConsulta;
    procedure PosicionaTerceiros;
  public
    { Public declarations }
  end;

var
  FFormasPatgoCP: TFFormasPatgoCP;

implementation

uses APrincipal, funsql, fundata,  Constantes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFFormasPatgoCP.FormCreate(Sender: TObject);
begin
  Paginas.ActivePage := PagamentoTab;
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  DataTerceiroIni.Date := PrimeiroDiaMes(date);
  DataTerceiroFim.Date := UltimoDiaMes(date);
  CPeriodoPor.ItemIndex := 0;
  AbreConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormasPatgoCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Cheques.close;
 MovCheques.close;
 FormaPagamento.close;
 Action := CaFree;
end;

procedure TFFormasPatgoCP.BFecharClick(Sender: TObject);
begin
  Self.close;
end;

procedure TFFormasPatgoCP.PosicionaTerceiros;
begin
  LimpaSQLTabela(MovCheques);
  InseriLinhaSQL(MovCheques, 0, ' select * from movchequeterceiro WHERE ' );
  if (CPeriodoPor.ItemIndex = 0) then
    // Compensação.
    InseriLinhaSQL(MovCheques, 1, SQLTextoDataEntreAAAAMMDD('D_DAT_COM',
                                  DataTerceiroIni.Date, DataTerceiroFim.Date, false))
    // Cadastro.
  else
    InseriLinhaSQL(MovCheques, 1, SQLTextoDataEntreAAAAMMDD('D_DAT_CAD',
                                  DataTerceiroIni.Date, DataTerceiroFim.Date, false));
  if (EBanco.Text <> '') then
    InseriLinhaSQL(MovCheques, 2, ' and I_COD_BAN = ' + EBanco.Text)
  else
    InseriLinhaSQL(MovCheques, 2, ' ');
  if (ENroCheque.Text <> '') then
    InseriLinhaSQL(MovCheques, 3, ' and C_NRO_CHE = ''' + ENroCheque.Text + '''')
  else
    InseriLinhaSQL(MovCheques, 3, ' ');
  ImprimeSqlArq(MovCheques, 'C:\TEMP\TEMP.SQL');
  AbreTabela(MovCheques);
end;

procedure TFFormasPatgoCP.AbreConsulta;
begin
  LimpaSQLTabela(Cheques);
  InseriLinhaSQL(Cheques, 0, ' select ' );
  InseriLinhaSQL(Cheques, 1, ' CP.I_LAN_APG, CP.C_CLA_PLA, CP.I_SEQ_NOT, ' +
                             ' CP.I_COD_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR, ' +
                             ' MCP.C_NRO_DUP, MCP.D_DAT_VEN, CP.D_DAT_EMI, ' +
                             ' MCP.N_VLR_DUP, MCP.D_DAT_PAG, ' +
                             ' MCP.N_VLR_PAG,MCP.I_COD_FRM, ' +
                             ' C.C_NOM_CLI, P.C_CLA_PLA, P.C_NOM_PLA ' );
  InseriLinhaSQL(Cheques, 2, ' from ' +
                             ' MovContasapagar as MCP, ' +
                             ' CadContasaPagar as CP, ' +
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
                             ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                             ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                             ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                             ' and CP.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));  Cheques.open;
end;

procedure TFFormasPatgoCP.FormaPagtoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    TipoFrm := Retorno1;
    if Retorno1 = 'R' then  // cheques de terceiros
    begin
      BTerceiros.Enabled := true;
      TerceirosTab.TabVisible := true;
    end
    else
    begin
      BTerceiros.Enabled := false;
      TerceirosTab.TabVisible := false;
    end;
  end
  else
  begin
    BTerceiros.Enabled := true;
    TerceirosTab.TabVisible := true;
  end;
  AbreConsulta;
end;

procedure TFFormasPatgoCP.dataParcela2CloseUp(Sender: TObject);
begin
  AbreConsulta;
end;

procedure TFFormasPatgoCP.GridIndice1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 115) and (TipoFrm = 'R') then
    BTerceiros.Click;
end;

procedure TFFormasPatgoCP.ENroChequeSelect(Sender: TObject);
begin
  ENroCheque.ASelectLocaliza.Clear;
  ENroCheque.ASelectLocaliza.Add(
  ' select * from movchequeterceiro ' +
  ' where  C_NRO_CHE  like ''@%'' ');
  if (EBanco.Text <> '') then
    ENroCheque.ASelectLocaliza.Add(' AND I_COD_BAN = ' + EBanco.Text);
  ENroCheque.ASelectValida.Clear;
  ENroCheque.ASelectValida.Add(
  ' select * from movchequeterceiro ' +
  ' where  C_NRO_CHE = ''@'' ');
  if (EBanco.Text <> '') then
    ENroCheque.ASelectValida.Add(' AND I_COD_BAN = ' + EBanco.Text);
end;

procedure TFFormasPatgoCP.EBancoChange(Sender: TObject);
begin
  // Limpa o cheque.
  ENroCheque.Clear;
  PosicionaTerceiros;
end;

procedure TFFormasPatgoCP.ENroChequeChange(Sender: TObject);
begin
  PosicionaTerceiros;
end;

procedure TFFormasPatgoCP.GradeExit(Sender: TObject);
begin
  if (MovCheques.State = dsEdit) then
    MovCheques.Post;
end;

procedure TFFormasPatgoCP.MovChequesAfterInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFFormasPatgoCP.PaginasChange(Sender: TObject);
begin
  if not Cheques.EOF then
    if Paginas.ActivePage = TerceirosTab then
    begin
      EBanco.Clear;
      EBanco.Atualiza;
      ENroCheque.Clear;
      ENroCheque.Atualiza;
      AbreMovCheques(ChequesI_LAN_APG.AsInteger, ChequesI_NRO_PAR.AsInteger);
    end;  
end;

{************************* Abre o movimento de cheques *********************** }
procedure TFFormasPatgoCP.AbreMovCheques(Lancamento, Parcela: Integer);
begin
  AdicionaSQLAbreTabela(MovCheques,
    ' select * from movchequeterceiro ' +
    ' where i_lan_apg = ' + IntTostr(Lancamento) +
    ' and i_fil_apg = ' + IntTostr(Varia.CodigoEmpFil ) +
    ' and i_par_apg = ' + IntTostr(Parcela));
end;

Initialization
  RegisterClasses([TFFormasPatgoCP]);
end.
