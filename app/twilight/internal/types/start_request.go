package types

type StartRequest struct {
	GitUsername   string
	GitPassword   string
	GitHttpUrl    string
	GitCiFilePath string
	GitSha        string

	CiFileContent string

	Event EventType
}
