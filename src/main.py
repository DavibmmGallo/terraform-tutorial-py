from flask import Flask
from datetime import datetime
from flask_swagger_ui import get_swaggerui_blueprint

app = Flask(__name__)

@app.route('/time')
def get_time():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

@app.route('/docs')
def swagger_ui():
    swagger_url = '/static/swagger.json'
    swagger_ui_blueprint = get_swaggerui_blueprint(
        '/docs',
        swagger_url,
        config={
            'app_name': "Time API"
        }
    )
    return swagger_ui_blueprint

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
