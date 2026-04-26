# Deploy to Render - Frontend + Backend in ONE Click! 🚀

## Why Render?
✅ FREE tier available
✅ Deploys both frontend AND backend together
✅ Automatic HTTPS
✅ Auto-deploys on git push
✅ No credit card required for free tier

## Step-by-Step Deployment

### Step 1: Sign Up on Render

1. Go to https://render.com
2. Click "Get Started for Free"
3. Sign up with your GitHub account

### Step 2: Create New Blueprint

1. After login, click "New +" button
2. Select "Blueprint"
3. Connect your GitHub account if not already connected
4. Select repository: `Bhuvaneshwari244/Aura`
5. Click "Connect"

### Step 3: Configure (Auto-detected from render.yaml)

Render will automatically detect the `render.yaml` file and configure:
- ✅ Backend service (Python/Flask)
- ✅ Frontend service (React static site)

Just click "Apply" or "Create Services"

### Step 4: Wait for Deployment

- Backend will deploy first (takes 5-10 minutes)
- Frontend will deploy next (takes 3-5 minutes)
- You'll get URLs for both:
  - Backend: `https://aura-backend.onrender.com`
  - Frontend: `https://aura-frontend.onrender.com`

### Step 5: Update Frontend API URL (if needed)

If the backend URL is different, update `frontend/.env.production`:

```env
REACT_APP_API_URL=https://your-actual-backend-url.onrender.com/api
```

Then commit and push:
```bash
git add frontend/.env.production
git commit -m "Update API URL"
git push origin main
```

Render will auto-redeploy!

## Alternative: Manual Setup (If Blueprint Doesn't Work)

### Deploy Backend First:

1. Click "New +" → "Web Service"
2. Connect GitHub repository: `Bhuvaneshwari244/Aura`
3. Configure:
   - **Name**: `aura-backend`
   - **Root Directory**: `backend`
   - **Runtime**: Python 3
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `gunicorn app:app`
   - **Instance Type**: Free
4. Add Environment Variable:
   - `JWT_SECRET_KEY` = `your-secret-key-here`
5. Click "Create Web Service"
6. **Copy the backend URL** (e.g., `https://aura-backend.onrender.com`)

### Deploy Frontend:

1. Click "New +" → "Static Site"
2. Connect same repository: `Bhuvaneshwari244/Aura`
3. Configure:
   - **Name**: `aura-frontend`
   - **Root Directory**: `frontend`
   - **Build Command**: `npm install && npm run build`
   - **Publish Directory**: `build`
4. Add Environment Variable:
   - `REACT_APP_API_URL` = `https://aura-backend.onrender.com/api` (use your backend URL)
5. Click "Create Static Site"

## Your Live URLs

After deployment:
- **Frontend**: `https://aura-frontend.onrender.com`
- **Backend API**: `https://aura-backend.onrender.com/api`

## Free Tier Limits

- ✅ 750 hours/month (enough for 1 service running 24/7)
- ✅ Automatic HTTPS
- ✅ Custom domains supported
- ⚠️ Services spin down after 15 minutes of inactivity (first request takes ~30 seconds)
- ⚠️ 512 MB RAM

## Keep Service Awake (Optional)

To prevent spin-down, use a service like:
- UptimeRobot (https://uptimerobot.com) - Free
- Ping your backend every 10 minutes

## Troubleshooting

**Build fails?**
- Check build logs in Render dashboard
- Ensure all dependencies are in requirements.txt and package.json

**Backend not responding?**
- Check logs in Render dashboard
- Verify environment variables are set
- Check health endpoint: `https://your-backend.onrender.com/api/health`

**Frontend can't connect to backend?**
- Verify `REACT_APP_API_URL` is set correctly
- Check CORS settings in `backend/app.py`
- Ensure backend is deployed and running

## Update Deployment

Every time you push to GitHub main branch:
```bash
git add .
git commit -m "Your changes"
git push origin main
```

Render will automatically redeploy both services!

## Cost

- **Free tier**: Perfect for development and small projects
- **Paid tier**: $7/month per service for always-on, more resources

Your app is ready to deploy! 🎉
