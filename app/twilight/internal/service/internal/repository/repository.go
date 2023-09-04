package repository

import (
	"github.com/cheerego/uci/app/twilight/internal/provider"
	"github.com/cheerego/uci/pkg/dao"
)

var Repositories *Repository

type Repository struct {
	RunnerRepository *dao.RunnerRepository
}

func NewRepository(runnerRepository *dao.RunnerRepository) *Repository {
	return &Repository{RunnerRepository: runnerRepository}
}

func Register() error {
	Repositories = NewRepository(
		dao.NewRunnerRepository(provider.MasterDB()),
	)
	return nil
}
