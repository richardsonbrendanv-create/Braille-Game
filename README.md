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
Python 3 is required. The launcher displays a direct installation link if it
cannot find Python.

## macOS and Linux

From a terminal opened in the downloaded repository folder, run:

```bash
./scan-ledger
```

## Browser

The launcher opens <http://127.0.0.1:8765/> automatically. Keep its terminal
window open while using the app, and press **Ctrl+C** to stop it.

Options are available on every platform:

```text
--port 9000       Use another local port
--no-browser      Do not open a browser automatically
```
