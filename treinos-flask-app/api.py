from flask import Blueprint, request, jsonify

api_bp = Blueprint('api', __name__)

@api_bp.route('/upload-excel', methods=['POST'])
def upload_excel():
    try:
        dados_excel = request.json
        quantidade_linhas = len(dados_excel) if dados_excel else 0
        print(f"Recebidas {quantidade_linhas} linhas do Excel via Blueprint!")
        return jsonify({
            "status": "sucesso", 
            "mensagem": f"{quantidade_linhas} registros processados com sucesso!"
        }), 200
    except Exception as e:
        return jsonify({"status": "erro", "mensagem": str(e)}), 400
