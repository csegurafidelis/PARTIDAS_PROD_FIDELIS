

select distinct t2.cod_reafianzador, t1.ex_year, t2.porcenta_participacion
from rea_det_contrato t2,
     cie_bordero t1,
     rea_reafianzador t3
where t2.ramo = t1.ramo
and t2.ex_year = t1.ex_year
and t2.cod_contrato in (1,2)
and  t1.anio = 2022
and t1.mes between 2 and 2
and t1.ramo = 'FIA'
and t3.cod_reafianzador = t2.cod_reafianzador;


select ex_year, sum(Prima_Neta_Cedida) as Prima_Neta_Cedida
from
     (
select t1.ex_year,
DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))
    +DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) Prima_Neta_Cedida
from cie_bordero t1
where t1.anio = 2022
and t1.mes between 2 and 2
and ramo = 'FIA')
group by ex_year;

/********************/
select FIANZA, ENDOSO, substr(t1.clase,1,1) Clase, t1.ex_year,
DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))
    +DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) Prima_Neta_Cedida
from cie_bordero t1
where t1.anio = 2022
and t1.mes between 2 and 2
and ramo = 'FIA';

/*******/
/**********************************************************************************/

select ex_year, sum(Prima_Neta_Cedida) Prima_Neta_Cedida, ramo
from (
select t1.ex_year,
DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))+DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) Prima_Neta_Cedida,
       t1.ramo
from cie_bordero t1
where t1.anio = 2022
and t1.mes between 2 and 2
and t1.ramo IN ('FCC','FIA')
order by  t1.mes)
group by ex_year, ramo;

     select cod_reafianzador, (reg.Prima_Neta_Cedida *(porcenta_participacion/100)) as Monto, p_anio anio, p_mes mes, reg.ex_year,
            ((reg.Prima_Neta_Cedida *(porcenta_participacion/100)) *(1/100)) Cuota_SIB,
       ((reg.Prima_Neta_Cedida *(porcenta_participacion/100))-((reg.Prima_Neta_Cedida *(porcenta_participacion/100)) *(1/100)))*0.05 ISR,
       ramo
      from
      (
          select distinct t2.cod_reafianzador, t1.ex_year, t2.porcenta_participacion,t1.ramo
          from rea_det_contrato t2,
               cie_bordero t1,
               rea_reafianzador t3
          where t2.ramo = t1.ramo
          and t2.ex_year = t1.ex_year
          and t2.cod_contrato in (1,2)
          and  t1.anio = 2022
          and t1.mes between 1 and 1
          and t1.ramo in('FIA','FCC','FCV')
          and t3.cod_reafianzador = t2.cod_reafianzador
      ) where ex_year= reg.ex_year and ramo= reg.ramo;

select COD_REAFIANZADOR, SUM(PRIMA_CEDIDA) PRIMA_CEDIDA, SUM(CUOTA_SIB) SIB, SUM(ISR) ISR, TIPO
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR,tipo;


/******/
/******/
SELECT * FROM (
select t1.anio || ' / ' || t1.mes AnioMes, t1.ex_year,
DECODE(t1.tipo_endoso,'4',nvl(t1.facul_prima_cedida_original,0)*-1,nvl(t1.facul_prima_cedida_original,0)) Prima_Orig_Cedida,
DECODE(t1.tipo_endoso,'4',nvl(t1.facul_prima_cedida,0)*-1,nvl(t1.facul_prima_cedida,0)) Prima_Neta_Cedida
from cie_bordero t1
where t1.ramo = 'FIA'
and t1.anio = 2022
and t1.mes between 2 and 2
order by t1.anio, t1.mes) t1 where Prima_Neta_Cedida > 0;

select t1.anio || ' / ' || t1.mes Lista_AnioMes,  t1.fianza Lista_Fianza, t1.endoso Lista_Endoso, t1.ex_year Lista_ExYear, t1.tipo_endoso Lista_TipoEndoso,
DECODE(t1.tipo_endoso,'4',nvl(t1.facul_prima_cedida_original,0)*-1,nvl(t1.facul_prima_cedida_original,0)) Lista_Prima_Orig_Cedida,
DECODE(t1.tipo_endoso,'4',nvl(t1.facul_prima_cedida,0)*-1,nvl(t1.facul_prima_cedida,0))   Lista_Prima_Neta_Cedida
from cie_bordero t1
where t1.ramo = 'FIA'
and t1.anio = 2022
and t1.mes between 2 and 2
and nvl(t1.facul_prima_cedida,0) > 0
order by t1.anio, t1.mes, t1.clase, t1.fianza, t1.endoso;

select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
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
GROUP BY det_cod_reaf;

