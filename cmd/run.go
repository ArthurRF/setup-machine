package cmd

import (
	"fmt"
	"os"

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

		osType := utils.AskOS()
		env := []string{"OS_TYPE=" + osType}

		if osType == "mac" {
			utils.RunRawScriptWithEnv("homebrew.sh", scripts.HomebrewScript, env)
			// Ensure brew is in PATH for all subsequent scripts (Apple Silicon: /opt/homebrew, Intel: /usr/local)
			env = append(env, "PATH=/opt/homebrew/bin:/usr/local/bin:"+os.Getenv("PATH"))
		}

		if utils.AskOrAutoYes("Do you want to install curl? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("curl.sh", scripts.CurlScript, env)
		}
		if utils.AskOrAutoYes("Do you want to configure Git globally? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("git.sh", scripts.GitScript, env)
		}
		if utils.AskOrAutoYes("Do you want to install Docker? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("docker.sh", scripts.DockerScript, env)
		}
		if utils.AskOrAutoYes("Do you want to install ZSH + Oh My Zsh + Powerlevel10k? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("zsh.sh", scripts.ZshScript, env)
		}
		if utils.AskOrAutoYes("Do you want to install Vim? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("vim.sh", scripts.VimScript, env)
		}
		if utils.AskOrAutoYes("Do you want to install Go (Golang)? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("golang.sh", scripts.GolangScript, env)
		}
		if utils.AskOrAutoYes("Do you want to install Node.js (via nvm)? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("node.sh", scripts.NodeScript, env)
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
		osType := utils.AskOS()
		env := []string{"OS_TYPE=" + osType}

		if osType == "mac" {
			env = append(env, "PATH=/opt/homebrew/bin:/usr/local/bin:"+os.Getenv("PATH"))
		}

		if utils.AskOrAutoYes("Do you want to allow docker to run without sudo? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("allow-docker-run.sh", scripts.AllowDockerRunScript, env)
		}

		if utils.AskOrAutoYes("Do you want to install Visual Studio Code? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("vscode.sh", scripts.VscodeScript, env)
		}

		if utils.AskOrAutoYes("Do you want to install Bruno (REST client)? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("bruno.sh", scripts.BrunoScript, env)
		}

		if utils.AskOrAutoYes("Do you want to install the ZSH important plugins? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("install-zsh-plugins.sh", scripts.ZshPluginsScript, env)
		}

		if utils.AskOrAutoYes("Do you want to add the killport script? (y/n)", assumeYes) {
			utils.RunRawScriptWithEnv("add-killport.sh", scripts.AddKillportScript, env)
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
