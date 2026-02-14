# clean-for-paste.ps1
# Sanitizes text files for clean web pasting
# Usage: .\clean-for-paste.ps1 -Path "posts\001-audiobooks.md"
# Or pipe: Get-Content file.txt | .\clean-for-paste.ps1

param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$InputText,
    [string]$Path
)

function Clean-Text {
    param([string]$text)
    
    $clean = $text
    
    # Replace non-breaking spaces (U+00A0) with regular spaces
    $clean = $clean -replace '\u00A0', ' '
    
    # Replace other common invisible characters
    $clean = $clean -replace '\u200B', ''  # Zero-width space
    $clean = $clean -replace '\u200C', ''  # Zero-width non-joiner
    $clean = $clean -replace '\u200D', ''  # Zero-width joiner
    $clean = $clean -replace '\uFEFF', ''  # BOM
    
    # Normalize line endings to LF only
    $clean = $clean -replace '\r\n', "`n"
    $clean = $clean -replace '\r', "`n"
    
    # Remove trailing whitespace from lines
    $clean = ($clean -split "`n" | ForEach-Object { $_.TrimEnd() }) -join "`n"
    
    return $clean
}

if ($Path) {
    $content = Get-Content -Path $Path -Raw
    $cleaned = Clean-Text $content
    $cleaned | Set-Clipboard
    Write-Host "Cleaned and copied to clipboard: $Path"
} elseif ($InputText) {
    $cleaned = Clean-Text $InputText
    $cleaned | Set-Clipboard
    Write-Host "Cleaned and copied to clipboard"
} else {
    Write-Host "Usage: .\clean-for-paste.ps1 -Path 'file.md'"
    Write-Host "   or: 'text' | .\clean-for-paste.ps1"
}
