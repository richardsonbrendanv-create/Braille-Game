param(
    [ValidateRange(1024, 65535)]
    [int]$Port = 8765,
    [switch]$NoBrowser
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$index = Join-Path $root "index.html"
if (-not (Test-Path -LiteralPath $index)) {
    Write-Error "index.html was not found next to the Northstar launcher."
    exit 1
}

$prefix = "http://localhost:$Port/"
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add($prefix)

try {
    $listener.Start()
} catch {
    Write-Host "Northstar could not start on port $Port." -ForegroundColor Red
    Write-Host "Close another Northstar window or run: .\northstar.cmd 8878"
    exit 1
}

Write-Host ""
Write-Host "  NORTHSTAR" -ForegroundColor Green
Write-Host "  Running at $prefix" -ForegroundColor White
Write-Host "  Keep this window open. Press Ctrl+C to stop." -ForegroundColor DarkGray
Write-Host ""

if (-not $NoBrowser) {
    Start-Process $prefix
}

$csp = "default-src 'none'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; img-src data:; connect-src https://query1.finance.yahoo.com; object-src 'none'; base-uri 'none'; form-action 'none'; frame-ancestors 'none'"

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $path = $context.Request.Url.AbsolutePath
        if ($path -ne "/" -and $path -ne "/index.html") {
            $context.Response.StatusCode = 404
            $context.Response.Close()
            continue
        }

        $body = [System.IO.File]::ReadAllBytes($index)
        $response = $context.Response
        $response.StatusCode = 200
        $response.ContentType = "text/html; charset=utf-8"
        $response.ContentLength64 = $body.Length
        $response.Headers.Add("Content-Security-Policy", $csp)
        $response.Headers.Add("Referrer-Policy", "no-referrer")
        $response.Headers.Add("X-Content-Type-Options", "nosniff")
        $response.Headers.Add("X-Frame-Options", "DENY")
        $response.Headers.Add("Cache-Control", "no-store")
        if ($context.Request.HttpMethod -ne "HEAD") {
            $response.OutputStream.Write($body, 0, $body.Length)
        }
        $response.Close()
    }
} finally {
    $listener.Stop()
    $listener.Close()
}
