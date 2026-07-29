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

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $path = $context.Request.Url.AbsolutePath
        if ($path -eq "/api/quotes") {
            $quotes = @{}
            $symbols = ($context.Request.QueryString["symbols"] -split "," | Select-Object -First 25)
            foreach ($symbol in $symbols) {
                $symbol = $symbol.ToUpper() -replace "[^A-Z0-9.\-]", ""
                if (-not $symbol) { continue }
                try {
                    $url = "https://query1.finance.yahoo.com/v8/finance/chart/$symbol`?range=1d&interval=5m"
                    $result = Invoke-RestMethod -Uri $url -TimeoutSec 8 -Headers @{"User-Agent"="Mozilla/5.0 Northstar/1.0"}
                    $meta = $result.chart.result[0].meta
                    $price = [double]$meta.regularMarketPrice
                    $previous = if ($meta.chartPreviousClose) { [double]$meta.chartPreviousClose } else { [double]$meta.previousClose }
                    if ($price -and $previous) { $quotes[$symbol] = @{price=$price; change=(($price-$previous)/$previous*100)} }
                } catch { continue }
            }
            $json = [Text.Encoding]::UTF8.GetBytes((@{quotes=$quotes} | ConvertTo-Json -Depth 4 -Compress))
            $context.Response.StatusCode = 200
            $context.Response.ContentType = "application/json"
            $context.Response.ContentLength64 = $json.Length
            if ($context.Request.HttpMethod -ne "HEAD") { $context.Response.OutputStream.Write($json, 0, $json.Length) }
            $context.Response.Close()
            continue
        }
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
