$ErrorActionPreference = 'Stop'
$taskRoot = $PSScriptRoot
$taskUtf8 = [System.Text.UTF8Encoding]::new($false)
$taskHtml = Get-Content -LiteralPath (Join-Path $taskRoot 'source.template.html') -Raw -Encoding UTF8
$taskGame = Get-Content -LiteralPath (Join-Path $taskRoot 'game.js') -Raw -Encoding UTF8
$taskRuntime = Get-Content -LiteralPath (Join-Path $taskRoot 'vendor/game3d-runtime.iife.js') -Raw -Encoding UTF8
$taskSpec = Get-Content -LiteralPath (Join-Path $taskRoot 'assets.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$taskRecords = [ordered]@{}
foreach ($taskProp in $taskSpec.PSObject.Properties) {
    $taskPath = Join-Path $taskRoot $taskProp.Value
    $taskBytes = [IO.File]::ReadAllBytes($taskPath)
    $taskRecords[$taskProp.Name] = [ordered]@{
        mime = 'model/gltf-binary'
        base64 = [Convert]::ToBase64String($taskBytes)
        sha256 = (Get-FileHash -LiteralPath $taskPath -Algorithm SHA256).Hash.ToLowerInvariant()
    }
}
foreach ($taskToken in @('<!--OFFLINE_RUNTIME-->', '<!--EMBEDDED_ASSETS-->', '<!--GAME_CODE-->')) {
    if ([regex]::Matches($taskHtml, [regex]::Escape($taskToken)).Count -ne 1) { throw "Expected exactly one $taskToken" }
}
$taskJson = ($taskRecords | ConvertTo-Json -Depth 5 -Compress).Replace('</', '<\/')
$taskHtml = $taskHtml.Replace('<!--OFFLINE_RUNTIME-->', '<script>' + $taskRuntime.Replace('</script', '<\/script') + '</script>')
$taskHtml = $taskHtml.Replace('<!--EMBEDDED_ASSETS-->', '<script>window.__ASSETS__=' + $taskJson + ';</script>')
$taskHtml = $taskHtml.Replace('<!--GAME_CODE-->', '<script>' + $taskGame + '</script>')
$taskLicense = Get-Content -LiteralPath (Join-Path $taskRoot 'vendor/THREE_LICENSE.txt') -Raw -Encoding UTF8
$taskHtml += "`n<!-- Three.js 0.185.1 license`n" + $taskLicense.Replace('--', '- -') + "`n-->`n"
[IO.File]::WriteAllText((Join-Path $taskRoot 'index.html'), $taskHtml, $taskUtf8)
Write-Output ('Built index.html; assets=' + $taskRecords.Count)
