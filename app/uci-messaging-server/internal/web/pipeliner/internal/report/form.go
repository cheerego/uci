package report

import (
	"github.com/cheerego/uci/app/uci-messaging-server/internal/model/pipeline"
)

type (
	ReportRawlogForm struct {
		Uuid string `json:"uuid"`
		Raw  string `json:"raw"`
		//Timestamp time.Time `json:"timestamp"`
	}

	ReportStatusForm struct {
		Uuid   string          `json:"uuid"`
		Status pipeline.Status `json:"status"`
		//Timestamp time.Time       `json:"timestamp"`
	}
)

type (
	PipelineForm struct {
	}
)
