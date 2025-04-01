# app/views.py
from django.http import JsonResponse
from django.db.models import Q
from .models import TabelaRelatorio


def buscar_operadoras(request):
    termo_busca = request.GET.get('q', '').strip()

    if not termo_busca:
        return JsonResponse({
            'error': 'Por favor, forneça um termo de busca'
        }, status=400)

    try:
        # Busca case-insensitive no campo Nome_Fantasia
        resultados = TabelaRelatorio.objects.filter(
            Nome_Fantasia__icontains=termo_busca
        ).order_by('Nome_Fantasia')[:100]  # Limita a 100 resultados

        dados = [{
            'registro_ans': op.Registro_ANS,
            'nome_fantasia': op.Nome_Fantasia,
            'cnpj': op.CNPJ,
            'uf': op.UF,
            'telefone': f"({op.DDD}) {op.Telefono}"
        } for op in resultados]

        return JsonResponse({
            'resultados': dados,
            'total': len(dados)
        })

    except Exception as e:
        return JsonResponse({
            'error': 'Erro na busca',
            'details': str(e)
        }, status=500)