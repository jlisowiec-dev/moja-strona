param(
  [string]$Root = $PSScriptRoot,
  [int]$Port = 8080
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($Root)) { $Root = (Get-Location).Path }
Add-Type -AssemblyName System.Web

$prefix = "http://localhost:$Port/"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host ""
Write-Host "  Serwer strony kancelarii dziala:  $prefix"
Write-Host "  Katalog:  $Root"
Write-Host "  Zatrzymanie: zamknij to okno (lub Ctrl+C)"
Write-Host ""

$mime = @{
  ".html"="text/html; charset=utf-8"; ".htm"="text/html; charset=utf-8"
  ".css"="text/css; charset=utf-8";  ".js"="application/javascript; charset=utf-8"
  ".mjs"="application/javascript; charset=utf-8"; ".json"="application/json; charset=utf-8"
  ".svg"="image/svg+xml"; ".png"="image/png"; ".jpg"="image/jpeg"; ".jpeg"="image/jpeg"
  ".gif"="image/gif"; ".webp"="image/webp"; ".ico"="image/x-icon"
  ".woff"="font/woff"; ".woff2"="font/woff2"; ".ttf"="font/ttf"
  ".pdf"="application/pdf"; ".txt"="text/plain; charset=utf-8"
  ".map"="application/json; charset=utf-8"; ".webmanifest"="application/manifest+json"
}

while ($listener.IsListening) {
  try { $context = $listener.GetContext() } catch { break }
  $req = $context.Request
  $res = $context.Response
  try {
    $rel = [System.Web.HttpUtility]::UrlDecode($req.Url.AbsolutePath)
    if ([string]::IsNullOrEmpty($rel) -or $rel -eq "/") { $rel = "/index.html" }
    $rel = $rel.TrimStart("/") -replace "/", "\"
    $full = [System.IO.Path]::GetFullPath((Join-Path $Root $rel))
    $rootFull = [System.IO.Path]::GetFullPath($Root)

    if (-not $full.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
      $res.StatusCode = 403; $res.Close(); continue
    }
    if ((Test-Path $full) -and ((Get-Item $full).PSIsContainer)) {
      $full = Join-Path $full "index.html"
    }
    if (Test-Path $full -PathType Leaf) {
      $ext = [System.IO.Path]::GetExtension($full).ToLower()
      $ct = $mime[$ext]; if (-not $ct) { $ct = "application/octet-stream" }
      $bytes = [System.IO.File]::ReadAllBytes($full)
      $res.ContentType = $ct
      $res.ContentLength64 = $bytes.Length
      $res.Headers.Add("Cache-Control", "no-store")
      $res.OutputStream.Write($bytes, 0, $bytes.Length)
      Write-Host ("  {0}  {1}" -f $req.HttpMethod, $req.Url.AbsolutePath)
    } else {
      $res.StatusCode = 404
      $msg = [System.Text.Encoding]::UTF8.GetBytes("404 - nie znaleziono: $rel")
      $res.OutputStream.Write($msg, 0, $msg.Length)
      Write-Host ("  404  {0}" -f $req.Url.AbsolutePath)
    }
  } catch {
    try { $res.StatusCode = 500 } catch {}
    Write-Host ("  BLAD: {0}" -f $_.Exception.Message)
  } finally {
    try { $res.OutputStream.Close() } catch {}
  }
}
