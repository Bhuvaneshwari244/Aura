# Single Deployment on Render - ONE Service Only! 🚀

## Quick Setup (2 Minutes)

### On Render Dashboard:

**Name:** `aura-app`

**Root Directory:** Leave EMPTY (use repository root)

**Build Command:**
```
cd frontend && npm install && npm run build && cd .. && pip install -r backend/requirements.txt
```

**Start Command:**
```
cd backend && gunicorn app:app
```

**Environment Variables:**
- Key: `JWT_SECRET_KEY`
- Value: `aura-secret-2026`

Click **"Deploy Web Service"**

That's it! Your complete app (frontend + backend) will be at:
`https://aura-app.onrender.com`

## How It Works

- Flask serves the React build folder
- All `/api/*` routes go to backend
- All other routes serve the React app
- ONE deployment, ONE URL!
