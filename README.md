# Northstar Market Dashboard

Northstar is a polished, local-first stock market and portfolio dashboard. It
tracks holdings, highlights the strongest and weakest daily movers, and presents
scenario-based signals tied to recent market catalysts. Holdings remain in your
browser's local storage. The included local server retrieves the latest available
quotes through its same-origin API, avoiding browser cross-origin restrictions,
and retains the last known snapshot when an internet connection is unavailable.
Northstar also tracks a configurable savings balance and compound annual rate.

## Windows

The project must first be downloaded or cloned onto your computer. The path
`/workspace/Braille-Game` belongs to the development environment and does not
exist on Windows.

1. Download this repository and extract the ZIP file.
2. Open the extracted `Braille-Game` folder.
3. Double-click **`northstar.cmd`** to open Northstar.
4. Keep the Northstar terminal window open while using the dashboard. Press
   **Ctrl+C** in that window when you are finished.

Do not run the launcher from inside the ZIP preview. Choose **Extract All** first.
Keep `index.html`, `northstar.js`, `northstar.cmd`, and `northstar.ps1` together
in the extracted folder. No installation is required.

Alternatively, open PowerShell inside the extracted folder and run:

```powershell
.\northstar.cmd
```

Do not run `./northstar` in PowerShell; that file is the macOS/Linux launcher.
The Windows launcher uses Windows PowerShell to start Northstar on your computer at
<http://localhost:8765/> and opens it in your default browser. It does not
require Python, Node.js, npm, or an installation step.

If port 8765 is already being used by an older Northstar window, the launcher
automatically selects the next available port and opens that address. You can
also request another starting port from PowerShell:

```powershell
.\northstar.cmd 8878
```

## macOS and Linux

From a terminal opened in the downloaded repository folder, run:

```bash
./northstar
```

## Browser

On Windows, the launcher uses the included `northstar.ps1` server and opens
<http://localhost:8765/>. On macOS and Linux, the launcher opens
<http://127.0.0.1:8765/>. Keep the terminal open and press **Ctrl+C** to stop it.

The following server options are available on macOS and Linux:

```text
--port 9000       Use another local port
--no-browser      Do not open a browser automatically
```

The `northstar` launcher is executable after cloning. If ZIP extraction removes
its executable permission, restore it once with `chmod +x northstar`, then run
`./northstar`. The older `scan-ledger` command remains as a compatibility alias.

## Troubleshooting an old or offline-looking copy

If the browser address starts with `file:///` or contains `AppData/Local/Temp`
and a `.zip` filename, the dashboard was opened from a ZIP preview instead of
through Northstar. Extract the entire ZIP, confirm `northstar.cmd`,
`northstar.ps1`, and `northstar.js` are present, then double-click
`northstar.cmd`. The current UI
shows a **BUILD 07.29** badge and a warning whenever it detects direct file use.

If the page still shows only dashes, close every older Northstar terminal window
before launching again. The current Windows launcher detects a busy port and
automatically opens a fresh copy on the next available port (for example, 8766).
