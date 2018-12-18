unit ASaldoAtual;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Grids,
  DBGrids, Tabela, Db, DBTables, ComCtrls, Mask, numericos;

type
  TFSaldoAtual = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BBAjuda: TBitBtn;
    SaldoAtual: TQuery;
    DataSaldoAtual: TDataSource;
    PanelColor3: TPanelColor;
    Data1: TCalendario;
    SaldoAtualConciliado: TQuery;
    DataSaldoAtualConciliado: TDataSource;
    SaldoAtualc_nro_con: TStringField;
    SaldoAtuallimite: TFloatField;
    SaldoAtualentrada: TFloatField;
    SaldoAtualsaida: TFloatField;
    SaldoAtualsaldo: TFloatField;
    SaldoAtualsaldoLimite: TFloatField;
    SaldoAtualConciliadoc_nro_con: TStringField;
    SaldoAtualConciliadolimite: TFloatField;
    SaldoAtualConciliadoentrada: TFloatField;
    SaldoAtualConciliadosaida: TFloatField;
    SaldoAtualConciliadosaldo: TFloatField;
    SaldoAtualConciliadosaldoLimite: TFloatField;
    Label1: TLabel;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    DBGridColor2: TDBGridColor;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    PanelColor7: TPanelColor;
    DBGridColor1: TDBGridColor;
    numerico3: Tnumerico;
    numerico4: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
  private
    procedure CalculaSaldoAtual;
    procedure CalculaSaldoAtualConciliado;
    procedure CalculaSAldo;
  public
    { Public declarations }
  end;

var
  FSaldoAtual: TFSaldoAtual;

implementation

uses APrincipal, funsql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFSaldoAtual.FormCreate(Sender: TObject);
begin
  data1.DateTime := date;
  CalculaSAldo;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSaldoAtual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaldoAtual.close;
  SaldoAtualConciliado.close;
  Action := CaFree;
end;

{******************** Calcula o saldo atual ********************************** }
procedure TFSaldoAtual.CalculaSaldoAtual;
begin
  AdicionaSQLAbreTabela(SaldoAtual,' Select mov.c_nro_con, sum(isnull(mov.N_VLR_ENT,0)) as entrada, ' +
                                   ' sum(isnull(mov.N_VLR_SAI,0)) as saida, entrada-saida saldo, ' +
                                   ' isnull(N_LIM_CRE,0) limite, saldo + limite saldoLimite ' +
                                   ' from  MovBancos  mov,  cadcontas con ' +
                                   ' where mov.C_CHE_CAN = ''N'' ' +
                                   ' and mov.D_DAT_COM <= ' + SQLTextoDataAAAAMMMDD(data1.DateTime)  +
                                   ' and mov.c_nro_con = con.c_nro_con ' +
                                   ' group by mov.c_nro_con, con.n_lim_cre ' );

end;

{******************** Calcula o saldo atual ********************************** }
procedure TFSaldoAtual.CalculaSaldoAtualConciliado;
begin
  AdicionaSQLAbreTabela(SaldoAtualConciliado,' Select mov.c_nro_con, sum(isnull(mov.N_VLR_ENT,0)) as entrada, ' +
                                   ' sum(isnull(mov.N_VLR_SAI,0)) as saida, entrada-saida saldo, ' +
                                   ' isnull(N_LIM_CRE,0) limite, saldo + limite saldoLimite ' +
                                   ' from  MovBancos mov,  cadcontas con' +
                                   ' where mov.C_CHE_CAN = ''N'' ' +
                                   ' and  mov.C_CON_BAN = ''S''' +
                                   ' and mov.D_DAT_COM <= ' + SQLTextoDataAAAAMMMDD(data1.DateTime)  +
                                   ' and mov.c_nro_con = con.c_nro_con '+
                                   ' group by mov.c_nro_con, con.n_lim_cre ' );

end;

procedure  TFSaldoAtual.CalculaSAldo;
var
  somaSaldo, somaconciliado : double;
begin
 CalculaSaldoAtual;
 CalculaSaldoAtualConciliado;
 somaSaldo := 0;
 somaconciliado := 0;
 while not SaldoAtual.Eof do
 begin
   somaSaldo := somaSaldo + SaldoAtualsaldo.AsCurrency;
   somaconciliado := somaconciliado + SaldoAtualsaldoLimite.AsCurrency;
   SaldoAtual.next;
 end;
 SaldoAtual.First;
 numerico1.AValor := somaSaldo;
 numerico2.AValor := somaconciliado;

 somaSaldo := 0;
 somaconciliado := 0;
 while not SaldoAtualConciliado.Eof do
 begin
   somaSaldo := somaSaldo + SaldoAtualConciliadosaldo.AsCurrency;
   somaconciliado := somaconciliado + SaldoAtualConciliadosaldoLimite.AsCurrency;
   SaldoAtualConciliado.next;
 end;
 SaldoAtualConciliado.First;
 numerico3.AValor := somaSaldo;
 numerico4.AValor := somaconciliado;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFSaldoAtual.BFecharClick(Sender: TObject);
begin
   self.close;
end;

procedure TFSaldoAtual.Data1CloseUp(Sender: TObject);
begin
  CalculaSAldo;
end;

Initialization
 RegisterClasses([TFSaldoAtual]);
end.
