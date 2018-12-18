unit AAlteraParcelaCartao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, UnContasaReceber, UnComissoes1, StdCtrls, Buttons;

type
  TFAlteraParcelaCartao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DBGridColor1: TDBGridColor;
    Parcela: TQuery;
    DataParcela: TDataSource;
    Aux: TQuery;
    ParcelaI_EMP_FIL: TIntegerField;
    ParcelaI_LAN_REC: TIntegerField;
    ParcelaI_NRO_PAR: TIntegerField;
    ParcelaI_COD_FRM: TIntegerField;
    ParcelaC_NRO_CON: TStringField;
    ParcelaD_DAT_VEN: TDateField;
    ParcelaD_DAT_PAG: TDateField;
    ParcelaN_VLR_PAR: TFloatField;
    ParcelaN_VLR_DES: TFloatField;
    ParcelaN_VLR_ACR: TFloatField;
    ParcelaN_TOT_PAR: TFloatField;
    ParcelaN_VLR_PAG: TFloatField;
    ParcelaN_PER_MOR: TFloatField;
    ParcelaN_PER_JUR: TFloatField;
    ParcelaN_PER_MUL: TFloatField;
    ParcelaN_PER_COR: TFloatField;
    ParcelaC_NRO_DOC: TStringField;
    ParcelaI_COD_USU: TIntegerField;
    ParcelaN_VLR_ENT: TFloatField;
    ParcelaI_COD_BAN: TIntegerField;
    ParcelaC_NRO_DUP: TStringField;
    ParcelaN_DES_VEN: TFloatField;
    ParcelaC_FLA_PAR: TStringField;
    ParcelaL_OBS_REC: TMemoField;
    ParcelaI_PAR_FIL: TIntegerField;
    ParcelaI_PAR_MAE: TIntegerField;
    ParcelaI_DIA_CAR: TIntegerField;
    ParcelaN_PER_ACR: TFloatField;
    ParcelaN_PER_DES: TFloatField;
    ParcelaI_FIL_PAG: TIntegerField;
    ParcelaC_DUP_CAN: TStringField;
    ParcelaI_LAN_BAC: TIntegerField;
    ParcelaN_VLR_ADI: TFloatField;
    ParcelaI_COD_SIT: TIntegerField;
    ParcelaI_NUM_BOR: TIntegerField;
    ParcelaC_FLA_CAR: TStringField;
    ParcelaC_FLA_BOL: TStringField;
    ParcelaC_FLA_DUP: TStringField;
    ParcelaC_NRO_CHE: TStringField;
    ParcelaD_CHE_VEN: TDateField;
    ParcelaI_COD_MOE: TIntegerField;
    ParcelaI_SEQ_TEF: TIntegerField;
    BitBtn1: TBitBtn;
    Comissao: TQuery;
    BBAjuda: TBitBtn;
    ParcelaD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ParcelaAfterInsert(DataSet: TDataSet);
    procedure ParcelaAfterPost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure ParcelaBeforePost(DataSet: TDataSet);
  private
    UnCR : TFuncoesContasAReceber;
    UnCom : TFuncoesComissao;
  public
    procedure CarregaAlterarcao( LancamentoCR : integer );
  end;

var
  FAlteraParcelaCartao: TFAlteraParcelaCartao;

implementation

uses APrincipal, constantes, funsql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraParcelaCartao.FormCreate(Sender: TObject);
begin
  UnCR := TFuncoesContasAReceber.criar(self, FPrincipal.BaseDados);
  UnCom := TFuncoesComissao.criar(self, FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraParcelaCartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnCR.Free;
  UnCom.Free;
  Aux.close;
  Parcela.close;
  Comissao.close;
  Action := CaFree;
end;

procedure TFAlteraParcelaCartao.CarregaAlterarcao( LancamentoCR : integer );
begin
  AdicionaSQLAbreTabela( Parcela, ' Select * from movcontasareceber ' +
                                  ' where i_lan_rec = ' + IntTostr(LancamentoCR )  +
                                  ' and i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) +
                                  ' order by i_nro_par '  );
  AdicionaSQLAbreTabela( Aux,     ' Select * from movcontasareceber ' +
                                  ' where i_lan_rec = ' + IntTostr(LancamentoCR )  +
                                  ' and i_emp_fil = ' + IntToStr(varia.CodigoEmpFil)  );
  self.ShowModal;
end;

procedure TFAlteraParcelaCartao.ParcelaAfterInsert(DataSet: TDataSet);
var
  laco : integer;
begin
  for laco := 0 to Parcela.FieldCount - 1 do
    Parcela.Fields[laco].Value := Aux.Fields[laco].Value;
  ParcelaN_VLR_PAR.Clear;
  ParcelaD_DAT_VEN.clear;
  ParcelaI_NRO_PAR.AsInteger := UnCR.GeraNroProximoParcela(aux.fieldByName('I_LAN_REC').AsInteger);
end;

procedure TFAlteraParcelaCartao.ParcelaAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(Parcela);
  Parcela.last;
end;

procedure TFAlteraParcelaCartao.BitBtn1Click(Sender: TObject);
var
  valorTotal : Double;
begin
  valorTotal := UnCR.AtualizaValorTotal(aux.fieldByName('I_LAN_REC').AsInteger);
//  UnCom.AtualizaComissaoCartao(aux.fieldByName('I_LAN_REC').AsInteger);
  self.close;
end;


procedure TFAlteraParcelaCartao.BBAjudaClick(Sender: TObject);
begin
      Application.HelpCommand(HELP_CONTEXT,FAlteraParcelaCartao.HelpContext);
end;

procedure TFAlteraParcelaCartao.ParcelaBeforePost(DataSet: TDataSet);
begin
   ParcelaD_ULT_ALT.AsDateTime := date;
end;

Initialization
 RegisterClasses([TFAlteraParcelaCartao]);

end.
