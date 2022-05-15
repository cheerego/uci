package model

import "gorm.io/gorm"

type Pipeline struct {
	gorm.Model
	Status        string
	TriggerUserId string
}

func (p *Pipeline) TableName() string {
	return "pipelines"
}
