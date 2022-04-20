
/****** PARTIDA PRODUCCION PARTE 1 *******/

select COD_REAFIANZADOR, SUM(CUOTA_SIB) SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, TIPO
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=03
and prima_cedida >0
GROUP BY COD_REAFIANZADOR, 'CUOTA SIB PRIMAS CEDIDAS', TIPO
UNION
select COD_REAFIANZADOR, SUM(ISR) ISR, 'ISR PRIMAS CEDIDAS' AS COMEN, TIPO
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=03
and prima_cedida >0
GROUP BY COD_REAFIANZADOR,'ISR PRIMAS CEDIDAS', TIPO
UNION
select det_cod_reaf, (Monto*.01) as SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'FCC' AS TIPO
from (
         select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
         FROM (
                  select t1.fianza                 Det_Fianza,
                         t1.endoso                 Det_Endoso,
                         t1.ex_year                Det_Exyear,
                         t1.cod_contrato           Det_Capa,
                         t1.cod_reafianzador       Det_Cod_Reaf,
                         t1.prima_cedida_original  Det_Pcedida_Orig,
                         t1.prima_cedida           Det_Pcedida,
                         t1.porcenta_participacion Det_Porcenta
                  from rea_det_distribucion t1
                  where t1.cod_contrato = 3
                    and t1.ramo= 'FCC'
                    AND t1.fianza IN
                        (
                            select t1.fianza
                            from cie_bordero t1
                            where t1.ramo ='FCC'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
                    AND t1.endoso in
                        (
                            select t1.endoso
                            from cie_bordero t1
                            where t1.ramo ='FCC'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
              ) T1
         GROUP BY det_cod_reaf
     ) tSIB
UNION
select det_cod_reaf, (Monto*.01) as SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'FIA' AS TIPO
from (
         select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
         FROM (
                  select t1.fianza                 Det_Fianza,
                         t1.endoso                 Det_Endoso,
                         t1.ex_year                Det_Exyear,
                         t1.cod_contrato           Det_Capa,
                         t1.cod_reafianzador       Det_Cod_Reaf,
                         t1.prima_cedida_original  Det_Pcedida_Orig,
                         t1.prima_cedida           Det_Pcedida,
                         t1.porcenta_participacion Det_Porcenta
                  from rea_det_distribucion t1
                  where t1.cod_contrato = 3
                    and t1.ramo= 'FIA'
                    AND t1.fianza IN
                        (
                            select t1.fianza
                            from cie_bordero t1
                            where t1.ramo ='FIA'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
                    AND t1.endoso in
                        (
                            select t1.endoso
                            from cie_bordero t1
                            where t1.ramo ='FIA'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
              ) T1
         GROUP BY det_cod_reaf
     ) tSIB
UNION
select det_cod_reaf, (Monto*.01) as SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'FCV' AS TIPO
from (
         select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
         FROM (
                  select t1.fianza                 Det_Fianza,
                         t1.endoso                 Det_Endoso,
                         t1.ex_year                Det_Exyear,
                         t1.cod_contrato           Det_Capa,
                         t1.cod_reafianzador       Det_Cod_Reaf,
                         t1.prima_cedida_original  Det_Pcedida_Orig,
                         t1.prima_cedida           Det_Pcedida,
                         t1.porcenta_participacion Det_Porcenta
                  from rea_det_distribucion t1
                  where t1.cod_contrato = 3
                    and t1.ramo= 'FCV'
                    AND t1.fianza IN
                        (
                            select t1.fianza
                            from cie_bordero t1
                            where t1.ramo ='FCV'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
                    AND t1.endoso in
                        (
                            select t1.endoso
                            from cie_bordero t1
                            where t1.ramo ='FCV'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
              ) T1
         GROUP BY det_cod_reaf
     ) tSIB
/**** ISR *****/
UNION
select det_cod_reaf, (Monto-(Monto*.01))*0.05 as ISR, 'ISR PRIMAS CEDIDAS' AS COMEN, 'FCC' AS TIPO
from (
         select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
         FROM (
                  select t1.fianza                 Det_Fianza,
                         t1.endoso                 Det_Endoso,
                         t1.ex_year                Det_Exyear,
                         t1.cod_contrato           Det_Capa,
                         t1.cod_reafianzador       Det_Cod_Reaf,
                         t1.prima_cedida_original  Det_Pcedida_Orig,
                         t1.prima_cedida           Det_Pcedida,
                         t1.porcenta_participacion Det_Porcenta
                  from rea_det_distribucion t1
                  where t1.cod_contrato = 3
                    and t1.ramo= 'FCC'
                    AND t1.fianza IN
                        (
                            select t1.fianza
                            from cie_bordero t1
                            where t1.ramo ='FCC'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
                    AND t1.endoso in
                        (
                            select t1.endoso
                            from cie_bordero t1
                            where t1.ramo ='FCC'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
              ) T1
         GROUP BY det_cod_reaf
     ) tSIB
UNION
select det_cod_reaf, (Monto-(Monto*.01))*0.05 as ISR, 'ISR PRIMAS CEDIDAS' AS COMEN, 'FIA' AS TIPO
from (
         select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
         FROM (
                  select t1.fianza                 Det_Fianza,
                         t1.endoso                 Det_Endoso,
                         t1.ex_year                Det_Exyear,
                         t1.cod_contrato           Det_Capa,
                         t1.cod_reafianzador       Det_Cod_Reaf,
                         t1.prima_cedida_original  Det_Pcedida_Orig,
                         t1.prima_cedida           Det_Pcedida,
                         t1.porcenta_participacion Det_Porcenta
                  from rea_det_distribucion t1
                  where t1.cod_contrato = 3
                    and t1.ramo= 'FIA'
                    AND t1.fianza IN
                        (
                            select t1.fianza
                            from cie_bordero t1
                            where t1.ramo ='FIA'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
                    AND t1.endoso in
                        (
                            select t1.endoso
                            from cie_bordero t1
                            where t1.ramo ='FIA'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
              ) T1
         GROUP BY det_cod_reaf
     ) tSIB
UNION
select det_cod_reaf, (Monto-(Monto*.01))*0.05 as ISR, 'ISR PRIMAS CEDIDAS' AS COMEN, 'FCV' AS TIPO
from (
         select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
         FROM (
                  select t1.fianza                 Det_Fianza,
                         t1.endoso                 Det_Endoso,
                         t1.ex_year                Det_Exyear,
                         t1.cod_contrato           Det_Capa,
                         t1.cod_reafianzador       Det_Cod_Reaf,
                         t1.prima_cedida_original  Det_Pcedida_Orig,
                         t1.prima_cedida           Det_Pcedida,
                         t1.porcenta_participacion Det_Porcenta
                  from rea_det_distribucion t1
                  where t1.cod_contrato = 3
                    and t1.ramo= 'FCV'
                    AND t1.fianza IN
                        (
                            select t1.fianza
                            from cie_bordero t1
                            where t1.ramo ='FCV'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
                    AND t1.endoso in
                        (
                            select t1.endoso
                            from cie_bordero t1
                            where t1.ramo ='FCV'
                              and t1.anio = 2022
                              and t1.mes between 3 and 3
                              and nvl(t1.facul_prima_cedida, 0) > 0
                        )
              ) T1
         GROUP BY det_cod_reaf
     ) tSIB
/*********************************************************************************************************************/
UNION
  select 1 AS DET_COD_REAF, SUM(DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))
      +DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0))) Prima_Neta_Cedida,
        'CUENTAS 6' AS COMEN,  SUBSTR(T1.CLASE,1,1) AS CLASE
  from cie_bordero  t1
  where t1.anio = 2022
  and t1.mes between 3 and 3
  and t1.ramo in('FIA','FCC','FCV')
  AND SUBSTR(T1.CLASE,1,1) IN ('A','B','C')
 GROUP BY SUBSTR(T1.CLASE,1,1)
UNION
select 1 as det_cod_reaf, sum(MONTO) as MONTO, 'ADMINISTRATIVOS ANTE  PARTICULARES' AS COMEN,TIPO
from (
          select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN, 'FCC' AS TIPO
          FROM (
                   select t1.fianza                 Det_Fianza,
                          t1.endoso                 Det_Endoso,
                          t1.ex_year                Det_Exyear,
                          t1.cod_contrato           Det_Capa,
                          t1.cod_reafianzador       Det_Cod_Reaf,
                          t1.prima_cedida_original  Det_Pcedida_Orig,
                          t1.prima_cedida           Det_Pcedida,
                          t1.porcenta_participacion Det_Porcenta
                   from rea_det_distribucion t1
                   where t1.cod_contrato = 3
                     and t1.ramo = 'FCC'
                     AND t1.fianza IN
                         (
                             select t1.fianza
                             from cie_bordero t1
                             where t1.ramo = 'FCC'
                               and t1.anio = 2022
                               and t1.mes between 3 and 3
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
                     AND t1.endoso in
                         (
                             select t1.endoso
                             from cie_bordero t1
                             where t1.ramo = 'FCC'
                               and t1.anio = 2022
                               and t1.mes between 3 and 3
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
               ) T1
          GROUP BY det_cod_reaf

          UNION

          select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN, 'FIA' AS TIPO
          FROM (
                   select t1.fianza                 Det_Fianza,
                          t1.endoso                 Det_Endoso,
                          t1.ex_year                Det_Exyear,
                          t1.cod_contrato           Det_Capa,
                          t1.cod_reafianzador       Det_Cod_Reaf,
                          t1.prima_cedida_original  Det_Pcedida_Orig,
                          t1.prima_cedida           Det_Pcedida,
                          t1.porcenta_participacion Det_Porcenta
                   from rea_det_distribucion t1
                   where t1.cod_contrato = 3
                     and t1.ramo = 'FIA'
                     AND t1.fianza IN
                         (
                             select t1.fianza
                             from cie_bordero t1
                             where t1.ramo = 'FIA'
                               and t1.anio = 2022
                               and t1.mes between 3 and 3
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
                     AND t1.endoso in
                         (
                             select t1.endoso
                             from cie_bordero t1
                             where t1.ramo = 'FIA'
                               and t1.anio = 2022
                               and t1.mes between 3 and 3
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
               ) T1
          GROUP BY det_cod_reaf, 'FIA'

          UNION

          select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN, 'FCV' as TIPO
          FROM (
                   select t1.fianza                 Det_Fianza,
                          t1.endoso                 Det_Endoso,
                          t1.ex_year                Det_Exyear,
                          t1.cod_contrato           Det_Capa,
                          t1.cod_reafianzador       Det_Cod_Reaf,
                          t1.prima_cedida_original  Det_Pcedida_Orig,
                          t1.prima_cedida           Det_Pcedida,
                          t1.porcenta_participacion Det_Porcenta
                   from rea_det_distribucion t1
                   where t1.cod_contrato = 3
                     and t1.ramo = 'FCV'
                     AND t1.fianza IN
                         (
                             select t1.fianza
                             from cie_bordero t1
                             where t1.ramo = 'FCV'
                               and t1.anio = 2022
                               and t1.mes between 3 and 3
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
                     AND t1.endoso in
                         (
                             select t1.endoso
                             from cie_bordero t1
                             where t1.ramo = 'FCV'
                               and t1.anio = 2022
                               and t1.mes between 3 and 3
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
               ) T1
          GROUP BY det_cod_reaf, 'FCV'
          UNION
          select COD_REAFIANZADOR,
                 SUM(PRIMA_CEDIDA)                            PRIMA_CEDIDA,
                 ('PRIMAS CEDIDAS ' || MES || '/' || ANIO) AS COMEN,
                 TIPO
          from csegura.PARTIDA_3_PRODUCCION_SAP
          where anio = 2022
            and mes = 03
            and prima_cedida > 0
          GROUP BY COD_REAFIANZADOR, ('PRIMAS CEDIDAS ' || MES || '/' || ANIO), TIPO
  )t1
where TIPO='FCC'
GROUP BY 'ADMINISTRATIVOS ANTE  PARTICULARES', TIPO
;


/****** PARTIDA PRODUCCION PARTE 2 *******/
select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN, 'FCC' AS TIPO
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
        and t1.mes between 3 and 3
        and nvl(t1.facul_prima_cedida,0) > 0
    )
    AND t1.endoso in
    (
        select t1.endoso
        from cie_bordero t1
        where t1.ramo = 'FCC'
        and t1.anio = 2022
        and t1.mes between 3 and 3
        and nvl(t1.facul_prima_cedida,0) > 0
    )
) T1
GROUP BY det_cod_reaf

UNION

select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO ,('PRIMAS FACTULTATIVAS') AS COMEN, 'FIA' AS TIPO
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
        and t1.mes between 3 and 3
        and nvl(t1.facul_prima_cedida,0) > 0
    )
    AND t1.endoso in
    (
        select t1.endoso
        from cie_bordero t1
        where t1.ramo = 'FIA'
        and t1.anio = 2022
        and t1.mes between 3 and 3
        and nvl(t1.facul_prima_cedida,0) > 0
    )
) T1
GROUP BY det_cod_reaf, 'FIA'

UNION

select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO, ('PRIMAS FACTULTATIVAS') AS COMEN, 'FCV' as TIPO
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
        from cie_bordero_fcv t1
        where t1.ramo = 'FCV'
        and t1.anio = 2022
        and t1.mes between 3 and 3
        and nvl(t1.facul_prima_cedida,0) > 0
    )
    AND t1.endoso in
    (
        select t1.endoso
        from cie_bordero_fcv t1
        where t1.ramo = 'FCV'
        and t1.anio = 2022
        and t1.mes between 3 and 3
        and nvl(t1.facul_prima_cedida,0) > 0
    )
) T1
GROUP BY det_cod_reaf, 'FCV'
UNION
select COD_REAFIANZADOR, SUM(PRIMA_CEDIDA) PRIMA_CEDIDA, ('PRIMAS CEDIDAS '||MES||'/'||ANIO) AS COMEN, TIPO
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=03
and prima_cedida >0
GROUP BY COD_REAFIANZADOR,  ('PRIMAS CEDIDAS '||MES||'/'||ANIO), TIPO
UNION
SELECT 2 AS DET_COD_REAF, ROUND(SUM(SIB),2) as MONTO, COMEN, TIPO
FROM (
         select SUM(CUOTA_SIB) SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'SIB' AS TIPO
         from csegura.PARTIDA_3_PRODUCCION_SAP
         where anio = 2022
           and mes = 03
           and prima_cedida > 0
         GROUP BY 'CUOTA SIB PRIMAS CEDIDAS'
         UNION
         select SUM(ISR) ISR, 'ISR PRIMAS CEDIDAS' AS COMEN, 'ISR' AS TIPO
         from csegura.PARTIDA_3_PRODUCCION_SAP
         where anio = 2022
           and mes = 03
           and prima_cedida > 0
         GROUP BY 'ISR PRIMAS CEDIDAS'
         UNION
         select sum(SIB), COMEN, TIPO
         from
              (
                  select det_cod_reaf, (Monto * .01) as SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'SIB' AS TIPO
                  from (
                           select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
                           FROM (
                                    select t1.fianza                 Det_Fianza,
                                           t1.endoso                 Det_Endoso,
                                           t1.ex_year                Det_Exyear,
                                           t1.cod_contrato           Det_Capa,
                                           t1.cod_reafianzador       Det_Cod_Reaf,
                                           t1.prima_cedida_original  Det_Pcedida_Orig,
                                           t1.prima_cedida           Det_Pcedida,
                                           t1.porcenta_participacion Det_Porcenta
                                    from rea_det_distribucion t1
                                    where t1.cod_contrato = 3
                                      and t1.ramo = 'FCC'
                                      AND t1.fianza IN
                                          (
                                              select t1.fianza
                                              from cie_bordero t1
                                              where t1.ramo = 'FCC'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                      AND t1.endoso in
                                          (
                                              select t1.endoso
                                              from cie_bordero t1
                                              where t1.ramo = 'FCC'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                ) T1
                           GROUP BY det_cod_reaf
                       ) tSIB
                  UNION
                  select det_cod_reaf, (Monto * .01) as SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'SIB' AS TIPO
                  from (
                           select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
                           FROM (
                                    select t1.fianza                 Det_Fianza,
                                           t1.endoso                 Det_Endoso,
                                           t1.ex_year                Det_Exyear,
                                           t1.cod_contrato           Det_Capa,
                                           t1.cod_reafianzador       Det_Cod_Reaf,
                                           t1.prima_cedida_original  Det_Pcedida_Orig,
                                           t1.prima_cedida           Det_Pcedida,
                                           t1.porcenta_participacion Det_Porcenta
                                    from rea_det_distribucion t1
                                    where t1.cod_contrato = 3
                                      and t1.ramo = 'FIA'
                                      AND t1.fianza IN
                                          (
                                              select t1.fianza
                                              from cie_bordero t1
                                              where t1.ramo = 'FIA'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                      AND t1.endoso in
                                          (
                                              select t1.endoso
                                              from cie_bordero t1
                                              where t1.ramo = 'FIA'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                ) T1
                           GROUP BY det_cod_reaf
                       ) tSIB
                  UNION
                  select det_cod_reaf, (Monto * .01) as SIB, 'CUOTA SIB PRIMAS CEDIDAS' AS COMEN, 'SIB' AS TIPO
                  from (
                           select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
                           FROM (
                                    select t1.fianza                 Det_Fianza,
                                           t1.endoso                 Det_Endoso,
                                           t1.ex_year                Det_Exyear,
                                           t1.cod_contrato           Det_Capa,
                                           t1.cod_reafianzador       Det_Cod_Reaf,
                                           t1.prima_cedida_original  Det_Pcedida_Orig,
                                           t1.prima_cedida           Det_Pcedida,
                                           t1.porcenta_participacion Det_Porcenta
                                    from rea_det_distribucion t1
                                    where t1.cod_contrato = 3
                                      and t1.ramo = 'FCV'
                                      AND t1.fianza IN
                                          (
                                              select t1.fianza
                                              from cie_bordero t1
                                              where t1.ramo = 'FCV'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                      AND t1.endoso in
                                          (
                                              select t1.endoso
                                              from cie_bordero t1
                                              where t1.ramo = 'FCV'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                ) T1
                           GROUP BY det_cod_reaf
                       ) tSIB
/**** ISR *****/
                  UNION
                  select det_cod_reaf,
                         (Monto - (Monto * .01)) * 0.05 as ISR,
                         'ISR PRIMAS CEDIDAS'           AS COMEN,
                         'ISR'                          AS TIPO
                  from (
                           select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
                           FROM (
                                    select t1.fianza                 Det_Fianza,
                                           t1.endoso                 Det_Endoso,
                                           t1.ex_year                Det_Exyear,
                                           t1.cod_contrato           Det_Capa,
                                           t1.cod_reafianzador       Det_Cod_Reaf,
                                           t1.prima_cedida_original  Det_Pcedida_Orig,
                                           t1.prima_cedida           Det_Pcedida,
                                           t1.porcenta_participacion Det_Porcenta
                                    from rea_det_distribucion t1
                                    where t1.cod_contrato = 3
                                      and t1.ramo = 'FCC'
                                      AND t1.fianza IN
                                          (
                                              select t1.fianza
                                              from cie_bordero t1
                                              where t1.ramo = 'FCC'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                      AND t1.endoso in
                                          (
                                              select t1.endoso
                                              from cie_bordero t1
                                              where t1.ramo = 'FCC'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                ) T1
                           GROUP BY det_cod_reaf
                       ) tSIB
                  UNION
                  select det_cod_reaf,
                         (Monto - (Monto * .01)) * 0.05 as ISR,
                         'ISR PRIMAS CEDIDAS'           AS COMEN,
                         'ISR'                          AS TIPO
                  from (
                           select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
                           FROM (
                                    select t1.fianza                 Det_Fianza,
                                           t1.endoso                 Det_Endoso,
                                           t1.ex_year                Det_Exyear,
                                           t1.cod_contrato           Det_Capa,
                                           t1.cod_reafianzador       Det_Cod_Reaf,
                                           t1.prima_cedida_original  Det_Pcedida_Orig,
                                           t1.prima_cedida           Det_Pcedida,
                                           t1.porcenta_participacion Det_Porcenta
                                    from rea_det_distribucion t1
                                    where t1.cod_contrato = 3
                                      and t1.ramo = 'FIA'
                                      AND t1.fianza IN
                                          (
                                              select t1.fianza
                                              from cie_bordero t1
                                              where t1.ramo = 'FIA'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                      AND t1.endoso in
                                          (
                                              select t1.endoso
                                              from cie_bordero t1
                                              where t1.ramo = 'FIA'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                ) T1
                           GROUP BY det_cod_reaf
                       ) tSIB
                  UNION
                  select det_cod_reaf,
                         (Monto - (Monto * .01)) * 0.05 as ISR,
                         'ISR PRIMAS CEDIDAS'           AS COMEN,
                         'ISR'                          AS TIPO
                  from (
                           select det_cod_reaf, sum(DET_PCEDIDA) AS MONTO
                           FROM (
                                    select t1.fianza                 Det_Fianza,
                                           t1.endoso                 Det_Endoso,
                                           t1.ex_year                Det_Exyear,
                                           t1.cod_contrato           Det_Capa,
                                           t1.cod_reafianzador       Det_Cod_Reaf,
                                           t1.prima_cedida_original  Det_Pcedida_Orig,
                                           t1.prima_cedida           Det_Pcedida,
                                           t1.porcenta_participacion Det_Porcenta
                                    from rea_det_distribucion t1
                                    where t1.cod_contrato = 3
                                      and t1.ramo = 'FCV'
                                      AND t1.fianza IN
                                          (
                                              select t1.fianza
                                              from cie_bordero t1
                                              where t1.ramo = 'FCV'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                      AND t1.endoso in
                                          (
                                              select t1.endoso
                                              from cie_bordero t1
                                              where t1.ramo = 'FCV'
                                                and t1.anio = 2022
                                                and t1.mes between 3 and 3
                                                and nvl(t1.facul_prima_cedida, 0) > 0
                                          )
                                ) T1
                           GROUP BY det_cod_reaf
                       ) tSIB
              ) t1
         GROUP BY COMEN,TIPO
     )t2
GROUP BY COMEN, TIPO;