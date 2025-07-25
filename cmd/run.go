package cmd

import (
	"fmt"

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

var runStep1Cmd = &cobra.Command{
	Use:   "step1",
	Short: "Run the first step of the interactive setup",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(asciiArt())

		if utils.AskOrAutoYes("Do you want to install curl? (y/n)", assumeYes) {
			utils.RunRawScript("curl.sh", scripts.CurlScript)
		}
		if utils.AskOrAutoYes("Do you want to configure Git globally? (y/n)", assumeYes) {
			utils.RunRawScript("git.sh", scripts.GitScript)
		}
		if utils.AskOrAutoYes("Do you want to install Docker? (y/n)", assumeYes) {
			utils.RunRawScript("docker.sh", scripts.DockerScript)
		}
		if utils.AskOrAutoYes("Do you want to install ZSH + Oh My Zsh + Powerlevel10k? (y/n)", assumeYes) {
			utils.RunRawScript("zsh.sh", scripts.ZshScript)
		}
		if utils.AskOrAutoYes("Do you want to install Go (Golang)? (y/n)", assumeYes) {
			utils.RunRawScript("golang.sh", scripts.GolangScript)
		}
		if utils.AskOrAutoYes("Do you want to install Node.js (via nvm)? (y/n)", assumeYes) {
			utils.RunRawScript("node.sh", scripts.NodeScript)
		}

		fmt.Println("\n🎉 First step complete!")
		fmt.Println("Now it's time to run `zsh` to configure your terminal!")
		fmt.Println("After that, remember to run setup-machine step2 to finish the setup.")
		fmt.Println("     ---- 😎 ----")
	},
}

var runStep2Cmd = &cobra.Command{
	Use:   "step2",
	Short: "Run the second step of the interactive setup",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Allowing docker to run without sudo...")

		utils.RunRawScript("allow-docker-run.sh", scripts.AllowDockerRunScript)

		if utils.AskOrAutoYes("Do you want to install Visual Studio Code? (y/n)", assumeYes) {
			utils.RunRawScript("vscode.sh", scripts.VscodeScript)
		}

		if utils.AskOrAutoYes("Do you want to install Insomnia? (y/n)", assumeYes) {
			utils.RunRawScript("insomnia.sh", scripts.InsomniaScript)
		}

		if utils.AskOrAutoYes("Do you want to install the ZSH important plugins? (y/n)", assumeYes) {
			utils.RunRawScript("install-zsh-plugins.sh", scripts.ZshPluginsScript)
		}

		fmt.Println("")
		fmt.Println("\n🎉 Second step complete!")
		fmt.Println("Enjoy the setup and create great projects.")
		fmt.Println("")
		fmt.Println("***************************************************************************")
		fmt.Println("*****           REMEMBER TO RUN `chsh -s $(which zsh)` AND            *****") 
		fmt.Println("*****       RESTART YOUR MACHINE TO APPLY THE TERMINAL SETTINGS       *****")
		fmt.Println("*********************************** 😎 ************************************")
	},
}

func init() {
	rootCmd.AddCommand(runStep1Cmd)
	rootCmd.AddCommand(runStep2Cmd)

	runStep1Cmd.Flags().BoolVarP(&assumeYes, "yes", "y", false, "Automatically answer 'yes' to all prompts")
	runStep2Cmd.Flags().BoolVarP(&assumeYes, "yes", "y", false, "Automatically answer 'yes' to all prompts")
}
