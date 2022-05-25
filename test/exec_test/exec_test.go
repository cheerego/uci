package main

//func TestName(t *testing.T) {
//	cmd := exec.Command("curl", "-o", "go1.15.6.linux-amd64.tar.gz", "https://dl.google.com/go/go1.15.6.linux-amd64.tar.gz")
//	err := cmd.Start()
//	if err != nil {
//		t.Fatal(err)
//	}
//	time.Sleep(20 * time.Second)
//
//	// The Credential fields are used to set UID, GID and attitional GIDS of the process
//	// You need to run the program as  root to do this
//	var cred = &syscall.Credential{UID, GUID, []uint32{}}
//	// the Noctty flag is used to detach the process from parent tty
//	var sysproc = &syscall.SysProcAttr{Credential: cred, Noctty: true}
//	var attr = os.ProcAttr{
//		Dir: ".",
//		Env: os.Environ(),
//		Files: []*os.File{
//			os.Stdin,
//			nil,
//			nil,
//		},
//		Sys: sysproc,
//	}
//	process, err := os.StartProcess("/bin/sleep", []string{"/bin/sleep", "100"}, &attr)
//	if err == nil {
//
//		// It is not clear from docs, but Realease actually detaches the process
//		err = process.Release()
//		if err != nil {
//			fmt.Println(err.Error())
//		}
//
//	} else {
//		fmt.Println(err.Error())
//	}
//
//}
