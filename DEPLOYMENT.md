# Publish Northstar as a website

Northstar is ready to deploy as a Render web service. The included
`render.yaml` tells Render how to build, start, and health-check the application.

## First deployment

1. Push this repository to a GitHub or GitLab repository you control.
2. Create or sign in to a Render account.
3. In the Render dashboard, choose **New > Blueprint**.
4. Connect the repository and select it.
5. Review the detected `northstar-market-dashboard` service and deploy it.
6. When the deployment finishes, open the public `onrender.com` URL shown by
   Render. Bookmark that URL; it is the online version of Northstar.

Every later push to the connected branch will deploy automatically. The service
uses Render's `PORT` environment variable and listens on all container network
interfaces, while local launchers continue to bind only to your computer.

## Data and privacy

Holdings and savings remain in the browser's local storage. They are not sent to
Render or saved on the server. This means each browser has its own portfolio and
clearing browser data will remove its saved copy.

The server requests market quotes only when the dashboard refreshes them. Quote
responses are cached for 60 seconds to reduce upstream traffic. Quotes may be
delayed, and the market-data provider can occasionally be unavailable.

## Verify a deployment

Replace `YOUR-SITE` with the hostname Render assigned:

```powershell
Invoke-RestMethod https://YOUR-SITE.onrender.com/api/health
```

The response should contain `status` set to `ok`.
