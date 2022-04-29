select substr(t1.clase,1,1) cl,t1.mes,t1.clase,t1.ramo,t1.fianza,t1.endoso, t1.prima_anual,
       t1.ex_year,t1.monto_afianzado,t2.descripcion,
    SUM( DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0)) +
		          DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) +
		          DECODE(t1.tipo_endoso,'4',nvl(t1.facul_prima_cedida,0)*-1,nvl(t1.facul_prima_cedida,0))
		         ) Prima_Cedida
		from cie_bordero_fcv t1,fia_tipo_endoso t2
		where ramo = 'FCV'
        and t1.tipo_endoso = t2.tipo_endoso
		  and t1.anio = 2022
		 and t1.mes = 02

		 and (t1.tipo_endoso IN (1,0,10) or exists(select t4.fianza
                                            from fia_endoso t4
                                           where t4.fianza = t1.fianza
                                             and t4.endoso = t1.endoso
                                             and t4.tipo_endoso in (3,4)
                                             and t4.correccion_sn ='S'))
         group by substr(t1.clase,1,1),t1.mes,t1.clase,t1.ramo,t1.ramo,t1.fianza,t1.endoso, t1.prima_anual,t1.ex_year,t1.monto_afianzado,t2.descripcion
         union
         select substr(t1.clase,1,1) cl,t1.mes,t1.clase,t1.ramo,t1.fianza,t1.endoso, t1.prima_anual,t1.ex_year,t1.monto_afianzado,t2.descripcion,
		     SUM( DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0)) +
		          DECODE(t1.tipo_endoso,'4',notenvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) +
		          DECODE(t1.tipo_endoso,'4',nvl(t1.facul_prima_cedida,0)*-1,nvl(t1.facul_prima_cedida,0))
		         ) Prima_Cedida
		from cie_bordero t1,fia_tipo_endoso t2
		 where t1.anio = 2022
		 and t1.mes = 02
          and t1.tipo_endoso = t2.tipo_endoso
		group by substr(t1.clase,1,1),t1.mes,t1.clase,t1.ramo,t1.fianza,t1.endoso, t1.prima_anual,t1.ex_year,t1.monto_afianzado,t2.descripcion
        order by 2 asc;




 select ex_year, SUM(DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))) Prima_Cedida
	  from cie_bordero t1
	 where t1.ramo = 'FIA'
	   and t1.anio = '2022'
	   and t1.mes between 2 and 2
	   and ex_year > 2005
group by Ex_year ;


select distinct t2.cod_reafianzador, t2.cod_contrato Capa, t1.ex_year, t2.porcenta_participacion, t3.cod_region
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


select t1.anio || ' / ' || t1.mes AnioMes, t1.ex_year, t1.mes,
DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida_original,0)*-1,nvl(t1.capa1_prima_cedida_original,0))+DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida_original,0)*-1,nvl(t1.capa2_prima_cedida_original,0)) Prima_Orig_Cedida,
DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))+DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) Prima_Neta_Cedida
from cie_bordero t1
where t1.anio = 2022
and t1.mes between 2 and 2
and ramo = 'FIA'
order by  t1.mes;

select FIANZA, ENDOSO, substr(t1.clase,1,1) Clase, t1.ex_year,
DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))
    +DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) Prima_Neta_Cedida
from cie_bordero t1
where t1.anio = 2022
and t1.mes between 2 and 2
and ramo = 'FIA';


select * from cie_bordero;



select * from
              (

select COD_REAFIANZADOR
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR
UNION
select COD_REAFIANZADOR
from csegura.PARTIDA_3_PRODUCCION_SAP
where anio=2022 and mes=02
and prima_cedida >0
GROUP BY COD_REAFIANZADOR
) T1 INNER JOIN





  select ex_year, sum(Prima_Neta_Cedida) Prima_Neta_Cedida,
  ramo
  from (
  select t1.ex_year,
  DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))+DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) Prima_Neta_Cedida,
  t1.ramo
  from cie_bordero t1
  where t1.anio = 2022
  and t1.mes between 2 and 2
  and t1.ramo in('FIA','FCC','FCV')
  order by  t1.mes)
  group by ex_year, ramo;

SELECT * FROM CIE_BORDERO;





/********************************************/
  select 1 AS DET_COD_REAF, SUM(DECODE(t1.tipo_endoso,'4',nvl(t1.capa1_prima_cedida,0)*-1,nvl(t1.capa1_prima_cedida,0))
      +DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0))) Prima_Neta_Cedida,
        'CUENTAS 6' AS COMEN,  SUBSTR(T1.CLASE,1,1) AS CLASE
  from cie_bordero  t1
  where t1.anio = 2022
  and t1.mes between 2 and 2
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
                               and t1.mes between 2 and 2
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
                     AND t1.endoso in
                         (
                             select t1.endoso
                             from cie_bordero t1
                             where t1.ramo = 'FCC'
                               and t1.anio = 2022
                               and t1.mes between 2 and 2
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
                               and t1.mes between 2 and 2
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
                     AND t1.endoso in
                         (
                             select t1.endoso
                             from cie_bordero t1
                             where t1.ramo = 'FIA'
                               and t1.anio = 2022
                               and t1.mes between 2 and 2
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
                               and t1.mes between 2 and 2
                               and nvl(t1.facul_prima_cedida, 0) > 0
                         )
                     AND t1.endoso in
                         (
                             select t1.endoso
                             from cie_bordero t1
                             where t1.ramo = 'FCV'
                               and t1.anio = 2022
                               and t1.mes between 2 and 2
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
            and mes = 02
            and prima_cedida > 0
          GROUP BY COD_REAFIANZADOR, ('PRIMAS CEDIDAS ' || MES || '/' || ANIO), TIPO
  )t1
where TIPO='FCC'
GROUP BY 'ADMINISTRATIVOS ANTE  PARTICULARES', TIPO;
