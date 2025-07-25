package cmd

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/ArthurRF/setup-machine/scripts"
	"github.com/ArthurRF/setup-machine/utils"
	"github.com/spf13/cobra"
)

var assumeYes bool

func asciiArt() string {
	return `
╭──────────────────────────────────────────────╮
│  🤖  Arthur made this CLI to configure       │
│      his dev environment — enjoy!            │
╰──────────────────────────────────────────────╯
`
}

var runCmd = &cobra.Command{
	Use:   "run",
	Short: "Run interactive setup",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(asciiArt())

		if utils.AskOrAutoYes("Do you want to install curl? (y/n)", assumeYes) {
			runRawScript("curl.sh", scripts.CurlScript)
		}
		if utils.AskOrAutoYes("Do you want to configure Git globally? (y/n)", assumeYes) {
			runRawScript("git.sh", scripts.GitScript)
		}
		if utils.AskOrAutoYes("Do you want to install Docker? (y/n)", assumeYes) {
			runRawScript("docker.sh", scripts.DockerScript)
		}
		if utils.AskOrAutoYes("Do you want to install ZSH + Oh My Zsh + Powerlevel10k? (y/n)", assumeYes) {
			runRawScript("zsh.sh", scripts.ZshScript)
		}
		if utils.AskOrAutoYes("Do you want to install Go (Golang)? (y/n)", assumeYes) {
			runRawScript("golang.sh", scripts.GolangScript)
		}
		if utils.AskOrAutoYes("Do you want to install Node.js (via nvm)? (y/n)", assumeYes) {
			runRawScript("node.sh", scripts.NodeScript)
		}

		fmt.Println("\n🎉 All done! Time to build something awesome.")
		fmt.Println("Arthur approves this setup. ✨")
		fmt.Println("     ---- 😎 ----" + "\n")
	},
}

func runRawScript(name string, content string) {
	tmpFile, err := os.CreateTemp("", name)
	if err != nil {
		fmt.Printf("❌ Failed to create temp file: %v\n", err)
		return
	}
	defer os.Remove(tmpFile.Name())

	_, err = tmpFile.WriteString(content)
	if err != nil {
		fmt.Printf("❌ Failed to write to temp file: %v\n", err)
		return
	}

	err = tmpFile.Chmod(0777)
	if err != nil {
		fmt.Printf("❌ Failed to chmod temp file: %v\n", err)
		return
	}

	tmpFile.Close()

	cmd := exec.Command("sh", tmpFile.Name())
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		fmt.Printf("❌ Failed to run %s: %v\n", tmpFile.Name(), err)
	}
}

func init() {
	rootCmd.AddCommand(runCmd)

	runCmd.Flags().BoolVarP(&assumeYes, "yes", "y", false, "Automatically answer 'yes' to all prompts")
}
