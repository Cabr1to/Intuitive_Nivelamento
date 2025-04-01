from django.db import models


class TabelaRelatorio(models.Model):
    Registro_ANS = models.IntegerField()
    CNPJ = models.CharField(max_length=15)
    Nome_Fantasia = models.CharField(max_length=255)
    Modalidade = models.CharField(max_length=255)
    Logradouro = models.CharField(max_length=255)
    Numero = models.CharField(max_length=20)
    Complemento = models.CharField(max_length=255)
    Bairro = models.CharField(max_length=255)
    Cidade = models.CharField(max_length=255)
    UF = models.CharField(max_length=3)
    CEP = models.BigIntegerField()
    DDD = models.CharField(max_length=4)
    Telefono = models.CharField(max_length=20)
    Fax = models.CharField(max_length=20)
    Endereco_eletronico = models.CharField(max_length=255)
    Representante = models.CharField(max_length=255)
    Cargo_Representante = models.CharField(max_length=255)
    Regiao_de_Comercializacao = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'relatorio_cadop'

    def __str__(self):
        return self.Nome_Fantasia