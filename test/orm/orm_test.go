package orm

import (
	"fmt"
	"github.com/cheerego/uci/pkg/orm"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"log"
	"os"
	"testing"
	"time"
)

type Pipeline struct {
	orm.Model
	WorkflowId uint32
	Number     uint32
	Uuid       string
	Salt       string
	Yaml       string

	FirstDispatchedAt *orm.Time
	LastDispatchedAt  *orm.Time
	DispatchSucceedAt *orm.Time
	DispatchTimes     uint32

	RunnerId              uint32
	FirstBorrowRunnerAt   *orm.Time
	BorrowRunnerSucceedAt *orm.Time
	ReleaseRunnerAt       *orm.Time

	StartedAt *orm.Time
	ClosedAt  *orm.Time
	Duration  uint32

	TriggeredCause string
	FailedCause    string

	StatusMessage string
	RawLog        string

	//CurrentStep      string
}

func (p Pipeline) LogString() string {
	return fmt.Sprintf("workflow-%d-uuid-%s-pipeline-%d-%s", p.WorkflowId, p.Uuid, p.ID, p.Salt)
}

func TestGORM(t *testing.T) {

	g, err := gorm.Open(postgres.Open("host=postgres user=uci password=uci123 dbname=uci port=5432 sslmode=disable TimeZone=PRC"), &gorm.Config{
		SkipDefaultTransaction: true,
		Logger: logger.New(log.New(os.Stdout, "\r\n", log.LstdFlags), logger.Config{
			SlowThreshold:             200 * time.Millisecond,
			LogLevel:                  logger.Error,
			IgnoreRecordNotFoundError: true,
			Colorful:                  true,
		}),
	})
	t.Error(err)
	var m Pipeline
	err = g.Debug().Where("first_dispatched_at = ?", "2022-06-28 20:00:10").First(&m).Error
	t.Error(err)
	fmt.Println(m.FirstDispatchedAt.Location())
}
