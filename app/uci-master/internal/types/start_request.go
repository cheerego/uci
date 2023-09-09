package types

type StartRequest struct {
	GitRepoUsername string
	GitRepoPassword string
	GitRepoUrl      string
	GitCiFilePath   string
	GitSha          string

	CiFileContent string

	Event EventType
}
