package cmd

import (
	"fmt"
	"os"
	"os/exec"

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

		if utils.AskOrAutoYes("Do you want to configure Git globally? (y/n)", assumeYes) {
			runScript("scripts/git.sh")
		}
		if utils.AskOrAutoYes("Do you want to install Docker? (y/n)", assumeYes) {
			runScript("scripts/docker.sh")
		}
		if utils.AskOrAutoYes("Do you want to install ZSH + Oh My Zsh + Powerlevel10k? (y/n)", assumeYes) {
			runScript("scripts/zsh.sh")
		}
		if utils.AskOrAutoYes("Do you want to install Go (Golang)? (y/n)", assumeYes) {
			runScript("scripts/golang.sh")
		}
		if utils.AskOrAutoYes("Do you want to install Node.js (via nvm)? (y/n)", assumeYes) {
			runScript("scripts/node.sh")
		}

		fmt.Println("\n🎉 All done! Time to build something awesome.")
		fmt.Println("Arthur approves this setup. ✨")
		fmt.Println("     ---- 😎 ----" + "\n")
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

	runCmd.Flags().BoolVarP(&assumeYes, "yes", "y", false, "Automatically answer 'yes' to all prompts")
}
