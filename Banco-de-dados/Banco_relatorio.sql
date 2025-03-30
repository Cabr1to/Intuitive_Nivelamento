use dados2024;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN DDD VARCHAR(10) NULL;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN Telefone VARCHAR(20) NULL;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN Fax VARCHAR(20) NULL;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN Regiao_de_Comercializacao INT NULL;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN Numero VARCHAR(20) NULL;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN Nome_Fantasia VARCHAR(255) NULL;

ALTER TABLE relatorio_cadop 
MODIFY COLUMN Complemento VARCHAR(100) NULL;

ALTER TABLE relatorio_cadop
MODIFY COLUMN Representante VARCHAR(255) NULL;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Relatorio_cadop.csv'
INTO TABLE relatorio_cadop
CHARACTER SET latin1
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, Modalidade, Logradouro, Numero,
 Complemento, Bairro, Cidade, UF, CEP, @DDD, @Telefone, @Fax, Endereco_eletronico,
 Representante, Cargo_Representante, @Regiao_var, 
 @Data_Registro_ANS)
SET 
    DDD = NULLIF(@DDD, ''),
    Telefone = NULLIF(@Telefone, ''),
    Fax = NULLIF(@Fax, ''),
    Regiao_de_Comercializacao = NULLIF(@Regiao_var, ''),
    Data_Registro_ANS = STR_TO_DATE(NULLIF(TRIM(@Data_Registro_ANS), ''), '%d/%m/%Y');
    
    
SELECT * FROM relatorio_cadop;
describe relatorio_cadop;

