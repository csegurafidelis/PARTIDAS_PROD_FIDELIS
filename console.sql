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
		          DECODE(t1.tipo_endoso,'4',nvl(t1.capa2_prima_cedida,0)*-1,nvl(t1.capa2_prima_cedida,0)) +
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
