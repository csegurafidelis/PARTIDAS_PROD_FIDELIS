/****** PARTIDA PRODUCCION PARTE 1 *******/
/****** PARTIDA PRODUCCION PARTE 2 *******/
/****** PARTIDA PRODUCCION PARTE 3 *******/
select COD_REAFIANZADOR, SUM(PRIMA_CEDIDA) PRIMA_CEDIDA, SUM(CUOTA_SIB) SIB, SUM(ISR) ISR, TIPO
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR,tipo


select t1.fianza Det_Fianza,
          t1.endoso Det_Endoso,
          t1.ex_year Det_Exyear,
          t1.cod_contrato Det_Capa,
          t1.cod_reafianzador Det_Cod_Reaf,
          t1.prima_cedida_original Det_Pcedida_Orig,
          t1.prima_cedida Det_Pcedida,
          t1.porcenta_participacion Det_Porcenta
from rea_det_distribucion t1
where t1.cod_contrato = 3
and t1.ramo = 'FIA' AND
t1.fianza IN
(
    select t1.fianza
    from cie_bordero t1
    where t1.ramo = 'FIA'
    and t1.anio = 2022
    and t1.mes between 1 and 1
    and nvl(t1.facul_prima_cedida,0) > 0)
AND t1.endoso in (
    select t1.endoso
    from cie_bordero t1
    where t1.ramo = 'FIA'
    and t1.anio = 2022
    and t1.mes between 1 and 1
    and nvl(t1.facul_prima_cedida,0) > 0
    )