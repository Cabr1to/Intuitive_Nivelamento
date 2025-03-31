use dados2024;

CREATE TABLE IF NOT EXISTS tri_4_2024 (
    DATA DATE,
    REG_ANS VARCHAR(10),
    CD_CONTA_CONTABIL VARCHAR(20),
    DESCRICAO VARCHAR(255),
    VL_SALDO_INICIAL DECIMAL(15,2),
    VL_SALDO_FINAL DECIMAL(15,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4T2024.csv'
INTO TABLE tri_4_2024
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, 
 @VL_SALDO_INICIAL, @VL_SALDO_FINAL)
SET 
    DATA = STR_TO_DATE(@DATA, '%Y-%m-%d'),
    VL_SALDO_INICIAL = REPLACE(REPLACE(@VL_SALDO_INICIAL, '.', ''), ',', '.'),
    VL_SALDO_FINAL = REPLACE(REPLACE(@VL_SALDO_FINAL, '.', ''), ',', '.');


SELECT * FROM tri_4_2024;

DESCRIBE tri_4_2024;