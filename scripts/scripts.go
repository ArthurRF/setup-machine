package scripts

import _ "embed"

//go:embed curl.sh
var CurlScript string

//go:embed docker.sh
var DockerScript string

//go:embed zsh.sh
var ZshScript string

//go:embed node.sh
var NodeScript string

//go:embed git.sh
var GitScript string

//go:embed golang.sh
var GolangScript string
