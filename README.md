# Rails Frontend: scan-to-pay prototype

A 2020 Rails prototype of a QR "scan to pay" flow:

`home` → `scanner` (camera reads a QR code) → `confirmation` → `pin` → `summary`

## Run locally

Requires Ruby 2.6.3 (see `.ruby-version`), Bundler and Yarn.

```bash
bundle install
yarn install
bin/rails server     # http://localhost:3000
bin/rails test       # controller tests
```

## Notes

- **Camera access needs HTTPS.** Browsers only allow `getUserMedia` on `https://` or `localhost`, so testing on a phone over plain `http://` on your network will fail. Use a tunnel such as ngrok, or a local certificate.
- **QR library.** Instascan is served from `public/js/instascan.min.js` (MIT licence in `public/js/instascan.LICENSE.txt`). The original rawgit.com URL stopped working when RawGit shut down. Instascan is no longer maintained; replace it with a maintained library before any real use.
- **Scanned content** is passed between pages through `sessionStorage` and displayed with `textContent`, so a malicious QR code cannot inject HTML.
- **PIN** is submitted by POST and filtered from logs (`config/initializers/filter_parameter_logging.rb`). This is a demo: nothing is charged and the PIN is only format-checked.
- **Stack age.** Ruby 2.6 and Rails 5.2 are past end of life. Upgrade before deploying anywhere public.
