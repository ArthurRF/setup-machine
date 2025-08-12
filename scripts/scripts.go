package scripts

import _ "embed"

//go:embed curl.sh
var CurlScript string

//go:embed docker.sh
var DockerScript string

//go:embed allow-docker-run.sh
var AllowDockerRunScript string

//go:embed zsh.sh
var ZshScript string

//go:embed install-zsh-plugins.sh
var ZshPluginsScript string

//go:embed node.sh
var NodeScript string

//go:embed git.sh
var GitScript string

//go:embed golang.sh
var GolangScript string

//go:embed vscode.sh
var VscodeScript string

//go:embed insomnia.sh
var InsomniaScript string

//go:embed add-killport.sh
var AddKillportScript string

//go:embed vim.sh
var VimScript string
