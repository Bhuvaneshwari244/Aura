# AURA ACADEMIC PAPER - PART 2

## III. SYSTEM ARCHITECTURE AND METHODOLOGY

### A. Overall System Architecture

Aura employs a modern three-tier client-server architecture with clear separation of concerns, enabling scalability, maintainability, and security. The architecture consists of:

**1. Presentation Layer (Frontend):**
- React 18.2.0 Single Page Application (SPA)
- Responsive UI with Tailwind CSS 3.4.1
- Context API for state management
- React Router DOM 6.21.0 for client-side routing
- Recharts 2.10.3 for data visualization
- Axios 1.6.5 for API communication

**2. Application Layer (Backend):**
- Flask 3.0.0 RESTful API
- Flask-JWT-Extended 4.6.0 for authentication
- Flask-CORS 4.0.0 for cross-origin support
- Gunicorn 21.2.0 production server
- Python 3.11 runtime environment

**3. Data Layer:**
- JSON file-based storage for MVP
- User profiles and authentication data
- Health tracking data (cycles, symptoms)
- ML model predictions and history
- Application logs and analytics

**System Architecture Diagram:**

```
┌─────────────────────────────────────────────────────┐
│         Presentation Layer (React SPA)              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │Dashboard │  │ Tracking │  │ Insights │         │
│  └──────────┘  └──────────┘  └──────────┘         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │  PCOD    │  │  Doctor  │  │Emergency │         │
│  │Assessment│  │  Consult │  │ Features │         │
│  └──────────┘  └──────────┘  └──────────┘         │
└────────────────────┬────────────────────────────────┘
                     │ HTTPS/REST API
                     │ JWT Authentication
┌────────────────────▼────────────────────────────────┐
│       Application Layer (Flask Backend)             │
│  ┌──────────────────────────────────────────────┐  │
│  │         Authentication Module                 │  │
│  │  - User Registration & Login                  │  │
│  │  - JWT Token Generation & Validation          │  │
│  │  - Password Hashing (bcrypt)                  │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │         Health Tracking Module                │  │
│  │  - Cycle Management API                       │  │
│  │  - Symptom Logging API                        │  │
│  │  - Fertility Calculation                      │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │         ML Prediction Module                  │  │
│  │  - Feature Extraction                         │  │
│  │  - PCOD Risk Assessment                       │  │
│  │  - Cycle Prediction                           │  │
│  └──────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────┘
                     │
        ┌────────────┴────────────┐
        │                         │
┌───────▼────────┐      ┌────────▼──────────┐
│   Data Layer   │      │   ML Models       │
│  (JSON Files)  │      │ (Scikit-learn)    │
│                │      │                   │
│ - users_data   │      │ - Random Forest   │
│ - cycles       │      │ - Scaler          │
│ - symptoms     │      │ - Feature Eng.    │
│ - predictions  │      │                   │
└────────────────┘      └───────────────────┘
```

### B. Frontend Architecture and Implementation

**1. Technology Stack:**
- **React 18.2.0:** Component-based UI with hooks for state management
- **Tailwind CSS 3.4.1:** Utility-first CSS framework for responsive design
- **React Router DOM 6.21.0:** Client-side routing with nested routes
- **Context API:** Global state management for user, language, theme
- **Recharts 2.10.3:** Composable charting library for data visualization
- **Lucide React 0.309.0:** Icon library with 1000+ icons
- **Axios 1.6.5:** Promise-based HTTP client with interceptors
- **Date-fns 3.0.6:** Modern date utility library

**2. Component Architecture:**

The frontend follows a modular component structure:

```
src/
├── components/          # Reusable UI components
│   ├── AnimatedBackground.js
│   ├── AnimatedNotification.js
│   ├── Navigation.js
│   ├── LoadingSpinner.js
│   ├── LanguageSelector.js
│   ├── CyclePhaseIndicator.js
│   ├── HealthScore.js
│   ├── MoodTrends.js
│   ├── DataVisualization.js
│   └── [40+ more components]
├── pages/              # Page-level components
│   ├── Dashboard.js
│   ├── Login.js
│   ├── Register.js
│   ├── CycleTracker.js
│   ├── SymptomLogger.js
│   ├── PCODAssessment.js
│   ├── HealthInsightsPage.js
│   ├── DoctorConsultation.js
│   └── [10+ more pages]
├── context/            # Global state management
│   ├── LanguageContext.js
│   └── ThemeContext.js
├── i18n/               # Internationalization
│   └── translations.js
├── services/           # API integration
│   └── api.js
├── utils/              # Utility functions
│   └── animationUtils.js
├── App.js              # Root component
└── index.js            # Entry point
```

**3. State Management:**

Global state managed using React Context API:

```javascript
// LanguageContext.js
const LanguageContext = createContext();

export const LanguageProvider = ({ children }) => {
  const [language, setLanguage] = useState('en');
  const [translations, setTranslations] = useState(translationsData.en);

  const changeLanguage = (lang) => {
    setLanguage(lang);
    setTranslations(translationsData[lang]);
    localStorage.setItem('preferredLanguage', lang);
  };

  const t = (key) => {
    const keys = key.split('.');
    let value = translations;
    for (const k of keys) {
      value = value?.[k];
    }
    return value || key;
  };

  return (
    <LanguageContext.Provider value={{ language, changeLanguage, t }}>
      {children}
    </LanguageContext.Provider>
  );
};
```

**4. Routing Structure:**

```javascript
// App.js routing configuration
<Routes>
  <Route path="/" element={<Login />} />
  <Route path="/register" element={<Register />} />
  <Route path="/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
  <Route path="/cycle-tracker" element={<PrivateRoute><CycleTracker /></PrivateRoute>} />
  <Route path="/symptom-logger" element={<PrivateRoute><SymptomLogger /></PrivateRoute>} />
  <Route path="/pcod-assessment" element={<PrivateRoute><PCODAssessment /></PrivateRoute>} />
  <Route path="/health-insights" element={<PrivateRoute><HealthInsightsPage /></PrivateRoute>} />
  <Route path="/doctor-consultation" element={<PrivateRoute><DoctorConsultation /></PrivateRoute>} />
  <Route path="/settings" element={<PrivateRoute><Settings /></PrivateRoute>} />
</Routes>
```

### C. Backend Architecture and Implementation

**1. Technology Stack:**
- **Flask 3.0.0:** Lightweight WSGI web application framework
- **Flask-JWT-Extended 4.6.0:** JWT authentication with refresh tokens
- **Flask-CORS 4.0.0:** Cross-Origin Resource Sharing support
- **Werkzeug 3.0.1:** WSGI utility library for password hashing
- **Python-dotenv 1.0.0:** Environment variable management
- **Gunicorn 21.2.0:** Python WSGI HTTP server for production

**2. API Architecture:**

RESTful API design following best practices:

```python
# app.py - Main application file
from flask import Flask, jsonify
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from datetime import timedelta
import os

app = Flask(__name__)
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(days=7)

CORS(app, resources={r"/*": {"origins": "*"}})
jwt = JWTManager(app)

# Register blueprints
from routes.auth import auth_bp
from routes.cycles import cycles_bp
from routes.symptoms import symptoms_bp
from routes.predictions import predictions_bp

app.register_blueprint(auth_bp, url_prefix='/api/auth')
app.register_blueprint(cycles_bp, url_prefix='/api/cycles')
app.register_blueprint(symptoms_bp, url_prefix='/api/symptoms')
app.register_blueprint(predictions_bp, url_prefix='/api/predictions')
```

**3. API Endpoints:**

**Authentication Endpoints:**
```
POST   /api/auth/register    - User registration
POST   /api/auth/login       - User authentication
GET    /api/auth/profile     - Get user profile
PUT    /api/auth/profile     - Update user profile
```

**Cycle Management Endpoints:**
```
POST   /api/cycles           - Log new menstrual cycle
GET    /api/cycles           - Get cycle history
GET    /api/cycles/stats     - Get cycle statistics
GET    /api/cycles/predict-next - Predict next period
PUT    /api/cycles/:id       - Update cycle entry
DELETE /api/cycles/:id       - Delete cycle entry
```

**Symptom Tracking Endpoints:**
```
POST   /api/symptoms         - Log symptoms
GET    /api/symptoms         - Get symptom history
GET    /api/symptoms/analysis - Get symptom analysis
PUT    /api/symptoms/:id     - Update symptom entry
DELETE /api/symptoms/:id     - Delete symptom entry
```

**PCOD Prediction Endpoints:**
```
POST   /api/predictions/pcod-risk - Assess PCOD risk
GET    /api/predictions/pcod-risk/auto - Auto-assessment
GET    /api/predictions/history - Get prediction history
```

**4. Authentication Implementation:**

JWT-based stateless authentication:

```python
# routes/auth.py
from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash
import json
from datetime import datetime

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    
    # Validate input
    if not all(k in data for k in ['name', 'email', 'password', 'age']):
        return jsonify({'error': 'Missing required fields'}), 400
    
    # Check if user exists
    users = load_users()
    if any(u['email'] == data['email'] for u in users):
        return jsonify({'error': 'Email already registered'}), 409
    
    # Create new user
    user = {
        'id': generate_user_id(),
        'name': data['name'],
        'email': data['email'],
        'password': generate_password_hash(data['password']),
        'age': data['age'],
        'created_at': datetime.utcnow().isoformat(),
        'preferences': {
            'language': 'en',
            'theme': 'light',
            'notifications': True
        }
    }
    
    users.append(user)
    save_users(users)
    
    # Generate JWT token
    access_token = create_access_token(identity=user['id'])
    
    return jsonify({
        'message': 'Registration successful',
        'access_token': access_token,
        'user': {
            'id': user['id'],
            'name': user['name'],
            'email': user['email']
        }
    }), 201

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    
    users = load_users()
    user = next((u for u in users if u['email'] == data['email']), None)
    
    if not user or not check_password_hash(user['password'], data['password']):
        return jsonify({'error': 'Invalid credentials'}), 401
    
    access_token = create_access_token(identity=user['id'])
    
    return jsonify({
        'access_token': access_token,
        'user': {
            'id': user['id'],
            'name': user['name'],
            'email': user['email']
        }
    }), 200
```

### D. Database Design and Data Models

**1. User Data Model:**

```json
{
  "id": "uuid-string",
  "name": "string",
  "email": "string",
  "password": "hashed-string",
  "age": "integer",
  "created_at": "ISO-8601-timestamp",
  "preferences": {
    "language": "enum[en, hi, ta, te, kn]",
    "theme": "enum[light, dark]",
    "notifications": "boolean"
  },
  "health_profile": {
    "height": "float (cm)",
    "weight": "float (kg)",
    "bmi": "float",
    "blood_type": "string",
    "allergies": ["array of strings"],
    "medications": ["array of strings"]
  }
}
```

**2. Cycle Data Model:**

```json
{
  "id": "uuid-string",
  "user_id": "foreign-key",
  "start_date": "ISO-8601-date",
  "end_date": "ISO-8601-date",
  "cycle_length": "integer (days)",
  "period_length": "integer (days)",
  "flow_intensity": "enum[light, medium, heavy]",
  "symptoms": ["array of symptom IDs"],
  "notes": "string",
  "created_at": "ISO-8601-timestamp"
}
```

**3. Symptom Data Model:**

```json
{
  "id": "uuid-string",
  "user_id": "foreign-key",
  "date": "ISO-8601-timestamp",
  "symptom_type": "enum[cramps, headache, bloating, mood_swings, ...]",
  "severity": "integer[1-10]",
  "duration": "string",
  "notes": "string",
  "voice_input": "boolean",
  "created_at": "ISO-8601-timestamp"
}
```

**4. PCOD Prediction Data Model:**

```json
{
  "id": "uuid-string",
  "user_id": "foreign-key",
  "prediction_date": "ISO-8601-timestamp",
  "risk_level": "enum[low, moderate, high]",
  "risk_score": "float[0-1]",
  "contributing_factors": {
    "cycle_irregularity": "float",
    "symptom_severity": "float",
    "bmi": "float",
    "age": "integer"
  },
  "recommendations": ["array of strings"],
  "confidence": "float[0-1]"
}
```

*[Continue to Part 3 for ML methodology and results]*
