package utils

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func Ask(question string) bool {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print(question + " ")
	text, _ := reader.ReadString('\n')
	return strings.TrimSpace(strings.ToLower(text)) == "y"
}

func AskOrAutoYes(question string, autoYes bool) bool {
	if autoYes {
		fmt.Println(question + " y (auto)")
		return true
	}
	reader := bufio.NewReader(os.Stdin)
	fmt.Print(question + " ")
	text, _ := reader.ReadString('\n')
	return strings.TrimSpace(strings.ToLower(text)) == "y"
}

func AskOS() string {
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("🖥️  Which OS are you setting up?")
	fmt.Println("  1) Linux")
	fmt.Println("  2) macOS")
	fmt.Print("Enter choice (1 or 2): ")
	text, _ := reader.ReadString('\n')
	if strings.TrimSpace(text) == "2" {
		fmt.Println("→ macOS selected")
		return "mac"
	}
	fmt.Println("→ Linux selected")
	return "linux"
}
