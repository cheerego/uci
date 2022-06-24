package report

import "github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"

type (
	ReportRawlogForm struct {
		Uuid string `json:"uuid"`
		Raw  string `json:"raw"`
	}

	ReportStatusForm struct {
		Uuid   string          `json:"uuid"`
		Status pipeline.Status `json:"status"`
	}
)

type (
	PipelineForm struct {
	}
)
