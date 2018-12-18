unit AConfiguraComissoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, StdCtrls, Componentes1, ExtCtrls, UnComissoes1,
  PainelGradiente, DBCtrls, Localizacao, Buttons, ComCtrls, Mask,
  DBKeyViolation;

type
  TFConfiguraComissoes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    CadVendedores: TQuery;
    DatacadVendedores: TDataSource;
    CadProdutos: TQuery;
    DatacadProdutos: TDataSource;
    CadVendedoresI_COD_VEN: TIntegerField;
    CadVendedoresC_NOM_VEN: TStringField;
    CadVendedoresN_PER_COM: TFloatField;
    CadVendedoresI_TIP_COM: TIntegerField;
    Aux: TQuery;
    BitBtn1: TBitBtn;
    MovQDadeProduto: TQuery;
    DataQDadeProduto: TDataSource;
    MovQDadeProdutoI_EMP_FIL: TIntegerField;
    MovQDadeProdutoI_SEQ_PRO: TIntegerField;
    MovQDadeProdutoN_PER_COM: TFloatField;
    CadProdutosI_SEQ_PRO: TIntegerField;
    CadProdutosI_COD_EMP: TIntegerField;
    CadProdutosC_NOM_PRO: TStringField;
    MovQDadeProdutoNome_Produto: TStringField;
    Localiza: TConsultaPadrao;
    BBAjuda: TBitBtn;
    CadVendedoresN_PER_SER: TFloatField;
    kk0y: TPageControl;
    Produtos: TTabSheet;
    ProdutoBox: TGroupBox;
    SpeedButton1: TSpeedButton;
    EProduto: TEditLocaliza;
    ServicoBox: TGroupBox;
    SpeedButton2: TSpeedButton;
    DBGridColor3: TDBGridColor;
    EServico: TEditLocaliza;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Vendedores: TTabSheet;
    GroupBox2: TGroupBox;
    DBGridColor5: TDBGridColor;
    CadServicos: TQuery;
    DataServicos: TDataSource;
    CadServicosI_COD_SER: TIntegerField;
    CadServicosC_NOM_SER: TStringField;
    CadServicosI_COD_EMP: TIntegerField;
    BitBtn2: TBitBtn;
    MovQDadeProdutoN_VLR_COM: TFloatField;
    DBGridColor4: TDBGridColor;
    CadServicosN_PER_COM: TFloatField;
    CadServicosN_VLR_COM: TFloatField;
    BitBtn3: TBitBtn;
    Metas: TTabSheet;
    MovMetas: TQuery;
    DataMetas: TDataSource;
    Label1: TLabel;
    editcolor2: TEditColor;
    PainelMeta: TPanel;
    Label29: TLabel;
    emeta: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label38: TLabel;
    PageControl1: TPageControl;
    Valores: TTabSheet;
    Grade: TGridIndice;
    Quantidade: TTabSheet;
    Grade2: TGridIndice;
    CadVendedoresI_COD_MET: TIntegerField;
    MovMetasI_EMP_FIL: TIntegerField;
    MovMetasI_SEQ_MOV: TIntegerField;
    MovMetasI_COD_MET: TIntegerField;
    MovMetasN_TOT_MET: TFloatField;
    MovMetasN_PER_MET: TFloatField;
    MovMetasN_VLR_MET: TFloatField;
    MovMetasI_QTD_MET: TIntegerField;
    MovMetasN_VLR_QTD: TFloatField;
    MovMetasI_COD_USU: TIntegerField;
    MovMetasD_ULT_ALT: TDateField;
    MovMetasN_MET_FIM: TFloatField;
    MovMetasI_QTD_FIM: TIntegerField;
    MovMetasN_PER_QTD: TFloatField;
    CadMetas: TQuery;
    DataCadMetas: TDataSource;
    CadMetasI_EMP_FIL: TIntegerField;
    CadMetasI_COD_MET: TIntegerField;
    CadMetasC_NOM_MET: TStringField;
    CadMetasD_ULT_ALT: TDateField;
    CadMetasI_COD_USU: TIntegerField;
    CadMetasD_DAT_CAD: TDateField;
    CadMetasC_VAL_MET: TStringField;
    CadMetasI_FOR_MET: TIntegerField;
    CadMetasI_ANA_MET: TIntegerField;
    CadMetasI_CAL_MET: TIntegerField;
    CadMetasI_PAG_MET: TIntegerField;
    CadMetasI_ORI_MET: TIntegerField;
    CadMetasI_VAL_MET: TIntegerField;
    MetaVendedor: TTabSheet;
    PainelVen: TPanel;
    Label3: TLabel;
    Consulta: TEditColor;
    GridIndice1: TGridIndice;
    ProdutoNulo: TCheckBox;
    BNovoProduto: TBitBtn;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    meta1: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label5: TLabel;
    Label7: TLabel;
    meta2: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    meta3: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label10: TLabel;
    CadVendedoresI_COD_ME2: TIntegerField;
    CadVendedoresI_COD_ME3: TIntegerField;
    CondicaoPagto: TTabSheet;
    PainelCondicao: TGroupBox;
    Label4: TLabel;
    DBGridColor1: TDBGridColor;
    DBGridColor2: TDBGridColor;
    CadCondicoes: TQuery;
    CadCondicoesI_COD_PAG: TIntegerField;
    CadCondicoesC_NOM_PAG: TStringField;
    CadCondicoesD_ULT_ALT: TDateField;
    DataCadCondicao: TDataSource;
    MovCondicoes: TQuery;
    MovCondicoesI_TIP_COM: TIntegerField;
    MovCondicoesI_NRO_PAR: TIntegerField;
    MovCondicoesD_ULT_ALT: TDateField;
    DataMovCondicoes: TDataSource;
    MovCondicoesN_PER_AJU: TFloatField;
    MovCondicoesN_PER_COM: TFloatField;
    CadCondicoesI_QTD_PAR: TIntegerField;
    CadCondicoesN_PER_DES: TFloatField;
    MovCondicoesN_PER_PAG: TFloatField;
    CadCondicoesD_VAL_CON: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoSelect(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure EServicoRetorno(Retorno1, Retorno2: String);
    procedure EServicoSelect(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RadioButton1Exit(Sender: TObject);
    procedure RadioButton2Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure emetasRetorno(Retorno1, Retorno2: String);
    procedure ConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BNovoProdutoClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ProdutoNuloClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure meta1Select(Sender: TObject);
    procedure meta2Select(Sender: TObject);
    procedure meta3Select(Sender: TObject);
    procedure MovCondicoesAfterPost(DataSet: TDataSet);
    procedure DBGridColor2ColExit(Sender: TObject);
    procedure CadCondicoesAfterScroll(DataSet: TDataSet);
    procedure MovCondicoesAfterEdit(DataSet: TDataSet);
    procedure MovCondicoesAfterInsert(DataSet: TDataSet);
    procedure DBGridColor2Exit(Sender: TObject);
    procedure DBGridColor1Exit(Sender: TObject);
    procedure MovCondicoesBeforePost(DataSet: TDataSet);
    procedure CadCondicoesBeforePost(DataSet: TDataSet);

  private
    UnCom : TFuncoesComissao;
    texto, texto1 : string;
    OrdemConsulta : string;
    PerCom, PerPag : Double;
    procedure CarregaMovCondicoes( codigoPagto : integer );
    function RecalculaComissao(Parcela : Integer):Boolean;
    procedure AtualizaMov;
    procedure ExtornaValor(Valor : Double);
    procedure ExtornaValorCom(Valor : Double);
  public
    { Public declarations }
    procedure ConfiguraGrade;
    procedure ConfiguraGradeMeta;
    procedure CarregaCadMetas(codmeta : string);
    procedure CarregaMetas(codmeta : string);
    procedure CarregaVendedores;
    procedure MontaSelect;

  end;

var
  FConfiguraComissoes: TFConfiguraComissoes;

implementation

uses APrincipal, constMsg, constantes, funsql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguraComissoes.FormCreate(Sender: TObject);
begin
   UnCom := TFuncoesComissao.criar(self, FPrincipal.BaseDados);
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Path e o nome do arquivo de Help
   texto := '';
   AbreTabela(CadCondicoes);
   CarregaMovCondicoes(CadCondicoes.fieldByName('I_COD_PAG').AsInteger);
   if RadioButton1.Checked then
     ProdutoBox.Visible := true
   else
     ProdutoBox.Visible := false;

   Case varia.ComissaoPadrao of
    0 : begin
          Produtos.TabVisible := true;
          MovQDadeProduto.open;
          CadProdutos.open;
          CadServicos.open;
          Vendedores.TabVisible := false;
          ConfiguraGrade;
        end;
    1 : begin
          Produtos.TabVisible := true;
          MovQDadeProduto.open;
          CadProdutos.open;
          CadServicos.open;
          Vendedores.TabVisible := false;
          ConfiguraGrade;
        end;
    2 : begin
          Vendedores.TabVisible := true;
          CarregaVendedores;
          Produtos.TabVisible := false;
          ConfiguraGrade;
        end;
    3 : begin
          Vendedores.TabVisible := false;
          Produtos.TabVisible := false;
        end;
   end;

   case varia.UsarMeta of
     0 : begin
           Metas.TabVisible := true;
           MetaVendedor.tabvisible := false;
           emeta.text := inttostr(varia.metapadrao);
           emeta.atualiza;
           CarregaCadMetas(inttostr(varia.metapadrao));
           ConfiguraGradeMeta;
         end;
     1 : begin
           MetaVendedor.TabVisible := true;
           Metas.TabVisible := false;
           MontaSelect;
         end;
     2 : begin
           Metas.TabVisible := false;
           MetaVendedor.TabVisible := false;
         end;
   end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguraComissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(MovQDadeProduto);
  FechaTabela(CadVendedores);
  CadProdutos.close;
  CadServicos.close;
  CadVendedores.close;
  MovQdadeProduto.close;
  MovMetas.close;
  CadMetas.close;
  FechaTabela(CadCondicoes);
  MovCondicoes.close;
  aux.close;
  Action := CaFree;
  UnCom.free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Calculos do percentual do parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************** Configura grade *********************************}
procedure TFConfiguraComissoes.ConfiguraGrade;
begin
  DBGridColor4.Columns[1].Visible := not (varia.ComissaoPadrao = 1);
  DBGridColor4.Columns[2].Visible := not (varia.ComissaoPadrao = 0);
  DBGridColor3.Columns[1].Visible := not (varia.ComissaoPadrao = 1);
  DBGridColor3.Columns[2].Visible := not (varia.ComissaoPadrao = 0);
end;

{*************** Configura grade Meta por Valor ou Percentual *****************}
procedure TFConfiguraComissoes.ConfiguraGradeMeta;
begin
  Grade.Columns[2].Visible := not (CadMetas.fieldbyname('I_FOR_MET').asinteger = 0);
  Grade.Columns[3].Visible := not (CadMetas.fieldbyname('I_FOR_MET').asinteger = 1);
  Grade2.Columns[2].visible := not (CadMetas.fieldbyname('I_FOR_MET').asinteger = 1);
  Grade2.Columns[3].visible := not (CadMetas.fieldbyname('I_FOR_MET').asinteger = 0);
end;

{******************************** Carrega dados da meta ***********************}
procedure TFConfiguraComissoes.CarregaCadMetas(codmeta : string);
begin
  LimpaSQLTabela(CadMetas);
  AdicionaSQLTabela(CadMetas, ' select * From cadmetacomissao '+
                              ' where i_emp_fil = ' + inttostr(Varia.CodigoEmpFil)+
                              ' and i_cod_met = ' + codmeta);

  CadMetas.open;
end;

{***************************** Carrega Dados do movmetas **********************}
procedure TFConfiguraComissoes.CarregaMetas(codmeta : string);
begin
  LimpaSQLTabela(MovMetas);
  AdicionaSQLTabela(MovMetas, ' select * From movmetacomissao '+
                              ' where i_emp_fil = ' + inttostr(Varia.CodigoEmpFil)+
                              ' and i_cod_met = ' + codmeta +
                              ' order by n_tot_met, i_qtd_met');

  MovMetas.open;
end;

{*************************** Carrega Dados do Vendedor ************************}
procedure TFConfiguraComissoes.CarregaVendedores;
begin
  LimpaSQLTabela(CadVendedores);
  AdicionaSQLTabela(CadVendedores, ' select * from CadVendedores' +
                                   ' where c_ati_ven = ''S''' +
                                   texto +
                                   ' order by c_nom_ven');
  CadVendedores.open;
end;


{************************ Carrega movimento de comissoes ******************** }
procedure TFConfiguraComissoes.CarregaMovCondicoes( codigoPagto : integer );
begin
  AdicionaSQLAbreTabela(MovCondicoes, ' select * from movCondicaoPagto '+
                                      ' where i_cod_pag = ' + IntToStr(CodigoPagto)+
                                      ' order by i_nro_par');
  movCondicoes.Next;
  if movCondicoes.Eof then
    DBGridColor2.ReadOnly := true
  else
    DBGridColor2.ReadOnly := false;
  movCondicoes.First;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Calcula a comissao ***********************************}
function TFConfiguraComissoes.RecalculaComissao(Parcela : Integer):Boolean;
var
   PrimeiroValor, SegundoValor : Double;
   TerceiroValor, QuartoValor : double;
   nroRegistro : Integer;
begin
   result := true;
   PrimeiroValor := 0;
   TerceiroValor := 0;
   nroRegistro := 0;

   aux.RequestLive := True;
   AdicionaSQLAbreTabela(aux, 'Select * '+
                              'from MovCondicaoPagto ' +
                              'Where I_Cod_Pag = ' + CadCondicoes.FieldByName('I_Cod_Pag').AsString +
                              ' order by i_nro_par asc');

   While aux.FieldByName('I_Nro_Par').AsInteger < parcela  do  //descobre o valor das parcelas acima
   begin
      PrimeiroValor := primeiroValor + Aux.FieldByName('N_Per_Pag').asfloat;
      TerceiroValor := TerceiroValor + Aux.Fieldbyname('n_Per_com').asfloat;
      aux.next;
      inc(nroRegistro);
   end;

   if parcela <> Aux.RecordCount Then     // somente soma se nao for a ultima parcela;
   begin
     PrimeiroValor := primeiroValor + Aux.FieldByName('N_Per_Pag').asfloat;
     TerceiroValor := terceiroValor + Aux.FieldByName('N_Per_com').asfloat;
     inc(nroRegistro);
     Aux.next;
   end
   else
      Aviso('Não é possível alterar a última parcela');
   if PrimeiroValor > 100 Then  //se o percentual for maior que 100 retorna falso;
   begin
      result := false;
      exit;
   end;
   segundoValor := (100 - PrimeiroValor) / (aux.RecordCount - nroRegistro);
   QuartoValor :=  (100 - TerceiroValor) / (aux.RecordCount - nroRegistro);
   while not aux.eof do  //altera o valor das parcelas abaixo;
   begin
      EditarReg(aux);
      Aux.FieldByName('N_Per_Pag').AsFloat := SegundoValor;
      Aux.fieldbyname('n_per_com').asfloat := quartovalor;
      GravaReg(aux);
      aux.next;
   end;
   aux.RequestLive := False;
end;


{*****************************Extorna o valor**********************************}
procedure TFConfiguraComissoes.ExtornaValor(Valor : Double);
begin
   aviso('Valor das parcelas maior que 100%');
   EditarReg(MovCondicoes);
   MovCondicoesN_PER_Pag.AsFloat := valor;
   GravaReg(MovCondicoes);
end;

{*****************************Extorna o valor**********************************}
procedure TFConfiguraComissoes.ExtornaValorCom(Valor : Double);
begin
   aviso('Valor das parcelas maior que 100%');
   EditarReg(MovCondicoes);
   MovCondicoesN_PER_Com.AsFloat := valor;
   GravaReg(MovCondicoes);
end;

{***************************Atualiza a mov Condição****************************}
procedure TFConfiguraComissoes.AtualizaMov;
begin
   AtualizaSQLTabela(MovCondicoes);
   DBGridColor2.Refresh;
   DBGridColor2.Repaint;
end;


{************************ botao fechar ****************************************}
procedure TFConfiguraComissoes.BitBtn1Click(Sender: TObject);
begin
  close;
end;

{******************************** retorno dos produtos ***********************}
procedure TFConfiguraComissoes.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 = '') then
  begin
    // Posiciona todos os produtos.
    AdicionaSQLAbreTabela(MovQDadeProduto,
      ' select * from MovQDadeProduto ' +
      ' where I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  end
  else
  begin
    // Posiciona o produto selecionado.
    AdicionaSQLAbreTabela(MovQDadeProduto,
      ' select * from MovQDadeProduto ' +
      ' where I_SEQ_PRO = ' + Trim(Retorno1) +
      ' and I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  end;
end;

{**************************** seleciona um produto ****************************}
procedure TFConfiguraComissoes.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectLocaliza.Clear;
  EProduto.ASelectLocaliza.Add(' Select * from cadprodutos key join movqdadeproduto ' +
                               ' WHERE cadprodutos.C_NOM_PRO LIKE ''@%''' +
                               ' and cadprodutos.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa));
  EProduto.ASelectValida.Clear;
  EProduto.ASelectValida.Add(' Select * from cadprodutos key join movqdadeproduto ' +
                             ' WHERE cadprodutos.C_NOM_PRO = ''@''' +
                             ' and cadprodutos.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa));
end;

{***************************** Botao ajuda ************************************}
procedure TFConfiguraComissoes.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FConfiguraComissoes.HelpContext);
end;

{*************************** Mostra grade de produtos *************************}
procedure TFConfiguraComissoes.RadioButton1Click(Sender: TObject);
begin
  ProdutoBox.Visible := true;
  ServicoBox.Visible := false;
end;

{************************** Mostra a grade de servicos ************************}
procedure TFConfiguraComissoes.RadioButton2Click(Sender: TObject);
begin
  ServicoBox.Visible := true;
end;

{************************* retorno do servico *********************************}
procedure TFConfiguraComissoes.EServicoRetorno(Retorno1, Retorno2: String);
begin
 if (Retorno1 = '') then
  begin
    // Posiciona todos os servicos.
    AdicionaSQLAbreTabela(CadServicos,
      ' select * from CadServico ' +
      ' where I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa));
  end
  else
  begin
    // Posiciona o servico selecionado.
    AdicionaSQLAbreTabela(CadServicos,
      ' select * from CadServico ' +
      ' where I_COD_SER = ' + Trim(Retorno1) +
      ' and I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) );
  end;
end;

{****************************** Seleciona um servico **************************}
procedure TFConfiguraComissoes.EServicoSelect(Sender: TObject);
begin
  EServico.ASelectLocaliza.Clear;
  EServico.ASelectLocaliza.Add(' Select * from cadservico ' +
                               ' WHERE cadservico.C_NOM_SER LIKE ''@%''' +
                               ' and cadServico.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa));
  EServico.ASelectValida.Clear;
  EServico.ASelectValida.Add(' Select * from cadServico ' +
                             ' WHERE cadServico.C_NOM_Ser = ''@''' +
                             ' and cadServico.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa));
end;

{**************************** Botao alterar ***********************************}
procedure TFConfiguraComissoes.BitBtn2Click(Sender: TObject);
begin
   PainelCondicao.Enabled := true;
   Case varia.ComissaoPadrao of
    0 : begin
          if RadioButton1.Checked then
           begin
             DBGridColor4.Enabled := true;
             MovQDadeProduto.Edit;
           end
          else
           if RadioButton2.Checked then
            begin
             DBGridColor3.Enabled := true;
             CadServicos.Edit;
            end;
        end;
    1 : begin
          if RadioButton1.Checked then
           begin
             DBGridColor4.Enabled := true;
             MovQDadeProduto.Edit;
           end
          else
           if RadioButton2.Checked then
            begin
             DBGridColor3.Enabled := true;
             CadServicos.Edit;
            end;
        end;
    2 : begin
          DBGridColor5.Enabled := true;
          CadVendedores.Edit;
        end;
  end;

  case varia.Usarmeta of
   0 : begin
         carregaCadmetas(inttostr(varia.metapadrao));
         CarregaMetas(inttostr(varia.metapadrao));
         MovMetas.edit;
         case cadmetas.fieldbyname('i_ana_met').asinteger of
           0 : grade.enabled := true;
           1 : grade2.enabled := true;
         end;
       end;
   1 : begin
         painelven.Enabled := true;
         montaselect;
       end;
  end;
end;

{******************************** seleciona por produto ***********************}
procedure TFConfiguraComissoes.RadioButton1Exit(Sender: TObject);
begin
  if RadioButton1.Checked then
     ProdutoBox.Visible := true
  else
     ProdutoBox.Visible := false;
end;

{*************************** Seleciona por servico ****************************}
procedure TFConfiguraComissoes.RadioButton2Exit(Sender: TObject);
begin
  if RadioButton2.Checked then
     ServicoBox.Visible := true
  else
     ServicoBox.Visible := false;
end;

{****************************** Botao confirmar *******************************}
procedure TFConfiguraComissoes.BitBtn3Click(Sender: TObject);
begin
  if MovQDadeProduto.State in [ dsEdit ] then
    GravaReg(MovQDadeProduto);
  if CadServicos.State in [ dsEdit ] then
    GravaReg(CadServicos);
  if cadVendedores.State in [ dsedit ] then
    GravaReg(cadvendedores);
end;

{****************************** Retorno da meta *******************************}
procedure TFConfiguraComissoes.emetasRetorno(Retorno1, Retorno2: String);
begin
  If Retorno1 <> '' Then
  begin
     CarregaMetas(Retorno1);
     CarregaCadMetas(retorno1);
     ConfiguraGradeMeta;
     case cadMetas.fieldbyname('I_ANA_MET').asinteger of
      0 : begin
            Valores.TabVisible := true;
            quantidade.TabVisible := false;
          end;
      1 : begin
            Quantidade.TabVisible := true;
            Valores.TabVisible := false;
          end;
     end;

     case cadMetas.fieldbyname('I_FOR_MET').asinteger of
       0 : editColor2.Text := 'Valor';
       1 : editColor2.Text := 'Percentual';
     end;
  end;

end;

{*************************** Monta a select do vendedor ***********************}
procedure TFConfiguraComissoes.MontaSelect;
begin
  if ProdutoNulo.Checked then
    texto := ' and i_cod_met <> 0 ' +
              ' or i_cod_me2 <> 0 '+
              ' or i_cod_me3 <> 0 '
  else
    texto := '';

  LimpaSQLTabela(CadVendedores);
  InseriLinhaSQL(CadVendedores, 0, ' Select * from CadVendedores ' +
                                   ' Where C_ATI_VEN = ''S''' +
                                    texto +
                                    texto1 );

  InseriLinhaSQL(CadVendedores, 1, OrdemConsulta);
  AbreTabela(CadVendedores);
end;

{********************** Consulta por nome do vendedor *************************}
procedure TFConfiguraComissoes.ConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if key = 13 then
    begin
      texto := ' and c_nom_ven like ''' + Consulta.Text + '%''';
      CarregaVendedores;
   end;
end;

{******************** Botao alterar meta do vendedor **************************}
procedure TFConfiguraComissoes.BNovoProdutoClick(Sender: TObject);
var
  marca : TBookmark;
  vendedor : string;
begin
  if not CadVendedores.eof then
  begin
    vendedor := inttostr(CadVendedores.fieldByname('I_COD_ven').Asinteger);
    if (meta1.text <> '') then
     begin
       executacomandosql(Aux, ' update cadvendedores '+
                              ' set i_cod_met = ' + meta1.text +
                              ' where i_cod_ven = ' + vendedor);
       marca := CadVendedores.GetBookmark;
       MontaSelect;
       CadVendedores.GotoBookmark(marca);
       CadVendedores.FreeBookmark(marca);

     end;

    if (not cadvendedores.fieldbyname('i_cod_met').isnull) and (meta2.text <> '') then
     begin
       executacomandosql(Aux, ' update cadvendedores '+
                              ' set i_cod_me2 = ' + meta2.text +
                              ' where i_cod_ven = ' + vendedor);
      marca := CadVendedores.GetBookmark;
      MontaSelect;
      CadVendedores.GotoBookmark(marca);
      CadVendedores.FreeBookmark(marca);
     end;

    if (not cadvendedores.fieldbyname('i_cod_met').isnull) and
       (not cadvendedores.fieldbyname('i_cod_me2').isnull) and (meta3.text <> '') then
     begin
       executacomandosql(Aux, ' update cadvendedores '+
                              ' set i_cod_me3 = ' + meta3.text +
                              ' where i_cod_ven = ' + vendedor);
      marca := CadVendedores.GetBookmark;
      MontaSelect;
      CadVendedores.GotoBookmark(marca);
      CadVendedores.FreeBookmark(marca);
     end;

  end;
  marca := CadVendedores.GetBookmark;
  MontaSelect;
  CadVendedores.GotoBookmark(marca);
  CadVendedores.FreeBookmark(marca);

end;

{********************* Botao Excluir meta do vendedor *************************}
procedure TFConfiguraComissoes.BitBtn4Click(Sender: TObject);
var
  marca : TBookmark;
begin
  if not CadVendedores.eof then
  begin
    ExecutaComandoSQL(Aux, ' update cadvendedores ' +
                           ' set i_cod_met = null ' +
                           ' , i_cod_me2 = null ' +
                           ' , i_cod_me3 = null ' +
                           ' where i_cod_ven = ' + inttostr(CadVendedores.fieldByname('I_COD_ven').Asinteger));
  end;
  marca := CadVendedores.GetBookmark;
  MontaSelect;
  CadVendedores.GotoBookmark(marca);
  CadVendedores.FreeBookmark(marca);
end;

{**************************** botao somente com metas *************************}
procedure TFConfiguraComissoes.ProdutoNuloClick(Sender: TObject);
begin
 MontaSelect;
end;

{************************* ordem da grade *************************************}
procedure TFConfiguraComissoes.GridIndice1Ordem(Ordem: String);
begin
   OrdemConsulta := ordem;
end;



procedure TFConfiguraComissoes.meta1Select(Sender: TObject);
begin
  meta1.ASelectLocaliza.Clear;
  meta1.ASelectLocaliza.Add(' select * from cadmetacomissao where c_nom_met like ''@%'' '+
                            ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpfil));
  meta1.ASelectValida.Clear;
  meta1.ASelectValida.Add(' select * from cadmetacomissao where i_cod_met = @ ' +
                          ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpfil));
end;

procedure TFConfiguraComissoes.meta2Select(Sender: TObject);
begin
 if meta1.Text <> '' then
   begin
     meta2.ASelectLocaliza.Clear;
     meta2.ASelectLocaliza.Add(' select * from cadmetacomissao where c_nom_met like ''@%'' '+
                               ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpfil)+
                               ' and i_cod_met <> ' + meta1.text );
     meta2.ASelectValida.Clear;
     meta2.ASelectValida.Add(' select * from cadmetacomissao where i_cod_met = @ ' +
                             ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpfil) +
                             ' and i_cod_met <> ' + meta1.text );
   end
   else
     begin
       aviso('Meta 1 não pode estar vazia');
       abort;
     end;
end;

procedure TFConfiguraComissoes.meta3Select(Sender: TObject);
begin
 if (meta1.Text <> '') and (meta2.text <> '') then
   begin
     meta3.ASelectLocaliza.Clear;
     meta3.ASelectLocaliza.Add(' select * from cadmetacomissao where c_nom_met like ''@%'' '+
                               ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpfil)+
                               ' and i_cod_met <> ' + meta1.text +
                               ' and i_cod_met <> ' + meta2.text);
     meta3.ASelectValida.Clear;
     meta3.ASelectValida.Add(' select * from cadmetacomissao where i_cod_met = @ ' +
                             ' and i_emp_fil = ' + IntToStr(Varia.CodigoEmpfil) +
                             ' and i_cod_met <> ' + meta1.text +
                             ' and i_cod_met <> ' + meta2.text);
   end
   else
     begin
       aviso('Meta 1 e Meta 2 não podem estar vazias');
       abort;
     end;
end;

procedure TFConfiguraComissoes.MovCondicoesAfterPost(DataSet: TDataSet);
begin
  if PerCom <> MovCondicoesN_PER_COM.AsFloat Then
   begin
     if not(RecalculaComissao(MovCondicoesI_NRO_PAR.AsInteger)) Then
        extornaValorCom(PerCom);
     AtualizaMov;
   end;

   if PerPag <> MovCondicoesN_PER_PAG.AsFloat Then
   begin
     if not(RecalculaComissao(MovCondicoesI_NRO_PAR.AsInteger)) Then
        extornaValor(PerPag);
     AtualizaMov;
   end;

end;

procedure TFConfiguraComissoes.DBGridColor2ColExit(Sender: TObject);
begin
  if (DBGridColor2.SelectedIndex = 1) and (MovCondicoes.State in [dsedit,dsinsert]) Then
    GravaReg(MovCondicoes);
end;

procedure TFConfiguraComissoes.CadCondicoesAfterScroll(DataSet: TDataSet);
begin
  CarregaMovCondicoes(CadCondicoes.fieldByName('I_COD_PAG').AsInteger);
end;

procedure TFConfiguraComissoes.MovCondicoesAfterEdit(DataSet: TDataSet);
begin
   perPag := MovCondicoesN_PER_PAG.AsFloat;
   percom := MovCondicoesN_PER_com.AsFloat;
end;

procedure TFConfiguraComissoes.MovCondicoesAfterInsert(DataSet: TDataSet);
begin
  MovCondicoes.Cancel;
end;

procedure TFConfiguraComissoes.DBGridColor2Exit(Sender: TObject);
begin
  if MovCondicoes.State in [dsedit,dsinsert] Then
    GravaReg(MovCondicoes);
end;

procedure TFConfiguraComissoes.DBGridColor1Exit(Sender: TObject);
begin
  if CadCondicoes.State in [ dsedit ] then
    GravaReg(CadCondicoes);
end;

procedure TFConfiguraComissoes.MovCondicoesBeforePost(DataSet: TDataSet);
begin
  MovCondicoesD_ULT_ALT.AsDateTime := date;
end;

procedure TFConfiguraComissoes.CadCondicoesBeforePost(DataSet: TDataSet);
begin
  CadCondicoesD_ULT_ALT.AsDateTime := date;
end;

Initialization
 RegisterClasses([TFConfiguraComissoes]);
end.
