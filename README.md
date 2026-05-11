# setup-machine

Interactive CLI to configure a fresh Linux dev environment. Built with Go + Cobra.

---

## Using the binary

### 1. Download

Grab the latest binary from the [Releases](https://github.com/ArthurRF/setup-machine/releases) page, or use `curl`:

```bash
curl -L https://github.com/ArthurRF/setup-machine/releases/latest/download/setup-machine -o setup-machine
chmod +x setup-machine
```

### 2. Run

The setup is split into two steps. **Step 1** must complete before you run `zsh`, and **Step 2** runs after.

**Step 1** — base tooling (curl, git, docker, zsh + Oh My Zsh + Powerlevel10k, vim, Go, Node.js via nvm):

```bash
./setup-machine step1
```

After step 1 finishes, switch to zsh:

```bash
zsh
```

**Step 2** — GUI/terminal extras (docker without sudo, VS Code, Insomnia, zsh plugins, killport script):

```bash
./setup-machine step2
```

When step 2 is done, set zsh as your default shell and restart:

```bash
chsh -s $(which zsh)
# restart your machine
```

### Skip prompts

Pass `-y` to auto-accept everything in a step:

```bash
./setup-machine step1 -y
./setup-machine step2 -y
```

---

## Forking / making changes

### Prerequisites

- Go 1.22+

### Clone and build

```bash
git clone https://github.com/ArthurRF/setup-machine.git
cd setup-machine
go build -o setup-machine .
```

### Project structure

```
.
├── main.go              # entrypoint
├── cmd/
│   ├── root.go          # root cobra command
│   └── run.go           # step1 and step2 subcommands
├── scripts/
│   ├── scripts.go       # embeds all .sh files
│   └── *.sh             # individual install scripts
└── utils/
    ├── prompts.go        # yes/no prompt helper
    └── runner.go         # script execution helper
```

### Adding a new tool

1. Create a shell script under `scripts/`, e.g. `scripts/mytool.sh`.
2. Embed it in `scripts/scripts.go` following the existing pattern.
3. Add a prompt + `utils.RunRawScript(...)` call in `cmd/run.go` (step1 or step2).
4. Rebuild: `go build -o setup-machine .`
