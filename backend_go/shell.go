package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

var (
	output_path = filepath.Join("../output")
	bash_script = filepath.Join("outs")
)

func checkError(e error) {
	if e != nil {
		panic(e)
	}
}

func exe_cmd(cmds string) {
	err := os.MkdirAll(output_path, os.ModePerm|os.ModeDir)
	checkError(err)
	file, err := os.Create(filepath.Join(output_path, bash_script))
	checkError(err)
	defer file.Close()
	file.WriteString("#!/bin/bash\n")
	file.WriteString(cmds)
	err = os.Chdir(output_path)
	checkError(err)
	out, err := exec.Command("bash", bash_script).Output()
	checkError(err)
	fmt.Println(string(out))
	db(cmds, string(out))
}
