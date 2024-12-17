from flask import Flask, request, jsonify
import requests
import json

app = Flask(__name__)

OPENROUTER_API_KEY = "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"
YOUR_SITE_URL = "your_site_url.com"
YOUR_APP_NAME = "selim"

headers = {
    "Authorization": f"Bearer {OPENROUTER_API_KEY}",
    "HTTP-Referer": f"{YOUR_SITE_URL}",  # Optional
    "X-Title": f"{YOUR_APP_NAME}",       # Optional
    "Content-Type": "application/json"
}

def generate_answer(question):
    payload = {
        "model": "meta-llama/llama-3.2-3b-instruct:free",  # Optional
        "messages": [
            {"role": "user", "content": question}
        ]
    }
    response = requests.post("https://openrouter.ai/api/v1/chat/completions", headers=headers, data=json.dumps(payload))
    
    if response.status_code != 200:
        return f"Error: {response.status_code} - {response.text}"
    
    response_data = response.json()
    choices = response_data.get("choices")
    
    if not choices:
        return "Error: No choices returned in the response."
    
    answer = choices[0].get("message", {}).get("content", "")
    return answer.strip()

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    question = data.get('question')
    answer = generate_answer(question)
    return jsonify({'answer': answer})

if __name__ == '__main__':
    app.run(debug=True)