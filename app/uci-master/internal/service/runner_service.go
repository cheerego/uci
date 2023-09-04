package service

import (
	"context"
	"fmt"
	"github.com/cheerego/uci/app/uci-master/internal/provider"
	"github.com/cheerego/uci/app/uci-master/internal/service/internal/repository"
	"github.com/cheerego/uci/pkg/dao/model"
	"gorm.io/gorm"
	"io"
	"net/http"
)

type RunnerService struct {
}

func NewRunnerService() *RunnerService {
	return &RunnerService{}
}

func (r *RunnerService) FindById(ctx context.Context, id int64) (*model.Runner, error) {
	return repository.Repositories.RunnerRepository.FindById(ctx, id)
}

func (r *RunnerService) FindEnableRunners(ctx context.Context) ([]*model.Runner, error) {
	return r.FindRunnersByEnable(ctx, true)
}

func (r *RunnerService) FindDisableRunners(ctx context.Context) ([]*model.Runner, error) {
	return r.FindRunnersByEnable(ctx, true)
}

func (r *RunnerService) FindRunnersByEnable(ctx context.Context, enable bool) ([]*model.Runner, error) {
	return repository.Repositories.RunnerRepository.FindRunnersByEnable(ctx, enable)
}

func (r *RunnerService) PickOneEnableRunner(ctx context.Context) (*model.Runner, error) {
	runners, err := r.FindEnableRunners(ctx)
	if err != nil {
		return nil, err
	}
	if len(runners) == 0 {
		return nil, gorm.ErrRecordNotFound
	}
	return runners[0], nil
}

func (r *RunnerService) FetchRunnerConfig(ctx context.Context, runner *model.Runner) (string, error) {
	request, err := http.NewRequest(http.MethodGet, fmt.Sprintf("http://%s:%d", runner.Host, runner.Port), nil)
	if err != nil {
		return "", err
	}
	request.WithContext(ctx)
	response, err := provider.RunnerClient().Do(request)
	if err != nil {
		return "", err
	}
	defer response.Body.Close()

	body, err := io.ReadAll(response.Body)
	if err != nil {
		return "", err
	}
	return string(body), err
}
