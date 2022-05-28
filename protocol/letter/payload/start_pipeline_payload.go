package payload

type StartPipelinePayload struct {
	WorkflowId uint32 `json:"workflowId"`
	PipelineId uint32 `json:"pipelineId"`
	Yaml       string `json:"yaml"`
	Salt       string `json:"salt"`
	//Envs       map[string]string `json:"envs"`
}
