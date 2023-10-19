from flask import Flask, jsonify
import json
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s] %(message)s')

@app.route('/')
def record_request():
    logging.info("Received a request on /")
    return jsonify({"name": "sam-staging-server", "health": "working", "purpose": "testing"})

@app.route('/health', methods=['GET'])
def health():
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
