param(
    [string]$Workspace = (Get-Location).Path,
    [string]$Date = (Get-Date -Format "yyyy-MM-dd")
)

$resolvedWorkspace = (Resolve-Path -LiteralPath $Workspace).Path

function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Ensure-File {
    param(
        [string]$Path,
        [string]$Content
    )
    if (-not (Test-Path -LiteralPath $Path)) {
        $parent = Split-Path -Path $Path -Parent
        Ensure-Directory -Path $parent
        [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
    }
}

$conductorDir = Join-Path $resolvedWorkspace "conductor"
$tracksDir = Join-Path $conductorDir "tracks"
$memoryDir = Join-Path $resolvedWorkspace "memory"
$logsDir = Join-Path $memoryDir "logs"

Ensure-Directory -Path $conductorDir
Ensure-Directory -Path $tracksDir
Ensure-Directory -Path $memoryDir
Ensure-Directory -Path $logsDir

$productPath = Join-Path $conductorDir "product.md"
$techStackPath = Join-Path $conductorDir "tech-stack.md"
$workflowPath = Join-Path $conductorDir "workflow.md"
$tracksPath = Join-Path $conductorDir "tracks.md"
$dailyLogPath = Join-Path $logsDir "$Date.md"

$productTemplate = @"
# Product

## Objective
- <one-line objective>

## Scope
- In: <main scope>
- Out: <out-of-scope>

## Success Criteria
- <metric or acceptance condition>
"@

$techStackTemplate = @"
# Tech Stack

## Runtime
- Language:
- Framework:

## Data
- Database:
- Cache:

## Tooling
- Test:
- Lint/Format:
"@

$workflowTemplate = @"
# Workflow

## Cadence
- Work in small tasks and update tracks after milestones.

## Quality Gates
- Run focused tests before checkpoint.
- Record decisions in daily log.

## Definition of Done
- Code updated
- Verification completed
- Track status updated
"@

$tracksTemplate = @"
# Tracks

- [ ] <track-id> | scope:<short> | owner:<name> | next:<one action>
"@

$dailyTemplate = @"
# $Date

## Checkpoint
- Current objective:
- Current state:
- Next action:
- Open risks:
"@

Ensure-File -Path $productPath -Content $productTemplate
Ensure-File -Path $techStackPath -Content $techStackTemplate
Ensure-File -Path $workflowPath -Content $workflowTemplate
Ensure-File -Path $tracksPath -Content $tracksTemplate
Ensure-File -Path $dailyLogPath -Content $dailyTemplate

Write-Output "Initialized low-context memory scaffold:"
Write-Output "  $conductorDir"
Write-Output "  $memoryDir"
Write-Output "Today's log:"
Write-Output "  $dailyLogPath"
