unit AContasAReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList, numericos, UnContasAReceber, DBCGrids;

type
  TFContasaReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    CadNotas: TQuery;
    DataCadNotas: TDataSource;
    BotaoCadastrar1: TBitBtn;
    BitBtn1: TBitBtn;
    DataMovcontasapagar: TDataSource;
    BPagamento: TBitBtn;
    Aux: TQuery;
    Localiza: TConsultaPadrao;
    MovNotas: TQuery;
    Paginas: TPageControl;
    TabNotas: TTabSheet;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    Label6: TLabel;
    Splitter1: TSplitter;
    GradeParcelas1: TDBGridColor;
    TabParcelas: TTabSheet;
    PanelColor3: TPanelColor;
    DBMemoColor2: TDBMemoColor;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    MovNotasI_EMP_FIL: TIntegerField;
    MovNotasI_NRO_PAR: TIntegerField;
    MovNotasD_DAT_VEN: TDateField;
    MovNotasD_DAT_PAG: TDateField;
    MovNotasN_PER_JUR: TFloatField;
    MovNotasN_VLR_DES: TFloatField;
    MovNotasN_VLR_PAG: TFloatField;
    MovNotasN_PER_MOR: TFloatField;
    MovNotasN_VLR_ACR: TFloatField;
    PanelColor4: TPanelColor;
    Label15: TLabel;
    Label20: TLabel;
    Indice1: TIndiceGrid;
    Label24: TLabel;
    Label25: TLabel;
    Indice2: TIndiceGrid;
    Label16: TLabel;
    Label21: TLabel;
    Filtro: TCheckBox;
    tempo: TPainelTempo;
    Panel1: TPanel;
    DBMemoColor1: TDBMemoColor;
    BNGraficoNota: TBitBtn;
    FotoNotas: TBitBtn;
    Label11: TLabel;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    dataNota1: TCalendario;
    DataNota2: TCalendario;
    EditLocaliza4: TEditLocaliza;
    EditLocaliza5: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    EditLocaliza7: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    EditLocaliza8: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    MovNotasI_LAN_REC: TIntegerField;
    MovNotasN_VLR_PAR: TFloatField;
    MovNotasN_PER_COR: TFloatField;
    Detalhes: TComponenteMove;
    Label50: TLabel;
    PanelColor5: TPanelColor;
    Label49: TLabel;
    DBText27: TDBText;
    Label29: TLabel;
    DBText8: TDBText;
    Label30: TLabel;
    DBText7: TDBText;
    Label31: TLabel;
    DBText9: TDBText;
    Label32: TLabel;
    DBText10: TDBText;
    Label33: TLabel;
    DBText11: TDBText;
    Label34: TLabel;
    DBText12: TDBText;
    Label35: TLabel;
    Label36: TLabel;
    DBText14: TDBText;
    Label39: TLabel;
    DBText17: TDBText;
    Label40: TLabel;
    DBText18: TDBText;
    Label41: TLabel;
    DBText19: TDBText;
    Label42: TLabel;
    DBText20: TDBText;
    Label43: TLabel;
    DBText21: TDBText;
    Label44: TLabel;
    DBText22: TDBText;
    Label45: TLabel;
    DBText23: TDBText;
    Label48: TLabel;
    BitBtn2: TBitBtn;
    DBText13: TDBText;
    Label37: TLabel;
    DBText15: TDBText;
    MovNotasC_NRO_DUP: TStringField;
    SpeedButton9: TSpeedButton;
    MovParcelasI_LAN_REC: TIntegerField;
    MovParcelasL_OBS_REC: TMemoField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_PAR: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NOM_CLI: TStringField;
    MovParcelasC_NOM_FAN: TStringField;
    MovParcelasI_SEQ_NOT: TIntegerField;
    MovParcelasN_PER_DES: TFloatField;
    MovParcelasC_NOM_PAG: TStringField;
    MovParcelasC_NOM_FRM: TStringField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasN_DES_VEN: TFloatField;
    MovParcelasn_PER_MUL: TFloatField;
    MovParcelasn_PER_JUR: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_PER_MOR: TFloatField;
    CadNotasI_EMP_FIL: TIntegerField;
    CadNotasI_LAN_REC: TIntegerField;
    CadNotasN_VLR_TOT: TFloatField;
    CadNotasI_NRO_NOT: TIntegerField;
    CadNotasD_DAT_EMI: TDateField;
    CadNotasD_DAT_MOV: TDateField;
    CadNotasC_NOM_CLI: TStringField;
    ImageList1: TImageList;
    Label13: TLabel;
    DBText3: TDBText;
    Label12: TLabel;
    DBText2: TDBText;
    MovParcelasD_DAT_EMI: TDateField;
    MovNotasL_OBS_REC: TMemoField;
    MovParcelasC_NOM_MOE: TStringField;
    DBText1: TDBText;
    MovNotasN_PER_MUL: TFloatField;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    CadNotasI_SEQ_NOT: TIntegerField;
    Label3: TLabel;
    DBText4: TDBText;
    Label9: TLabel;
    DBText5: TDBText;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    EPlano: TEditColor;
    Label17: TLabel;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasC_NOM_PLA: TStringField;
    CadNotasC_NOM_PLA: TStringField;
    Label1: TLabel;
    EPlanoGeral: TEditColor;
    SpeedButton2: TSpeedButton;
    LPlanoGeral: TLabel;
    BProdutos: TBitBtn;
    BBAjuda: TBitBtn;
    TotalAberto: Tnumerico;
    numerico2: Tnumerico;
    SitPar: TComboBoxColor;
    RPeriodo: TComboBoxColor;
    MovParcelasD_DAT_MOV: TDateField;
    Label14: TLabel;
    Label19: TLabel;
    BComissoes: TBitBtn;
    numerico3: Tnumerico;
    Label26: TLabel;
    BGraficos: TBitBtn;
    BImprimir: TBitBtn;
    BitBtn9: TBitBtn;
    ToolBar1: TToolBar;
    ExZoom: TToolButton;
    BAlterar: TBitBtn;
    Label27: TLabel;
    EdcFormaPgto: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    Label23: TLabel;
    Label38: TLabel;
    numerico1: Tnumerico;
    MovParcelasI_EMP_FIL: TIntegerField;
    Formas: TQuery;
    DataFormas: TDataSource;
    ScrollBox1: TScrollBox;
    GFormas: TDBCtrlGrid;
    Label2: TLabel;
    DBText6: TDBText;
    Label22: TLabel;
    DBText16: TDBText;
    Label46: TLabel;
    DBText24: TDBText;
    Label47: TLabel;
    DBText25: TDBText;
    Label51: TLabel;
    DBText26: TDBText;
    Label52: TLabel;
    DBText28: TDBText;
    FormasC_NRO_CON: TStringField;
    FormasD_CHE_VEN: TDateField;
    FormasN_VLR_MOV: TFloatField;
    FormasC_NOM_FRM: TStringField;
    FormasC_NOM_BAN: TStringField;
    FormasC_NRO_DOC: TStringField;
    MovParcelasI_COD_MAT: TIntegerField;
    CadNotasI_COD_MAT: TIntegerField;
    Label18: TLabel;
    DBText29: TDBText;
    CadNotasC_CLA_PLA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure CadNotasAfterScroll(DataSet: TDataSet);
    procedure TipoDataNotaChange(Sender: TObject);
    procedure DataNota1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TipoDataParcelaChange(Sender: TObject);
    procedure DataParcela1Change(Sender: TObject);
    procedure GradeNota1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeNota1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaginasChange(Sender: TObject);
    procedure SitParClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FiltroClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure CarregaVariaveisGrafico;
    procedure EditLocaliza1FimConsulta(Sender: TObject);
    procedure EditLocaliza5Select(Sender: TObject);
    procedure EditLocaliza6FimConsulta(Sender: TObject);
    procedure gradeParcelas2DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure gradeParcelas2KeyPress(Sender: TObject; var Key: Char);
    procedure EditLocaliza5Exit(Sender: TObject);
    procedure ExZoomClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoGeralExit(Sender: TObject);
    procedure MovParcelasAfterScroll(DataSet: TDataSet);
    procedure BComissoesClick(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure EditLocaliza4Select(Sender: TObject);
    procedure EditLocaliza5Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditLocaliza5Retorno(Retorno1, Retorno2: String);
  private
    TeclaPresionada : Boolean;
    SomenteUmaNota : Boolean;
    CR : TCalculosContasAReceber;
    procedure executaNotaPai;
    procedure executaNotaFilho;
    procedure executaParcelaPai;
    procedure VerificaBotoes( estado : Boolean );
    procedure AtualizaDados;
    procedure MostraFormas;
  public
    { Public declarations }
  end;

var
  FContasaReceber: TFContasaReceber;

implementation

uses fundata, APrincipal, constmsg, ANovoContasaReceber, ABaixaContasReceber,
   AGraficosContasaReceber, AImprimeCR, AManutencaoCR, funsql, APlanoConta,
  AMovComissoes, AVizualizaNotaFiscal, AVisualizaCupomFiscal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContasaReceber.FormCreate(Sender: TObject);
begin
   if ConfigModulos.Academico then
   begin
     GridIndice1.Columns[3].FieldName := 'i_cod_mat';
     GridIndice1.Columns[3].Title.Caption := 'Contr [+]';
     GridIndice1.AListaCAmpos.Delete(2);
     GridIndice1.AListaCAmpos.Insert(2, 'I_COD_MAT');
     GridIndice1.Columns[2].Title.Caption := 'Aluno';
     GridIndice2.Columns[1].FieldName := 'i_cod_mat';
     GridIndice2.Columns[1].Title.Caption := 'Contr [+]';
     GridIndice2.AListaCAmpos.Delete(1);
     GridIndice2.AListaCAmpos.Insert(1, 'I_COD_MAT');
     GridIndice2.Columns[3].Title.Caption := 'Aluno';
     EditLocaliza4.AInfo.TituloForm := ' Localiza Aluno '
   end;
//   LabelNome1.ANroNome := varia.TipoNome;
   EditLocaliza5.APermitirVazio := varia.FilialUsuario = '';
   SitPar.ItemIndex := 5;
   RPeriodo.ItemIndex := 0;
   DataParcela1.Date := PrimeiroDiaMes(date);
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   DataParcela2.Date := UltimoDiaMes(date);
   DataNota1.Date := DataParcela1.Date;
   DataNota2.Date := DataParcela2.Date;
   TeclaPresionada := true;
   SomenteUmaNota := false;
   CR := TCalculosContasAReceber.criar(self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContasaReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(CadNotas);
   FechaTabela(MovNotas);
   FechaTabela(MovParcelas);
   aux.close;
   Formas.close;
   CR.Free;
   Action := CaFree;
end;

{********************Quando o formulario é mostrado****************************}
procedure TFContasaReceber.FormShow(Sender: TObject);
begin
  Paginas.ActivePage := TabParcelas;
  EditLocaliza5.Text := IntToStr(varia.CodigoEmpFil);
  Label25.Caption := varia.nomeFilial;
  EditLocaliza8.Text := IntToStr(varia.CodigoEmpFil);
  Label21.Caption := varia.nomeFilial;
  ExecutaParcelaPai;
  ///////////////////////////////
  // ATIVA SE O MÓDULO EXISTIR //
  ///////////////////////////////
  BProdutos.Visible := ConfigModulos.NotaFiscal;
  //////////////////////////////////
  // CONFIG. MÓDULO DE COMISSÕES  //
  //////////////////////////////////
  BComissoes.Visible := ConfigModulos.Comissao;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Atividades dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************* cadastra uma nova conta ************************************** }
procedure TFContasaReceber.BotaoCadastrar1Click(Sender: TObject);
begin
   FNovoContasAReceber := TFNovoContasAReceber.CriarSdi(self,'',FPrincipal.VerificaPermisao('FNovoContasAReceber'));
   FNovoContasAReceber.BNovo.click;
   FNovoContasAReceber.ShowModal;
   AtualizaDados;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFContasaReceber.BitBtn1Click(Sender: TObject);
begin
  if FGraficosCR <> nil then
   FGraficosCR.close;
  self.close;
end;


{***************************Chama a baixa da parcela***************************}
procedure TFContasaReceber.BPagamentoClick(Sender: TObject);
begin
   FEfetuarBaixaReceber := TFEfetuarBaixaReceber.CriarSDI(application,'',fprincipal.VerificaPermisao('FEfetuarBaixaReceber')); //verificar a permissão na versão original;
   if paginas.ActivePage = TabNotas then
   begin
     if FEfetuarBaixaReceber.BaixaParcela( MovNotasI_LAN_REC.AsInteger, MovNotasI_NRO_PAR.AsInteger, MovNotasD_DAT_VEN.AsDateTime, CadNotasC_CLA_PLA.AsString) then
     begin
       FEfetuarBaixaReceber.ShowModal;
       AtualizaDados;
     end
     else
      FEfetuarBaixaReceber.close;
   end
   else
   begin
      if paginas.ActivePage = TabParcelas then
        if FEfetuarBaixaReceber.BaixaParcela( MovParcelasI_LAN_REC.AsInteger, MovParcelasI_NRO_PAR.AsInteger, MovParcelasD_DAT_VEN.AsDateTime, MovParcelasC_CLA_PLA.AsString ) then
        begin
          FEfetuarBaixaReceber.ShowModal;
          executaParcelaPai;
        end
        else
          FEfetuarBaixaReceber.close;
   end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da Nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.CadNotasAfterScroll(DataSet: TDataSet);
begin
   if TeclaPresionada then
    executaNotaFilho;
   if CadNotas.EOF then
     CadNotas.Prior;
end;


{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.TipoDataNotaChange(Sender: TObject);
begin
   ExecutaNotaPai;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.DataNota1Change(Sender: TObject);
begin
   executaNotaPai;
   CarregaVariaveisGrafico;
end;

{*****************************Atualiza a Consulta******************************}
procedure TFContasaReceber.executaNotaPai;
begin
  LimpaSQLTabela(CadNotas);
  InseriLinhaSQL(CadNotas, 0,' Select ' +
                         ' CR.I_EMP_FIL, CR.I_LAN_REC, CR.N_VLR_TOT, CR.I_NRO_NOT, ' +
                         ' CR.D_DAT_EMI, CR.D_DAT_MOV, CR.I_SEQ_NOT, cr.I_COD_MAT, ' +
                         ' P.C_NOM_PLA, C.C_NOM_CLI, CR.C_CLA_PLA ' +
                         ' from CadContasAReceber as CR, CadClientes as C, CAD_PLANO_CONTA as P ' +
                         ' where CR.C_CLA_PLA = P.C_CLA_PLA and CR.I_COD_CLI = C.I_COD_CLI' );

   if EditLocaliza8.Text = '' then
         InseriLinhaSQL(CadNotas, 1,'and CR.I_EMP_FIL >= 0 ')
   else
        InseriLinhaSQL(CadNotas, 1,'and CR.I_EMP_FIL = ' + EditLocaliza8.Text );


   if EPlanoGeral.Text <> '' then
     InseriLinhaSQL(CadNotas, 2,' and CR.C_CLA_PLA = ''' + Trim(EPlanoGeral.Text) + '''' )
   else
     InseriLinhaSQL(CadNotas, 2,'');


   if EditLocaliza7.Text <> '' then
     InseriLinhaSQL(CadNotas, 3,' and CR.I_COD_CLI = ' + EditLocaliza7.Text )
   else
     InseriLinhaSQL(CadNotas, 3,'');
   InseriLinhaSQL(CadNotas, 4,' and CR.D_DAT_EMI between ''' + DataToStrFormato(AAAAMMDD,DataNota1.Date, '/') + '''' +
                                   ' and ''' + DataToStrFormato(AAAAMMDD,DataNota2.Date, '/') + ''''  );

   if  SomenteUmaNota then
   begin
     InseriLinhaSQL(CadNotas, 5,' and CR.I_LAN_REC = ' + MovPArcelasI_LAN_REC.AsString );
     SomenteUmaNota := false;
   end
     else
       InseriLinhaSQL(CadNotas, 5,' ');

   InseriLinhaSQL(CadNotas, 6,' order by CR.I_LAN_REC'); //para ordenar

   AbreTabela(CadNotas);
   executaNotaFilho;
   if trim(Inttostr(varia.CodigoEmpFil)) = (EditLocaliza5.text) then
     VerificaBotoes(not CadNotas.EOF)
end;

{*****************************Atualiza a consulta******************************}
procedure TFContasaReceber.executaNotaFilho;
begin
   LimpaSQLTabela(MovNotas);
   if not CadNotas.EOF then
   begin
     AdicionaSQLTabela(MovNotas, 'Select * from dba.MovContasaReceber ' +
                      ' where I_EMP_FIL = ' + IntToStr(CadNotasI_EMP_FIL.AsInteger) +
                      ' and I_LAN_REC = ' + CadNotasI_LAN_REC.AsString +
                      ' and isnull(c_dup_can, ''N'') <> ''S''' +
                      ' order by d_dat_ven');
     AbreTabela(MovNotas);
   end;
   MovParcelasAfterScroll(nil);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** select do cliente em relacao ao clientes existente no CR *****}
procedure TFContasaReceber.EditLocaliza4Select(Sender: TObject);
begin
  EditLocaliza4.ASelectLocaliza.clear;
  EditLocaliza4.ASelectLocaliza.Add(' Select * from CadClientes where  c_tip_cad <> ''F'' and '+
                                    ' c_nom_cli like ''@%'' and i_cod_cli in ' +
                                    ' (select i_cod_cli from cadcontasareceber ');
  EditLocaliza4.ASelectValida.clear;
  EditLocaliza4.ASelectValida.Add(' select * from CadClientes where c_tip_cad <> ''F'' and ' +
                                  ' I_COD_CLI = @ and i_cod_cli in ' +
                                  ' (select i_cod_cli from cadcontasareceber' );
  if EditLocaliza5.Text <> '' then
  begin
    EditLocaliza4.ASelectLocaliza.Add(' where i_emp_fil = ' + EditLocaliza5.Text + ')' );
    EditLocaliza4.ASelectValida.Add(' where i_emp_fil = ' + EditLocaliza5.Text + ')' );
  end
  else
  begin
    EditLocaliza4.ASelectLocaliza.Add(' )' );
    EditLocaliza4.ASelectValida.Add(' )' );
  end;
end;

{**************** Quando Muda Filial ***************************************** }
procedure TFContasaReceber.EditLocaliza5Change(Sender: TObject);
begin
  if EditLocaliza5.Text = '' then
    TabNotas.TabVisible := false
  else
    TabNotas.TabVisible := true;
  EditLocaliza4Select(nil);
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.EditLocaliza6FimConsulta(Sender: TObject);
begin
  ExecutaNotaPai;
  CarregaVariaveisGrafico;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.EditLocaliza1FimConsulta(Sender: TObject);
begin
   EditLocaliza5.Text :=  '';
   if Filtro.Checked then
    executaParcelaPai;
   CarregaVariaveisGrafico;
end;

{**********************Carrega a select da filial******************************}
procedure TFContasaReceber.EditLocaliza5Select(Sender: TObject);
begin
   EditLocaliza5.ASelectLocaliza.Text := ' Select * from CadFiliais as fil ' +
                                         ' where c_nom_fan like ''@%'' ' +
                                         ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   EditLocaliza5.ASelectValida.Text := ' Select * from CadFiliais where I_EMP_FIL = @% ' +
                                       ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   if Varia.FilialUsuario <> '' then
   begin
     EditLocaliza5.ASelectValida.add(' and i_emp_fil not in ( ' + Varia.FilialUsuario + ')');
     EditLocaliza5.ASelectLocaliza.add(' and i_emp_fil not in ( ' + Varia.FilialUsuario + ')');
   end;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.EditLocaliza5Exit(Sender: TObject);
begin

end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos grid's
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Trata as teclas precionadas***************************}
procedure TFContasaReceber.GradeNota1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := false;
  MovNotas.close;
end;

{************************Trata as teclas precionadas***************************}
procedure TFContasaReceber.GradeNota1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   TeclaPresionada := true;
   if key in[37..40]  then
     executaNotaFilho;
end;

{************************Trata as teclas pressionadas**************************}
procedure TFContasaReceber.gradeParcelas2KeyPress(Sender: TObject;
  var Key: Char);
begin
   if Key = #13 then
   begin
     detalhes.Visible := true;
     MostraFormas;
   end;  
   if key = '+' then
   begin
     ExZoom.Down := true;
     ExZoomClick(ExZoom);
   end
   else
      if key = '-' then
      begin
         ExZoom.Down := false;
         ExZoomClick(ExZoom);
       end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFContasaReceber.executaParcelaPai;
var
  CampoDataSoma : string;
  somaPago, ValorDescontado, ValorAberto : Double;
begin
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,'Select ' );
  MovParcelas.sql.Insert(1,' CR.I_LAN_REC, CR.C_CLA_PLA, MCR.L_OBS_REC, CR.I_SEQ_NOT,' +
                           ' CR.I_COD_CLI, CR.I_NRO_NOT, MCR.I_NRO_PAR, CR.I_COD_MAT, ' +
                           ' MCR.D_DAT_VEN, MCR.N_DES_VEN, CR.D_DAT_EMI,' +
                           ' (MCR.N_VLR_PAR * MOE.N_VLR_DIA) as N_VLR_PAR, MCR.D_DAT_PAG,' +
                           ' MCR.N_VLR_PAG, MOE.C_NOM_MOE, CR.I_EMP_FIL, ' +
                           ' C.C_NOM_CLI, P.C_NOM_PLA, CR.D_DAT_MOV, ' +
                           ' FIL.C_NOM_FAN, MCR.C_NRO_DUP,' +
                           ' CPG.N_PER_DES, CPG.C_NOM_PAG, FRM.C_NOM_FRM,' +
                           ' MCR.N_PER_MUL, MCR.N_PER_JUR, MCR.N_VLR_DES, ' +
                           ' MCR.N_VLR_ACR, MCR.N_PER_MOR');
  InseriLinhaSQL(MovParcelas, 2,'from ' +
                           ' MovContasaReceber as MCR, ' +
                           ' CadContasaReceber as CR, ' +
                           ' CadClientes as C, '+
                           ' CAD_PLANO_CONTA as P, ' +
                           ' CadFiliais as Fil, ' +
                           ' CadCondicoesPagto as CPG, ' +
                           ' CadFormasPagamento as FRM, ' +
                           ' CadMoedas as MOE '+
                           ' where (CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                           ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                           ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                           ' and CR.C_CLA_PLA = P.C_CLA_PLA ' +
                           ' and MCR.I_EMP_FIL = FIL.I_EMP_FIL ' +
                           ' and CR.I_COD_PAG = CPG.I_COD_PAG ' +
                           ' and MCR.I_COD_FRM *= FRM.I_COD_FRM ' +
                           ' and MCR.I_COD_MOE = MOE.I_COD_MOE )' +
                           ' and ISNULL(MCR.C_DUP_CAN, ''N'') <> ''S''');
   case RPeriodo.ItemIndex of
     // VENCIMENTO;
     0 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_VEN',
                DataParcela1.Date, DataParcela2.Date, true) + ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');
     // EMISSÃO.
     1 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',
                DataParcela1.Date, DataParcela2.Date, true) + ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');
     // PAGAMENTO.
     2 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_PAG',
                DataParcela1.Date, DataParcela2.Date, true) +  ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');
    // cadastro.
    3 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('CR.D_DAT_MOV',
                       DataParcela1.Date, DataParcela2.Date, true) +  ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');
  end;
  case SitPar.ItemIndex of
     0 : InseriLinhaSQL(MovParcelas, 4,' AND MCR.D_DAT_PAG is null' );
     1 : InseriLinhaSQL(MovParcelas, 4,' and MCR.D_DAT_VEN < ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                       ' and MCR.D_DAT_PAG is null ' );
     2 : InseriLinhaSQL(MovParcelas, 4,' and not(MCR.D_DAT_PAG is null)' );
     3 : InseriLinhaSQL(MovParcelas, 4,' and MCR.D_DAT_VEN = ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                       ' and MCR.D_DAT_PAG is null' );
     4 : InseriLinhaSQL(MovParcelas, 4,' and MCR.D_DAT_VEN > ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                       ' and MCR.D_DAT_PAG is null ' );
     5 : InseriLinhaSQL(MovParcelas, 4,'');     // todas
   end;
   // filtro empresa / filial
   if EditLocaliza5.Text <> '' then
     InseriLinhaSQL(MovParcelas, 5,' and MCR.I_EMP_FIL = ' + EditLocaliza5.Text +
                                   ' and p.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa))
   else
     InseriLinhaSQL(MovParcelas, 5,' and p.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) );

   // FILTRO DO PLANO DE CONTAS
   if EPlano.Text <> '' then
     InseriLinhaSQL(MovParcelas, 6,' and CR.C_CLA_PLA like ''' + EPLano.Text + '%''' )
   else
     InseriLinhaSQL(MovParcelas, 6,'');
   // filtro cliente
   if EditLocaliza4.Text <> '' then
     InseriLinhaSQL(MovParcelas, 7,' and CR.I_COD_CLI = ' + EditLocaliza4.Text )
   else
     InseriLinhaSQL(MovParcelas, 7,'');

   if EdcFormaPgto.Text <> '' then
     InseriLinhaSQL(MovParcelas, 8,' and MCR.I_COD_FRM = ' + EdcFormaPgto.Text )
   else
     InseriLinhaSQL(MovParcelas, 8,'');

   InseriLinhaSQL(MovParcelas, 9,' order by MCR.d_dat_ven');
  // totais
    case RPeriodo.ItemIndex of
      0 : CampoDataSoma := 'MCR.D_DAT_VEN';
      1 : CampoDataSoma := 'CR.D_DAT_EMI';
      2 : CampoDataSoma := 'MCR.D_DAT_PAG';
      3 : CampoDataSoma := 'CR.D_DAT_MOV';
    end;
    Numerico3.AValor := CR.SomaParcelaTotalFiltro( EditLocaliza4.text,
                                                   EPlano.text,
                                                   '',
                                                   EditLocaliza5.text,
                                                   CampoDataSoma,
                                                   EdcFormaPgto.text,
                                                   SitPar.ItemIndex,
                                                   DataParcela1.date,
                                                   dataParcela2.date,
                                                   somaPago, ValorDescontado, ValorAberto);
    numerico2.AValor := somaPago;
    numerico1.AValor := ValorDescontado;
    TotalAberto.AValor := ValorAberto;//numerico3.AValor - numerico2.AValor;

   AbreTabela(MovParcelas);
   if trim(Inttostr(varia.CodigoEmpFil)) = (EditLocaliza5.text) then
     VerificaBotoes(not movParcelas.EOF);
   MovParcelasAfterScroll(nil);
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.TipoDataParcelaChange(Sender: TObject);
begin
   executaParcelaPai;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.DataParcela1Change(Sender: TObject);
begin
   if Filtro.Checked then
      executaParcelaPai;
   CarregaVariaveisGrafico;
end;

{******************************Atualiza a consulta*****************************}
procedure TFContasaReceber.PaginasChange(Sender: TObject);
begin
   if paginas.ActivePage = TabNotas then
   begin
     if not (MovParcelas.EOF) then
     begin
       EditLocaliza8.Text := EditLocaliza5.Text;
       label21.Caption := label25.caption;
       DataNota1.Date := PrimeiroDiaMes(MovPArcelasD_DAT_EMI.AsDateTime);
       DataNota2.Date := UltimoDiaMes(MovPArcelasD_DAT_EMI.AsDateTime);
       self.ActiveControl := Gradeparcelas1;
       SomenteUmaNota := true;
       ExecutaNotaPai;
     end
       else
        ExecutaNotaPai;
     BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
   end
   else
   begin
       if paginas.ActivePage = TabParcelas then
       begin
         executaParcelaPai;
         FechaTabela(MovNotas);
         FechaTabela(cadNotas);
       end;
     BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
   end;
   CarregaVariaveisGrafico;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.SitParClick(Sender: TObject);
begin
   if Filtro.Checked then
      executaparcelapai;
end;

{******************Chama a rotina para atualizar a consulta********************}
procedure TFContasaReceber.BitBtn9Click(Sender: TObject);
begin
   executaparcelapai;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************Imprime o contas a Receber**************************}
procedure TFContasaReceber.BImprimirClick(Sender: TObject);
begin
   FImprimeCR := TFImprimeCR.CriarSDI(application,'',true);
   FImprimeCR.carregaImpressao( MovParcelas.Text,dataParcela1.Date,dataParcela2.Date, varia.NomeEmpresa,
                                Label25.Caption, LPlano.Caption,
                                Label20.Caption, SitPar.Items.Strings[SitPar.itemIndex],
                                FormatFloat(varia.MascaraMoeda, numerico2.AValor),
                                FormatFloat(varia.MascaraMoeda, numerico3.AValor),
                                FormatFloat(varia.MascaraMoeda, TotalAberto.avalor),
                                FormatFloat(varia.MascaraMoeda, Numerico1.avalor),
                                RPeriodo.Text);
end;

{***********************Carrega as variáveis no gráfico************************}
procedure TFContasaReceber.CarregaVariaveisGrafico;
begin
  if FGraficosCR <> nil then
  begin
    if paginas.ActivePage = TabNotas then
    begin
      FGraficosCR.CodigoEmpresa := IntTostr(varia.CodigoEmpresa);
      FGraficosCR.CodigoFilial :=  EditLocaliza8.Text;
      FGraficosCR.NomeEmpresa := varia.NomeEmpresa;
      FGraficosCR.NomeFilial := label21.Caption;
      FGraficosCR.Data1 :=  dataNota1.Date;
      FGraficosCR.Data2 := dataNota2.Date;
    end
    else
     if paginas.ActivePage = TabParcelas then
     begin
        FGraficosCR.CodigoEmpresa := IntToStr(varia.CodigoEmpresa);
        FGraficosCR.CodigoFilial :=  EditLocaliza5.Text;
        FGraficosCR.NomeEmpresa := varia.NomeEmpresa;
        FGraficosCR.NomeFilial :=  label25.Caption;
        FGraficosCR.Data1 :=  DataParcela1.Date;
        FGraficosCR.Data2 :=  DataParcela2.Date;
    end
  end;
end;

{***************Habilita os botões conforme passado o paramentro***************}
procedure TFContasaReceber.VerificaBotoes( estado : Boolean );
begin
  BProdutos.Enabled := estado;
  BPagamento.Enabled := estado;
  BGraficos.Enabled := estado;
  BNGraficoNota.Enabled := estado;
  BComissoes.Enabled := Estado;
  BotaoCadastrar1.Enabled := Estado;
  BAlterar.Enabled := Estado;
end;

{******************************Mostra o gráfico********************************}
procedure TFContasaReceber.BGraficosClick(Sender: TObject);
begin
   FGraficosCR := TFgraficosCR.CriarSDI(application,'',true);
   CarregaVariaveisGrafico;
   FGraficosCR.Show;
end;

{****O Botao de Filtro Manual recebe o contrário do check filtro automático****}
procedure TFContasaReceber.FiltroClick(Sender: TObject);
begin
  BitBtn9.Enabled := not filtro.Checked;
end;

{**************************Mostra o grid das parcelas**************************}
procedure TFContasaReceber.gradeParcelas2DblClick(Sender: TObject);
begin
   Detalhes.Visible := True;
   MostraFormas;
end;

{**********************Esconde o grid das parcelas*****************************}
procedure TFContasaReceber.BitBtn2Click(Sender: TObject);
begin
   detalhes.Visible := false;
end;

{*********************Altera os desenho do botão do zoom***********************}
procedure TFContasaReceber.ExZoomClick(Sender: TObject);
begin
   if ExZoom.Down then
   begin
     ExZoom.ImageIndex := 1;
      PanelColor3.Visible := false;
   end
   else
   begin
      ExZoom.ImageIndex := 0;
      PanelColor3.Visible := true;
   end;
end;

{***********************atualiza os dados das tabelas**************************}
procedure TFContasaReceber.AtualizaDados;
begin
  if paginas.ActivePage = TabNotas then
  begin
    AtualizaSQLTabela(CadNotas);
    BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
  end
  else
  begin
    AtualizaSQLTabela(MovParcelas);
    BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
  end;
end;

procedure TFContasaReceber.BAlterarClick(Sender: TObject);
begin
FManutencaoCR := TFManutencaoCR.CriarSDI(self, '', FPrincipal.VerificaPermisao('FManutencaoCR'));
if paginas.ActivePage = TabNotas then
begin
  FManutencaoCR.CarregaConta(CadNotasI_LAN_REC.AsInteger);
  FManutencaoCR.ShowModal;
  executaNotaPai;
  CarregaVariaveisGrafico;
end
else
begin
  FManutencaoCR.CarregaConta(MovParcelasI_LAN_REC.AsInteger);
  FManutencaoCR.ShowModal;
  executaparcelapai;
end;
end;

procedure TFContasaReceber.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
  if Filtro.Checked then
    ExecutaParcelaPai;
  CarregaVariaveisGrafico;
end;

procedure TFContasaReceber.EPlanoGeralExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  if (Sender is TSpeedButton)  then
    VpfCodigo := '99999'
  else
    VpfCodigo := EPlanoGeral.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlanoGeral, False) then
    EPlanoGeral.SetFocus;
  EPlanoGeral.text := VpfCodigo;
  ExecutaNotaPai;
  CarregaVariaveisGrafico;
end;

procedure TFContasaReceber.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if BAlterar.Enabled then
  begin
    if paginas.ActivePage <> TabNotas then
    begin
      BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
      MostraFormas;
    end
    else
      BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
  end;
end;

procedure TFContasaReceber.BComissoesClick(Sender: TObject);
begin
  FMovComissoes := TFMovComissoes.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMovComissoes'));
  FMovComissoes.MostraComissoes(dataparcela1.DateTime, dataParcela2.DateTime);
end;

procedure TFContasaReceber.BProdutosClick(Sender: TObject);
var
  seqnota, Filial : integer;
begin
  if (not MovParcelasI_SEQ_NOT.IsNull) then
  begin
    if Paginas.ActivePage = TabParcelas Then
    begin
      Filial := MovParcelasI_EMP_FIL.AsInteger;
      seqnota :=  MovParcelasI_SEQ_NOT.AsInteger;
    end
    else
    begin
      Filial := CadNotasI_EMP_FIL.AsInteger;
      seqnota := CadNotasI_SEQ_NOT.AsInteger;
    end;

    AdicionaSQLAbreTabela(aux,' select * from cadnotaFiscais where i_emp_fil = '
                              +  inttostr(Filial) +
                              ' and i_seq_not = ' + IntToStr(SeqNota));

    if aux.FieldByName('C_FLA_ECF').AsString = 'N' then
    begin
      FVizualizaNotaFiscal := TFVizualizaNotaFiscal.Create(self);// usar create para dar problemas de visualizar em relacao a permissao de filial
      FVizualizaNotaFiscal.ConsultaNotafiscal(Filial,seqnota);
      FVizualizaNotaFiscal.free;
    end
    else
    begin
      FVisualizaCupomFiscal := TFVisualizaCupomFiscal.create(self);
      FVisualizaCupomFiscal.ConsultaCupomFiscal(Filial,seqnota);
    end;
  end
  else
    aviso('Não existe nota fiscal vinculada');
end;

procedure TFContasaReceber.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

procedure TFContasaReceber.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FContasaReceber.HelpContext);
end;


procedure TFContasaReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f4 then
  begin
    detalhes.Visible := true;
    MostraFormas
  end;
end;

procedure TFContasaReceber.MostraFormas;
begin
  if Detalhes.Visible then
  begin
    AdicionaSQLAbreTabela(Formas,
      ' select FRM.C_NRO_CON, FRM.D_CHE_VEN, FRM.N_VLR_MOV, PAG.C_NOM_FRM, BAN.C_NOM_BAN, FRM.C_NRO_DOC ' +
      ' from MovForma FRM, CadFormasPagamento Pag, CadBancos Ban ' +
      ' where FRM.I_LAN_REC = ' + MovParcelasI_LAN_REC.AsString +
      ' and FRM.I_NRO_PAR = ' + MovParcelasI_NRO_PAR.AsString +
      ' and FRM.I_EMP_FIL = ' + MovParcelasI_EMP_FIL.AsString +
      ' and FRM.I_COD_BAN *= BAN.i_COD_BAN ' +
      ' and FRM.I_COD_FRM = Pag.I_COD_FRM ' );
    GFormas.ColCount := Formas.RecordCount;
  end;
end;

procedure TFContasaReceber.EditLocaliza5Retorno(Retorno1,
  Retorno2: String);
begin
  executaParcelaPai;
  VerificaBotoes(trim(Inttostr(varia.CodigoEmpFil)) = (EditLocaliza5.text) );
end;

Initialization
  RegisterClasses([TFContasaReceber]);
end.
