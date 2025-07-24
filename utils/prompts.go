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
