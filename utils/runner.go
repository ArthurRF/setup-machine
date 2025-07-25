package utils

import (
	"fmt"
	"os"
	"os/exec"
)

func RunRawScript(name string, content string) {
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
