USE dados2024;

SELECT 
    Registro_ans AS codigo_operadora,
    SUM(vl_saldo_final) AS total_despesas_sinistros
FROM 
    relatorio_cadop
INNER JOIN tri_4_2024 
    ON Registro_ans = REG_ANS -- Condição de junção obrigatória!
WHERE 
    cd_conta_contabil LIKE '4111%' 
    AND descricao LIKE '%EVENTOS%' -- Corrigi para "EVENTOS" (sem acento)
GROUP BY 
    REG_ANS
ORDER BY 
    total_despesas_sinistros DESC
LIMIT 10;



SELECT 
	relatorio_cadop as rc,
    rc.Registro_ANS AS codigo_operadora,
    rc.Razao_social AS nome_operadora,
    SUM(t1.vl_saldo_final + t2.vl_saldo_final + t3.vl_saldo_final + t4.vl_saldo_final) AS total_despesas_ano
FROM 
    relatorio_cadop rc
LEFT JOIN tri_1_2024 t1 ON rc.reg_ans = t1.reg_ans
LEFT JOIN tri_2_2024 t2 ON rc.reg_ans = t2.reg_ans
LEFT JOIN tri_3_2024 t3 ON rc.reg_ans = t3.reg_ans
LEFT JOIN tri_4_2024 t4 ON rc.reg_ans = t4.reg_ans
WHERE 
    (t1.cd_conta_contabil LIKE '4111%' OR 
     t2.cd_conta_contabil LIKE '4111%' OR 
     t3.cd_conta_contabil LIKE '4111%' OR 
     t4.cd_conta_contabil LIKE '4111%')
    AND 
    (t1.descricao LIKE '%EVENTOS%' OR 
     t2.descricao LIKE '%EVENTOS%' OR 
     t3.descricao LIKE '%EVENTOS%' OR 
     t4.descricao LIKE '%EVENTOS%')
GROUP BY 
    rc.reg_ans, rc.razao_social
ORDER BY 
    total_despesas_ano DESC
LIMIT 10;