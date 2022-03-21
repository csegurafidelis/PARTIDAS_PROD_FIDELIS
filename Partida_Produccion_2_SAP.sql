/****** PARTIDA PRODUCCION PARTE 1 *******/

select COD_REAFIANZADOR, SUM(CUOTA_SIB) SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR, 'CUOTA SIB PRIMAS CEDIDAS', TIPO
UNION
select COD_REAFIANZADOR, SUM(ISR) ISR, 'ISR PRIMAS CEDIDAS' AS COMEN
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR,'ISR PRIMAS CEDIDAS', TIPO;

/****** PARTIDA PRODUCCION PARTE 2 *******/
select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN
FROM (
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
    and t1.ramo = 'FCC' AND
    t1.fianza IN
    (
        select t1.fianza
        from cie_bordero t1
        where t1.ramo = 'FCC'
        and t1.anio = 2022
        and t1.mes between 2 and 2
        and nvl(t1.facul_prima_cedida,0) > 0
    )
    AND t1.endoso in
    (
        select t1.endoso
        from cie_bordero t1
        where t1.ramo = 'FCC'
        and t1.anio = 2022
        and t1.mes between 2 and 2
        and nvl(t1.facul_prima_cedida,0) > 0
    )
) T1
GROUP BY det_cod_reaf

UNION

select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO ,('PRIMAS FACTULTATIVAS') AS COMEN
FROM (
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
        and t1.mes between 2 and 2
        and nvl(t1.facul_prima_cedida,0) > 0
    )
    AND t1.endoso in
    (
        select t1.endoso
        from cie_bordero t1
        where t1.ramo = 'FIA'
        and t1.anio = 2022
        and t1.mes between 2 and 2
        and nvl(t1.facul_prima_cedida,0) > 0
    )
) T1
GROUP BY det_cod_reaf

UNION

select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN
FROM (
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
    and t1.ramo = 'FCV' AND
    t1.fianza IN
    (
        select t1.fianza
        from cie_bordero t1
        where t1.ramo = 'FCV'
        and t1.anio = 2022
        and t1.mes between 2 and 2
        and nvl(t1.facul_prima_cedida,0) > 0
    )
    AND t1.endoso in
    (
        select t1.endoso
        from cie_bordero t1
        where t1.ramo = 'FCV'
        and t1.anio = 2022
        and t1.mes between 2 and 2
        and nvl(t1.facul_prima_cedida,0) > 0
    )
) T1
GROUP BY det_cod_reaf
UNION
select COD_REAFIANZADOR, SUM(PRIMA_CEDIDA) PRIMA_CEDIDA, ('PRIMAS CEDIDAS '||MES||'/'||ANIO) AS COMEN
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR,  ('PRIMAS CEDIDAS '||MES||'/'||ANIO), TIPO;

/****** PARTIDA PRODUCCION PARTE 3 *******/


/****/
select SUM(CUOTA_SIB) SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY 'CUOTA SIB PRIMAS CEDIDAS'
UNION
select SUM(ISR) ISR, 'ISR PRIMAS CEDIDAS' AS COMEN
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY 'ISR PRIMAS CEDIDAS';


/***/


