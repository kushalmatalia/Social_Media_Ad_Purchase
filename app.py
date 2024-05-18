from flask import Flask, request, jsonify, render_template
import pickle
import numpy as np

app = Flask(__name__)
model = pickle.load(open('nbclassifier.pkl', 'rb'))
scaler = pickle.load(open('scaler.pickle', 'rb'))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    gender = int(request.json['gender'])
    age = int(request.json['age'])
    salary = int(request.json['salary'])
    
    input_features = np.array([[gender, age, salary]])
    scaled_features = scaler.transform(input_features)
    prediction = model.predict(scaled_features)
    output = "True" if prediction[0] == 1 else "False"
    
    return jsonify({'prediction': output})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)