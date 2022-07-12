package report

type (
	ReportRawlogForm struct {
		Uuid string `json:"uuid"`
		Raw  string `json:"raw"`
		//Timestamp time.Time `json:"timestamp"`
	}

	ReportBuildRunning struct {
		Uuid        string `json:"uuid"`
		FailedCause string `json:"failedCause"`
	}
)

type (
	PipelineForm struct {
	}
)
