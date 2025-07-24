package utils

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

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
