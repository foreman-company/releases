# foreman-company/releases

Distribution artifacts for Foreman. Binaries are published as **GitHub Release assets**
(not committed to the tree, to avoid git-history bloat).

## Cloud runtime
Provisioned VMs download + extract a single bundle on first boot
(`FOREMAN_RUNTIME_BUNDLE_URL`):

- Latest: https://github.com/foreman-company/releases/releases/download/v1/foreman-runtime-linux-x64.tar.gz

The bundle contains `foreman-sidecar-linux-x64` + `schema.sql` (flat).
To cut a new version: build the linux-x64 sidecar, `tar czf` it with `schema.sql`,
then `gh release create vN ./foreman-runtime-linux-x64.tar.gz`.
