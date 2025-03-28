import pandas as pd
import tabula
import zipfile
import os
from pathlib import Path

# Caminhos
base_dir = Path(__file__).parent if "__file__" in locals() else Path.cwd()
arquivo_path = base_dir / "../Web-scraping/scraper/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
output_csv = base_dir / "tabelas_consolidadas.csv"
output_zip = base_dir / "Teste_LuisEdu.zip"

# Lista
todas_tabelas = []

try:
    for i in range(3, 181, 20):
        fim = min(i + 19, 181)
        print(f"Processando páginas {i} a {fim}...")

        lista_tabelas = tabula.read_pdf(
            str(arquivo_path),
            pages=f"{i}-{fim}",
            multiple_tables=True,
            guess=False,
            lattice=True
        )

        if lista_tabelas:
            for tabela in lista_tabelas:
                if isinstance(tabela, pd.DataFrame) and not tabela.empty:
                    tabela.columns = tabela.columns.str.replace('\r', ' ').str.replace('\n', ' ')
                    tabela['Pagina_Origem'] = f"{i}-{fim}"
                    todas_tabelas.append(tabela)

    if todas_tabelas:
        df_consolidado = pd.concat(todas_tabelas, ignore_index=True)

        # Mapeamento das substituições
        mapeamento = {
            r'\bOD\b': 'Seg. Odontológica',
            r'\bAMB\b': 'Seg. Ambulatorial',
        }

        # Substituir nomes de colunas
        df_consolidado.columns = df_consolidado.columns.str.replace(r'\bOD\b', 'Seg_Odontologica', regex=True)
        df_consolidado.columns = df_consolidado.columns.str.replace(r'\bAMB\b', 'Seg_Ambulatorial', regex=True)

        # Substituir em valores das colunas
        for col in df_consolidado.select_dtypes(include=['object']).columns:
            df_consolidado[col] = df_consolidado[col].replace(mapeamento, regex=True)

        # Salvando o CSV
        temp_dir = base_dir / "temp"
        temp_dir.mkdir(exist_ok=True)
        temp_csv = temp_dir / "tabelas_consolidadas.csv"

        df_consolidado.to_csv(str(temp_csv), index=False, encoding='utf-8-sig')
        print(f"Arquivo CSV gerado: {temp_csv}")

        # Compactando para ZIP
        with zipfile.ZipFile(str(output_zip), 'w', zipfile.ZIP_DEFLATED) as zipf:
            zipf.write(str(temp_csv), arcname="tabelas_consolidadas.csv")
            print(f"Arquivo ZIP criado: {output_zip}")

        # Removendo o CSV temporário
        try:
            os.remove(str(temp_csv))
            temp_dir.rmdir()
        except PermissionError:
            print(f"Aviso: Não foi possível remover o arquivo temporário {temp_csv}")
        except OSError:
            print(f"Aviso: Não foi possível remover o diretório temporário {temp_dir}")

        print("Processo concluído com sucesso!")
    else:
        print("Nenhuma tabela válida encontrada no PDF.")

except Exception as e:
    print(f"Ocorreu um erro durante o processamento: {str(e)}")