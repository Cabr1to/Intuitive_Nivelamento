import os
import zipfile
from scrapy import Request
import scrapy

class GovSpider(scrapy.Spider):
    name = "gov"
    allowed_domains = ["www.gov.br"]
    start_urls = [
        "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"]

    zip_filename = "anexos_rol_procedimentos.zip"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if os.path.exists(self.zip_filename):
            os.remove(self.zip_filename)

    # Extrair os dados
    def parse(self, response):
        for href in response.css('li .internal-link:nth-child(1)::attr(href)').extract():
            if href.lower().endswith('.pdf'):
                yield Request(
                    url=response.urljoin(href),
                    callback=self.add_to_zip
                )
    # Compactando os arquivos
    def add_to_zip(self, response):
        filename = response.url.split('/')[-1]

        with zipfile.ZipFile(self.zip_filename, 'a', zipfile.ZIP_DEFLATED) as zipf:
            # Força compressão
            zip_info = zipfile.ZipInfo(filename)
            zip_info.compress_type = zipfile.ZIP_DEFLATED
            zip_info._compresslevel = 9

            zipf.writestr(zip_info, response.body)

        self.logger.info(f'Adicionado: {filename} (Tamanho original: {len(response.body)} bytes)')

    def closed(self, reason):
        if os.path.exists(self.zip_filename):
            original_size = sum(os.path.getsize(f) for f in [self.zip_filename])
            zip_size = os.path.getsize(self.zip_filename)

            self.logger.info(
                f"Tamanho total dos PDFs: {original_size / 1024 / 1024:.2f} MB\n"
                f"Tamanho do ZIP: {zip_size / 1024 / 1024:.2f} MB\n"
                f"Taxa de compressão: {((original_size - zip_size) / original_size) * 100:.1f}%"
            )
