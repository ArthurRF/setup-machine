package cmd

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/ArthurRF/setup-machine/utils"
	"github.com/spf13/cobra"
)

var runCmd = &cobra.Command{
	Use:   "run",
	Short: "Run interactive setup",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("⚙️  Welcome to your setup CLI!")

		if utils.Ask("Do you want to configure Git globally? (y/n)") {
			runScript("scripts/git.sh")
		}
		if utils.Ask("Do you want to install Docker? (y/n)") {
			runScript("scripts/docker.sh")
		}
		if utils.Ask("Do you want to install ZSH + Oh My Zsh + Powerlevel10k? (y/n)") {
			runScript("scripts/zsh.sh")
		}
		if utils.Ask("Do you want to install Go (Golang)? (y/n)") {
			runScript("scripts/golang.sh")
		}
		if utils.Ask("Do you want to install Node.js (via nvm)? (y/n)") {
			runScript("scripts/node.sh")
		}

		fmt.Println("✅ All done!")
	},
}

func runScript(path string) {
	cmd := exec.Command("sh", path)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		fmt.Printf("❌ Failed to run %s: %v\n", path, err)
	}
}

func init() {
	rootCmd.AddCommand(runCmd)
}
