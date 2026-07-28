# Scan Ledger

Scan Ledger is a private, local device-scan journal. Records remain in your
browser's local storage unless you explicitly export them.

## Windows

The project must first be downloaded or cloned onto your computer. The path
`/workspace/Braille-Game` belongs to the development environment and does not
exist on Windows.

1. Download this repository and extract the ZIP file.
2. Open the extracted `Braille-Game` folder.
3. Double-click **`scan-ledger.cmd`**.

Alternatively, open PowerShell inside the extracted folder and run:

```powershell
.\scan-ledger.cmd
```

Do not run `./scan-ledger` in PowerShell; that file is the macOS/Linux launcher.
The Windows launcher opens the local HTML app directly and does not require
Python or an installation step.

## macOS and Linux

From a terminal opened in the downloaded repository folder, run:

```bash
./scan-ledger
```

## Browser

On Windows, the launcher opens `scan-ledger.html` directly and its black window
closes after a few seconds. That is expected; the app remains open in the
browser. On macOS and Linux, the launcher opens <http://127.0.0.1:8765/>; keep
the terminal open and press **Ctrl+C** to stop it.

The following server options are available on macOS and Linux:

```text
--port 9000       Use another local port
--no-browser      Do not open a browser automatically
```
