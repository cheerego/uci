package daemon

import "github.com/spf13/cobra"

var UpCmd = &cobra.Command{
	Use:   "up",
	Short: "start a daemon for messaging",
	Long:  "start a daemon for messaging",
	Run: func(cmd *cobra.Command, args []string) {

	},
}
