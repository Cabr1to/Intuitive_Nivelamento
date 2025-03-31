USE dados2024;

/* 
Quais as 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU 
AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre? 
*/
SELECT 
    rc.Registro_ans AS codigo_operadora,
    rc.Nome_Fantasia AS nome_operadora,
    CONCAT('R$ ', FORMAT(ABS(SUM(t4.vl_saldo_final)), 2, 'de_DE')) AS total_despesas_sinistros
FROM 
    relatorio_cadop rc
INNER JOIN tri_4_2024 t4 
    ON rc.Registro_ans = t4.REG_ANS
WHERE 
    t4.descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
GROUP BY 
    rc.Registro_ans, 
    rc.Nome_Fantasia 
ORDER BY 
    SUM(t4.vl_saldo_final) ASC  
LIMIT 10;

/* 
Quais as 10 operadoras com maiores despesas nessa categoria no último ano?
*/
SELECT 
    rc.Registro_ans AS codigo_operadora,
    rc.Nome_Fantasia AS nome_operadora,
    CONCAT('R$ ', FORMAT(SUM(combined.vl_saldo_final), 2)) AS total_despesas_ano
FROM 
    relatorio_cadop rc
JOIN (
    SELECT REG_ANS, vl_saldo_final
    FROM tri_1_2024
    WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    UNION ALL
    SELECT REG_ANS, vl_saldo_final
    FROM tri_2_2024
    WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    UNION ALL
    SELECT REG_ANS, vl_saldo_final
    FROM tri_3_2024
    WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    UNION ALL
    SELECT REG_ANS, vl_saldo_final
    FROM tri_4_2024
    WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
) AS combined
ON rc.Registro_ans = combined.REG_ANS
GROUP BY 
    rc.Registro_ans, 
    rc.Nome_Fantasia 
ORDER BY 
    total_despesas_ano ASC
    LIMIT 10;
