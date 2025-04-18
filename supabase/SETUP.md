# Supabase Project Setup Guide

## Authentication Setup

1. **URL Configuration**
   - Go to Authentication > URL Configuration
   - Set Site URL to: `http://localhost:8888`
   - Add these Redirect URLs:
     - `http://localhost:8888/auth/callback`
     - `http://localhost:8888/dashboard`
     - `http://localhost:8888/create`

2. **Sign In / Up Settings**
   - Go to Authentication > Sign In / Up
   - Enable "Email" provider
   - Enable "Confirm email"
   - Enable "Secure email change"
   - Enable "Password reset"
   - Enable "Google" and "GitHub" providers
   - For each OAuth provider:
     - Create OAuth application in provider's developer console
     - Add callback URL: `https://[YOUR_PROJECT_REF].supabase.co/auth/v1/callback`
     - Copy Client ID and Secret to Supabase

3. **Email Templates**
   - Go to Authentication > Emails
   - Customize templates for:
     - Confirmation email
     - Magic link
     - Change email address
     - Reset password
   - Configure SMTP settings if using custom email provider

4. **Security Settings**
   - Go to Authentication > Attack Protection
     - Enable rate limiting
     - Configure CAPTCHA settings
   - Go to Authentication > Sessions
     - Set JWT expiry to 3600 seconds (1 hour)
     - Configure refresh token settings
   - Go to Authentication > Multi-Factor
     - Enable MFA if required
     - Configure MFA factors

5. **Policies**
   - Go to Authentication > Policies
   - Review and configure:
     - Password policies
     - Session policies
     - Rate limiting policies

6. **Advanced Settings**
   - Go to Authentication > Advanced
   - Configure:
     - Custom SMTP settings
     - Custom JWT claims
     - Custom redirect URLs
     - Custom domains

## Storage Setup

1. **Create Storage Buckets**
   - Go to Storage > Buckets
   - Create these buckets:
     - `competition-images` (10MB limit)
     - `user-avatars` (5MB limit)
     - `prize-images` (10MB limit)

2. **Bucket Policies**
   For each bucket:
   - Go to Storage > Policies
   - Set public access for reading
   - Restrict uploads to authenticated users
   - Set appropriate file size limits
   - Restrict to allowed MIME types

3. **Storage Settings**
   - Go to Storage > Settings
   - Set global file size limit to 50MB
   - Configure allowed MIME types

## Database Settings

1. **Connection Pooling**
   - Go to Database > Settings
   - Set pool size to 30
   - Set max connections to 100
   - Set connection timeout to 10 seconds

2. **Database Extensions**
   - Go to Database > Extensions
   - Enable:
     - `uuid-ossp`
     - `pgcrypto`

## Environment Variables

Add these to your `.env` file:

```bash
# Supabase
SUPABASE_URL=https://[YOUR_PROJECT_REF].supabase.co
SUPABASE_ANON_KEY=[YOUR_ANON_KEY]
SUPABASE_SERVICE_ROLE_KEY=[YOUR_SERVICE_ROLE_KEY]

# OAuth Providers
GOOGLE_CLIENT_ID=[YOUR_GOOGLE_CLIENT_ID]
GOOGLE_CLIENT_SECRET=[YOUR_GOOGLE_CLIENT_SECRET]
GITHUB_CLIENT_ID=[YOUR_GITHUB_CLIENT_ID]
GITHUB_CLIENT_SECRET=[YOUR_GITHUB_CLIENT_SECRET]
```

## Security Considerations

1. **Row Level Security (RLS)**
   - All tables have RLS enabled
   - Policies are defined in schema.sql

2. **Storage Security**
   - Public buckets for reading
   - Authenticated users only for uploads
   - File type restrictions
   - Size limits per bucket

3. **Authentication Security**
   - Email confirmation required
   - Secure email change process
   - Password reset enabled
   - JWT expiry set to 1 hour

## Testing the Setup

1. **Test Authentication**
   ```bash
   # Sign up
   curl -X POST 'https://[YOUR_PROJECT_REF].supabase.co/auth/v1/signup' \
     -H "apikey: [YOUR_ANON_KEY]" \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"password123"}'

   # Sign in
   curl -X POST 'https://[YOUR_PROJECT_REF].supabase.co/auth/v1/token?grant_type=password' \
     -H "apikey: [YOUR_ANON_KEY]" \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"password123"}'
   ```

2. **Test Storage**
   ```bash
   # Upload file
   curl -X POST 'https://[YOUR_PROJECT_REF].supabase.co/storage/v1/object/competition-images/test.jpg' \
     -H "Authorization: Bearer [USER_JWT]" \
     -H "Content-Type: image/jpeg" \
     --data-binary '@/path/to/test.jpg'
   ``` 